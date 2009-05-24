class TicketsController < ApplicationController
  before_filter :find_categories, :only => [:edit , :new, :create, :update]

  def index
    @tickets = Ticket.find(:all)
  end

  def show
    @ticket = Ticket.find(params[:id])
    @category = @ticket.category
  end

  def new
    @ticket = Ticket.new
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def create
    @ticket = Ticket.new(params[:ticket])
    @category = Category.find(@ticket.category_id)
    # @ticket.category = @category
    if (@category.tickets << @ticket)
    # if @ticket.save
      flash[:notice] = "Ticket created."
      redirect_to(@ticket)
    else
      render :action => "new"
    end
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = "Ticket updated."
      redirect_to(@ticket)
    else
      render :action => "edit"
    end
  end

  def destroy
    ticket = Ticket.find(params[:id])
    category = ticket.category
    if category.tickets.destroy(ticket)
      flash[:notice] = "Ticket usunięty"
    end
    redirect_to(tickets_url)
    #@ticket = Ticket.find(param[:id])
    #if @ticket.destroy
    #  flash[:notice] = "Ticket deleted"
    #end
    #redirect_to(tickets_url)
  end

  private
  def find_categories
    @categories = Category.find(:all)
  end

end

