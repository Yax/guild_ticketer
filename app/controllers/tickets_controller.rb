class TicketsController < ApplicationController
  before_filter :find_categories, :only => [:edit , :new]
  before_filter :find_ticket, :except => [ :new, :create, :index ]

  def index
    @tickets = Ticket.all
  end

  def show
    @category = @ticket.category
  end

  def new
    @ticket = Ticket.new
  end

  def edit
  end

  def create
    ticket = params[:ticket]
    ticket_type = Category.find_by_id(ticket[:category_id]).ticket_type
    eval "@ticket = #{ticket_type.capitalize}.new(params[:ticket])"
    if @ticket.save
      flash[:notice] = "ticket created."
      redirect_to(@ticket)
    else
      @categories = Category.find(:all)
      render :action => "new"
    end
  end

  def update
    if @ticket.update_attributes(params[@ticket[:type].downcase.to_sym])
      flash[:notice] = "Ticket updated."
      redirect_to(@ticket)
    else
      @categories = Category.find(:all)
      render :action => "edit"
    end
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket destroyed."
    redirect_to(tickets_url)
  end

  private
  def find_categories
    @categories = Category.find(:all)
  end

  def find_ticket
    @ticket = Ticket.find(params[:id])
  end

end

