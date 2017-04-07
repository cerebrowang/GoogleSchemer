class CommentsController < ApplicationController

  # POST
  def create
    @scheme = Scheme.where(id: params[:scheme_id]).first
    @comment = @scheme.comments.create(comment_params)
    redirect_to scheme_path(@scheme)
  end

  # DELETE
  def destroy
    @scheme = Scheme.where(id: params[:scheme_id]).first
    @comment = @scheme.comments.where(id: params[:id]).first
    @comment.destroy
    redirect_to scheme_path(@scheme)
  end

  # PATCH/PUT
  def update
    @scheme = Scheme.where(id: params[:scheme_id]).first
    @comment = @scheme.comments.where(id: params[:id]).first

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to scheme_path(@scheme), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def reply
    @scheme = Scheme.where(id: params[:scheme_id]).first
    @comment = @scheme.comments.where(id: params[:id]).first    
    @reply = @comment.replies.build

    redirect_to scheme_path(@scheme)
  end

  def nothelpful
    @scheme = Scheme.where(id: params[:scheme_id]).first
    @comment = @scheme.comments.where(id: params[:id]).first

    #TODO 添加 nothelpful 逻辑
    redirect_to scheme_path(@scheme)
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id)
    end
end
