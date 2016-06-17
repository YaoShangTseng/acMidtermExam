class MessageCommentsController < ApplicationController

  before_action :set_message

  def new
    @comment = @message.comments.new
  end

  def create
    @comment = @message.comments.new(comment_param)
    if @comment.save
      flash[:notice] = "建立成功"
      redirect_to message_path(@message)
    else
      render 'new'
    end

  end

  def edit
    @comment = @message.comments.find(params[:id])
  end

  def update
    @comment = @message.comments.find(params[:id])

    if @comment.update(comment_param)
      flash[:notice] = "更新成功"
      redirect_to message_path(@message)
    else
      render 'edit'
    end

  end

  def destroy
    @comment = @message.comments.find(params[:id])
    @comment.destroy

    flash[:alert] = "刪除成功"

    redirect_to message_path(@message)

  end

  protected

  def set_message
    @message = Message.find(params[:message_id])
  end

  def comment_param
    params.require(:comment).permit(:content)
  end

end
