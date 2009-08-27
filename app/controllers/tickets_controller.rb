# encoding: utf-8

class TicketsController < ApplicationController
  before_filter :find_categories, :only => [:edit , :new, :create, :update]
  before_filter :find_ticket, :except => [ :new, :create, :index ]

  def index
    @tickets = Ticket.find(:all)
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
    @ticket = Ticket.new(params[:ticket])
    if @ticket.save
      flash[:notice] = "ticket created."
      redirect_to(@ticket)
    else
      render :action => "new"
    end
  end

  def update
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = "Ticket updated."
      redirect_to(@ticket)
    else
      render :action => "edit"
    end
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket usunięty"
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

