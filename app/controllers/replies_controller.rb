class RepliesController < ApplicationController
  def create
    @scheme  = Scheme.where(id: params[:scheme_id]).first
    @comment = @scheme.comments.where(id: params[:comment_id]).first
    @reply   = @comment.replies.create(reply_params)

    #binding.pry
    #<%= render comment.replies %>
    #TODO 确认是否需要转向
    redirect_to scheme_path(@scheme)
  end

  def destroy
    @scheme  = Scheme.where(id: params[:scheme_id]).first
    @comment = @scheme.comments.where(id: params[:comment_id]).first
    @reply   = @comment.replies.where(id: params[:id]).first

    @reply.destroy

    redirect_to scheme_path(@scheme)
  end

  def update
    @scheme  = Scheme.where(id: params[:scheme_id]).first
    @comment = @scheme.comments.where(id: params[:comment_id]).first
    @reply   = @comment.replies.where(id: params[:id]).first
    
    respond_to do |format|
      if @reply.update_attributes(reply_params)
        format.html { redirect_to scheme_path(@scheme), notice: 'Reply was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def reply_params
      params.require(:reply).permit(:content, :user_id)
    end
end
