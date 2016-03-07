class PetitionsController < ApplicationController

  def index
    @petitions = Petition.all
    render text: @petitions.map {|p| "#{p.name}: #{p.description}, #{p.author}"}.join("<br/>")
  end

  def create
    @petitions = Petition.create(petition_params)
    @petitions.save
    redirect_to "index"
    #render text: "petition created"
  end

  private

  def petition_params
    params.require(:petition).permit(:name, :description)
  end
end
