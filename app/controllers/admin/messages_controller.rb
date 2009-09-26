class Admin::MessagesController < ApplicationController
  before_filter :find_ticket, :only => [:new, :create]
  before_filter :find_message, :except => [:new, :create]
  before_filter :set_filters #used in tickets layout
 
  layout 'admin/tickets'

  def show
    @ticket = @message.ticket
  end

  def new
    @message = @ticket.messages.build
    @message.from = @ticket.employee_name
  end

  def edit
    @ticket = @message.ticket
  end

  def create
    @message = @ticket.messages.build(params[:message])
    if @message.save
      flash[:notice] = "Message created."
      redirect_to([:admin,@ticket])
    else
      render :action => "new"
    end
  end

  #Not sure if it should be possible
  def update
    if @message.update_attributes(params[:message])
      flash[:notice] = "Message updated"
      redirect_to([:admin,@message.ticket])
    else
      render :action => "edit"
    end
  end

  def destroy
    @message.destroy
    flash[:notice] = "Message destroyed"
    redirect_to([:admin,@message.ticket])
  end

  private
  def find_ticket
    @ticket_id = params[:ticket_id]
    return(redirect_to(admin_tickets_url)) unless @ticket_id
    @ticket = Ticket.find(@ticket_id)
  end

  def find_message
    @message = Message.find(params[:id])
  end

end