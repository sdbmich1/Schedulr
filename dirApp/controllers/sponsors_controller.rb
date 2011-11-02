class SponsorsController < ApplicationController
  def index
    @sponsors = Sponsor.all
  end

  def show
    @sponsor = Sponsor.find(params[:id])
  end

  def new
    @sponsor = Sponsor.new
  end

  def create
    @sponsor = Sponsor.new(params[:sponsor])
    if @sponsor.save
      redirect_to @sponsor, :notice => "Successfully created sponsor."
    else
      render :action => 'new'
    end
  end

  def edit
    @sponsor = Sponsor.find(params[:id])
  end

  def update
    @sponsor = Sponsor.find(params[:id])
    if @sponsor.update_attributes(params[:sponsor])
      redirect_to @sponsor, :notice  => "Successfully updated sponsor."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @sponsor = Sponsor.find(params[:id])
    @sponsor.destroy
    redirect_to sponsors_url, :notice => "Successfully destroyed sponsor."
  end
end
