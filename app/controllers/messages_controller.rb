class MessagesController < ApplicationController
  before_filter :find_ticket, :only => [:index, :new, :create]
  before_filter :find_message, :except => [:index, :new, :create]
  
  def index
    @message = @ticket.messages
  end

  def show
  end

  def new
    @message = @ticket.messages.build
  end

  def edit
  end

  def create
    @message = @ticket.messages.build(params[:message])
    if @message.save
      flash[:notice] = "Wiadomość zapisana"
      redirect_to(@message)
    else
      render :action => "new"
    end
  end

  #Not sure if it should be possible
  def update
    if @message.update_attributes(params[:message])
      flash[:notice] = "Wiadomość zaktualizowana"
      redirect_to(@ticket)
    else
      render :action => "edit"
    end
  end

  def destroy
    @message.destroy
    flash[:notice] = "Wiadomość usunięta"
    redirect_to(ticket_messages_url)
  end

  private
  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def find_message
    @message = Message.find(params[:id])
  end

end
