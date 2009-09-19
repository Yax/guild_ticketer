class TicketsController < ApplicationController
  before_filter :find_categories, :only => [:edit , :new, :index]
  before_filter :find_ticket, :except => [ :new, :create, :index ]
  before_filter :set_filters

  def index
    scope = params[:scope]
    if !scope.blank? && @filters.include?(scope)
      @filters[scope] = 'active'
      @tickets = Ticket.method(scope.to_sym).call
      @scope = scope
    else
      @filters['all'] = 'active'
      @tickets = Ticket.pending + Ticket.opened + Ticket.closed
    end
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def edit
  end

  def create
    category = Category.find_by_id(params[:ticket][:category_id])
    unless category.nil?
      eval "@ticket = #{ category.ticket_type }.new(params[:ticket])"
    else
      @ticket = Ticket.new(params[:ticket])
    end
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
    @categories = Category.all
  end

  def find_ticket
    @ticket = Ticket.find(params[:id])
  end

end

