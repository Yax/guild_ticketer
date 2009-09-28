class Admin::TicketsController < ApplicationController
  before_filter :find_categories, :only => [:edit , :new, :index]
  before_filter :find_ticket, :except => [ :new, :create, :index ]
  before_filter :set_filters

  def index
    scope = params[:scope]
    if !scope.blank? && @filters.include?(scope)
      @filters[scope] = 'active'
      @tickets = Ticket.method(scope.to_sym).call.paginate :page => params[:page]
      @scope = scope
    else
      @filters['all'] = 'active'
      @tickets = Ticket.all.paginate :page => params[:page]
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
    @ticket.category_id = params[:ticket][:category_id] #because category_id is protected
    if @ticket.save
      flash[:notice] = "ticket created."
      redirect_to([:admin,@ticket])
    else
      find_categories
      render :action => "new"
    end
  end

  def update
    respond_to do |wants|
      if @ticket.update_attributes(params[@ticket[:type].downcase.to_sym])
        flash[:notice] = "Ticket updated."
        debugger
        wants.html { redirect_to([:admin,@ticket]) }
        wants.js { render :text => @ticket.method(params[:modified].match('\[(.*)\]')[1].to_sym).call,  :status => 200 }
      else
        @categories = Category.find(:all)
        wants.html { render :action => "edit" }
        wants.js {}
      end
    end
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket destroyed."
    redirect_to(admin_tickets_url)
  end

  private
  def find_categories
    @categories = Category.all
  end

  def find_ticket
    @ticket = Ticket.find(params[:id])
  end

end

