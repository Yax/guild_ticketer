class TicketsController < ApplicationController
  before_filter :find_categories, :only => [:edit , :create]

  def index
    @tickets = Ticket.find(:all)
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def create
    @ticket = Ticket.new(params[:ticket])
    if @ticket.save
      flash[:notice] = "Ticket created."
      redirect_to(@ticket)
    else
      render :action => "new"
    end
  end

  def update
    @ticket = Ticket.find(param[:id])
    if @ticket.update_attributes(param[:ticket])
      flash[:notice] = "Ticket updated."
      redirect_to(@ticket)
    else
      render :action => "edit"
    end
  end

  def destroy
    @ticket = Ticket.find(param[:id])
    if @ticket.destroy
      flash[:notice] = "Ticket deleted"
    end
    redirect_to(tickets_url)
  end

  private
  def find_categories
    @categories = Category.find(:all)
  end

end
