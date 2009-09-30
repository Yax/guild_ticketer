class Admin::TicketsController < ApplicationController
  before_filter :find_categories, :only => [:edit , :new, :index]
  before_filter :find_ticket, :except => [ :new, :create, :index ]
  before_filter :set_filters

  def index
    scope = params[:scope]
    if !scope.blank? && @filters.include?(scope)
      @filters[scope] = 'active'
      @tickets = Ticket.send(scope).paginate :page => params[:page]
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
      ticket_type = @ticket[:type].downcase
      if @ticket.update_attributes(params[ticket_type])
        flash[:notice] = "Ticket updated." unless request.xhr?
        wants.html { redirect_to([:admin,@ticket]) }
        if request.xhr?
          modified_parameter = params[ticket_type].keys[0]
          if modified_parameter =~ /(.*)_event/
            modified_parameter = $+
          end
        end
        wants.js { render :text => @ticket[modified_parameter],  :status => :ok }
      else
        @categories = Category.find(:all)
        wants.html { render :action => "edit" }
        wants.js { render :json => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket destroyed."
    redirect_to(admin_tickets_url)
  end

  def transitions
    # returns possible transitions and to_name for ticket
    # used in in-place-edit
    # params[:type] should have form state_name_event
    # line below extracts state_name form parameter
    state_name = params[:type].match(/(.*)_event/)[1];
    state_name += '_transitions'
    data = Hash.new
    transitions = @ticket.send(state_name)
    transitions.each do |tr|
      data[tr.event] = tr.to_name
    end
    render :json => data, :status => :ok    
  end

  private
  def find_categories
    @categories = Category.all
  end

  def find_ticket
    @ticket = Ticket.find(params[:id])
  end

end

