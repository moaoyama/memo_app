class AddAutoDeleteToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_column :diaries, :auto_delete, :boolean, default: false, null: false
  end
end
