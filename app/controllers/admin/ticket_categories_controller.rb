class Admin::TicketCategoriesController < ApplicationController
  # GET /categories
  # GET /categories.xml
  def index
    @categories = TicketCategory.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = TicketCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = TicketCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = TicketCategory.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = TicketCategory.new(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'TicketCategory was successfully created.'
        format.html { redirect_to([:admin,@category]) }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = TicketCategory.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'TicketCategory was successfully updated.'
        format.html { redirect_to([:admin,@category]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = TicketCategory.find(params[:id])
    respond_to do |format|
      if @category.destroy
        format.html { redirect_to(admin_categories_url) }
        format.xml  { head :ok }
      else
        flash[:warning] = @category.errors.full_messages
        format.html { redirect_to(admin_categories_url) }
        format.xml  { head :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end
end
