class LinksController < ApplicationController

  before_filter :authorize, only: [:new, :edit, :update, :destroy]

  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      flash[:notice] = "Link created."
      respond_to do |format|
        format.html { redirect_to links_path }
        format.js
      end
    else
      render 'new'
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
    flash[:notice] = "Link deleted."
    redirect_to links_path
  end

  private
  def link_params
    params.require(:link).permit(:link, :vote, :rating, :date)
  end
end
