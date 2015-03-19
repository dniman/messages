class MessagesController < ApplicationController
  def create
    #@message = Message.new(params[:message])
    #if @message.save
    @message = current_user.send_message(params[:message])
    if @message.new_record?
      flash[:notice] = "The message was saved successfully."
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end
end
