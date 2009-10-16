class Admin::MessagesController < ApplicationController
  before_filter :find_ticket, :only => [:new, :create]
  before_filter :find_message, :except => [:new, :create]
  before_filter :set_filters, :set_types #used in tickets layout
  before_filter :get_user_name
 
  layout 'admin/tickets'

  def show
    @ticket = @message.ticket
    respond_to do |wants|
      wants.html { render :partial => 'show', :layout => 'admin/tickets', :locals => { :message => @message } }
      wants.js { render :partial => 'show', :layout => false, :locals => { :message => @message } }
    end
  end

  def new
    @message = @ticket.messages.build
    @message.from = @user_name
  end

  def edit
    @ticket = @message.ticket
  end

  def create
    @message = @ticket.messages.build(params[:message])
    #create copy in case of transaction error
    message = @message.dup
    begin
      Message.transaction do
        @message.save!
        if params[:commit] =~ /stan/
          @ticket.update_attributes!(params[:ticket])
        end
      end
    rescue
      something_went_wrong = true
      flash.now[:warning] = @ticket.errors.full_messages.join(' ')
      @message = message unless @message.new_record?
      render :action => 'new'
    end
    unless something_went_wrong
      flash[:notice] = "Message created."
      redirect_to([:admin,@ticket])
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
