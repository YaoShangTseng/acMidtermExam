class MessagesController < ApplicationController

  before_action :authenticate_user!, :except => [:index]
  before_action :set_message, :only => [:show, :edit, :update, :destroy]

  def index
    @messages = Message.all

    apply_for_pages

  end

  def show
    @comments = @message.comments
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.save
      flash[:notice] = "建立成功"
      redirect_to messages_path
    else
      render 'new'
    end
  end

  def edit
    if @message.user != current_user
      flash[:alert] = "你不能編輯別人的求救文章喔"
      redirect_to messages_path
    end

  end

  def update
    if @message.update(message_params)
      flash[:notice] = "更新成功"
      redirect_to messages_path
    else
      render 'edit'
    end
  end

  def destroy

    if @message.user != current_user
      flash[:alert] = "你不能刪除別人的求救文章喔"
      redirect_to messages_path
    else
      @message.destroy
      flash[:alert] = "刪除成功"
      redirect_to messages_path
    end


  end


  protected

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:title, :content)
  end

  def apply_for_pages
    @messages = @messages.page(params[:page]).per(5)
  end

end
