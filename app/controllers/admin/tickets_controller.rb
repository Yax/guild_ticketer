class Admin::TicketsController < ApplicationController
  before_filter :find_ticket_categories, :only => [:edit , :new, :index]
  before_filter :find_ticket, :except => [ :new, :create, :index, :any_new ]
  before_filter :set_filters, :set_types, :get_user_name

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
      tickets = tickets.ticket_category_id_eq(type)
      @type_selected = type
    end
    
    order = 'basic_state_order ASC, `messages`.from_client DESC, `messages`.created_at DESC'
    #@tickets = tickets.all(:include => [:ticket_category, :last_message], :order => order).paginate :page => params[:page]
    @tickets = tickets.all(:include => [:ticket_category, :last_message], :order => order).paginate :page => params[:page]
    session[:last_seen] = Time.zone.now
  end

  def show
    #@message = @ticket.messages.build
    @message = Message.new
    @message.ticket_id = @ticket.id
    @message.from = @user_name
  end

  def new
    @ticket = Ticket.new
    @ticket.employee_name = @user_name
    @ticket.messages.build('from'=>@user_name)
  end

  def edit
  end

  def create
    ticket_category_id = nil #without it in line below ticket_category_id doesn't get out of the block
    params.each { |k,v| ticket_category_id ||= v['ticket_category_id'] }
    ticket_category = TicketCategory.find_by_id(ticket_category_id) 
    unless ticket_category.nil?
      eval "@ticket = #{ ticket_category.ticket_type }.new(params[:ticket])"
      @ticket.ticket_category_id = ticket_category_id #because ticket_category_id is protected
    else
      @ticket = Ticket.new(params[:ticket])
      @ticket.ticket_category_id = TicketCategory.first.to_param #because ticket_category_id is protected
    end
    if @ticket.save
      flash[:notice] = "Zgłoszenie zapisane"
      redirect_to([:admin,@ticket])
    else
      find_ticket_categories
      render :action => "new"
    end
  end

  def update
    respond_to do |wants|
      ticket_type = @ticket[:type].downcase
      if @ticket.update_attributes(params[ticket_type])
        flash[:notice] = "Zgłoszenie zaktualizowane" unless request.xhr?
        wants.html { redirect_to([:admin,@ticket]) }
        if request.xhr?
          modified_parameter = params[ticket_type].keys[0]
          if modified_parameter =~ /(.*)_event/
            modified_parameter = $+
            parameter = sm_t(@ticket[modified_parameter])
          else
            parameter = @ticket[modified_parameter]
          end
        end
        wants.js { render :text => parameter,  :status => :ok }
      else
        @ticket_categories = TicketCategory.find(:all)
        wants.html { render :action => "edit" }
        wants.js { render :json => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Zgłoszenie usunięte"
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
      logger.info transitions.inspect
      data[tr.event] = sm_t(tr.to)
    end
    render :json => data, :status => :ok    
  end

  def any_new
    unless Message.find(:all,:conditions => ["created_at > ?", session[:last_seen] ], :limit => 1).empty?
      render :text => 'true', :status => :ok
    else
      render :text => 'false', :status => :ok
    end
  end

  private
  def find_ticket_categories
    @ticket_categories = TicketCategory.all
  end

  def find_ticket
    @ticket = Ticket.find(params[:id])
  end

  def sm_t(state)
    I18n.t('state_machine.'+state)
  end

end

