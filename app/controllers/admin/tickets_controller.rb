class Admin::TicketsController < ApplicationController
  before_filter :find_categories, :only => [:edit , :new, :index]
  before_filter :find_ticket, :except => [ :new, :create, :index, :any_new ]
  before_filter :set_filters, :set_types

  def index
    scope = params[:scope]
    tickets = Ticket.search()
    if !scope.blank? && @filters.has_key?(scope)
      @filters[scope] = 'active'
      tickets = tickets.search( scope.to_sym => true )
      @scope = scope
    else
      @filters['all'] = 'active'
    end
    
    type = params[:type]
    # TODO: should it raise error if type does not exist?
    if !type.blank? && @types.has_value?(type)
      tickets = tickets.category_id_eq(type)
      @type_selected = type
    end
    
    @tickets = tickets.all(:include => [:category, :last_message],
                           :order => 'basic_state_order ASC, `messages`.created_at DESC').paginate :page => params[:page]
    session[:last_seen] = Time.zone.now
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
    # TODO: catching wrong :type
    state_name = params[:type].match(/(.*)_event/)[1];
    state_name += '_transitions'
    data = Hash.new
    transitions = @ticket.send(state_name)
    transitions.each do |tr|
      data[tr.event] = tr.to_name
    end
    render :json => data, :status => :ok    
  end

  def any_new
    unless Ticket.find(:all,:conditions => ["created_at > ?", session[:last_seen] ], :limit => 1).empty?
      render :text => 'true', :status => :ok
    else
      render :text => 'false', :status => :ok
    end
  end

  private
  def find_categories
    @categories = Category.all
  end

  def find_ticket
    @ticket = Ticket.find(params[:id])
  end

end

