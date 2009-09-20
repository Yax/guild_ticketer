class MessagesController < ApplicationController
  before_filter :find_ticket, :only => [:new, :create]
  before_filter :find_message, :except => [:new, :create]
  before_filter :set_filters #used in tickets layout
 
  layout 'tickets'

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
      flash[:notice] = "Message created."
      redirect_to(@ticket)
    else
      render :action => "new"
    end
  end

  #Not sure if it should be possible
  def update
    if @message.update_attributes(params[:message])
      flash[:notice] = "Message updated"
      redirect_to(@message.ticket)
    else
      render :action => "edit"
    end
  end

  def destroy
    @message.destroy
    flash[:notice] = "Message destroyed"
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
