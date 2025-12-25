class Diary < ApplicationRecord
  # 区切りタグの定義
  MORE_TAG = "<!--more-->".freeze
  AUTO_EXCERPT_LENGTH = 100
  belongs_to :category, optional: true

  def self.cleanup_expired
    expired_auto_delete.delete_all
  end
  
  # 抜粋(summary)
  def summary
    if body.include?(MORE_TAG)
      # 区切りタグがあればそこで切る
      body.split(MORE_TAG).first
    else
      # なければ一定文字数で自動抜粋
      body.truncate(AUTO_EXCERPT_LENGTH)
    end
  end

  # 全文
  def full_content
    # 区切りタグを削除して全文を返す
    body.gsub(MORE_TAG, "")
  end

  # 「続きを読む」が必要か判定
  def has_more?
    if body.include?(MORE_TAG)
      true  # ユーザーが手動で区切った場合
    else
      body.length > 100
    end
  end

  before_create :set_expires_at_if_auto_delete

  scope :expired_auto_delete, -> {
    where(auto_delete: true).where("expires_at <= ?", Time.current)
  }

  private

  def split_content
    @split_content ||= begin
      if body.include?(MORE_TAG)
        summary, full = body.split(MORE_TAG, 2)
          { summary: summary, full: full, has_more: true }
      else
        limit = 100
        if body.length > limit
          { summary: body[0...limit], full: body, has_more: true }
        else
          { summary: body, full: body, has_more: false }
        end
      end
    end
  end

  def set_expires_at_if_auto_delete
    if auto_delete? && expires_at.nil?
      self.expires_at = 30.minutes.from_now  
    end
  end

end
