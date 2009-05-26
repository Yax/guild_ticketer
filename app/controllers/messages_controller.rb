class MessagesController < ApplicationController
  before_filter :find_ticket, :only => [:index, :new, :create]
  before_filter :find_message, :except => [:index, :new, :create]
 
  layout 'tickets'

  def index
    @messages = @ticket.messages
  end

  def show
    @ticket = @message.ticket
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
      redirect_to(@ticket)
    else
      render :action => "new"
    end
  end

  #Not sure if it should be possible
  def update
    if @message.update_attributes(params[:message])
      flash[:notice] = "Wiadomość zaktualizowana"
      redirect_to(@message.ticket)
    else
      render :action => "edit"
    end
  end

  def destroy
    @message.destroy
    flash[:notice] = "Wiadomość usunięta"
    redirect_to(@message.ticket)
  end

  private
  def find_ticket
    @ticket_id = params[:ticket_id]
    return(redirect_to(tickets_url)) unless @ticket_id
    @ticket = Ticket.find(@ticket_id)
  end

  def find_message
    @message = Message.find(params[:id])
  end

end
