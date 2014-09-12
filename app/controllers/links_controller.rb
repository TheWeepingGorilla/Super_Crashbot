class LinksController < ApplicationController

  before_filter :authorize, only: [:new, :edit, :update, :destroy], :unless => :format_json?

  def index
    @links = Link.all

    respond_to do |format|
      format.html
      format.json { render :json => @links }
    end
  end

  def new
    @link = Link.new
  end

  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @link }
    end
  end


  def create
    @link = Link.new(link_params)
    if @link.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Link created."
          redirect_to links_path
        end
        format.json { render :json => @link, :status => 201 }
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.json { render :json => @link.errors, :status => 422 }
      end
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      flash[:notice] = "Link updated."
      redirect_to links_path
    else
      render 'edit'
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html do
        flash[:notice] = "Link deleted."
        redirect_to links_path
      end
      format.json { head :no_content }
    end
  end

  private
  def link_params
    params.require(:link).permit(:link, :vote, :rating, :date)
  end

end
