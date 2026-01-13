class DiariesController < ApplicationController
  before_action :set_diary, only: %i[ show edit update destroy ]

  # GET /diaries or /diaries.json
  def index
    @categories = Category.all

    @diaries = Diary.order(updated_at: :desc)

    #検索
    if params[:q].present? 
      @diaries = @diaries.where("title LIKE ? OR body LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end

    #カテゴリ
    if params[:category_id].present?
      @diaries = @diaries.where(category_id: params[:category_id])
    end

    @pagy, @diaries = pagy(@diaries, items: 5)
  end

  # GET /diaries/1 or /diaries/1.json
  def show
  end

  # GET /diaries/new
  def new
    @diary = Diary.new
  end

  # GET /diaries/1/edit
  def edit
  end

  # POST /diaries or /diaries.json
  def create
    @diary = Diary.new(diary_params)

    respond_to do |format|
      if @diary.save
        format.html { redirect_to @diary, notice: "メモを投稿しました" }
        format.json { render :show, status: :created, location: @diary }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diaries/1 or /diaries/1.json
  def update
    @diary.assign_attributes(diary_params)

    respond_to do |format|
      if @diary.update(diary_params)
        format.html { redirect_to @diary, notice: "メモを更新しました", status: :see_other }
        format.json { render :show, status: :ok, location: @diary }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diaries/1 or /diaries/1.json
  def destroy
    @diary.destroy!

    respond_to do |format|
      format.html { redirect_to diaries_path, notice: "メモを削除しました", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diary
      @diary = Diary.find(params[:id])
    end

    def diary_params
      params.require(:diary).permit(:title, :body, :category_id, :auto_delete)
    end
end
