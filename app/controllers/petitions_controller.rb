class PetitionsController < ApplicationController
  before_action :authorize, only: [:new, :create]

  def index
    @petitions = Petition.all
    @petitions = @petitions.where(user: current_user) if params[:my]
  end

  def show
    @petition = Petition.find(params[:id])
  end

  def create
    petition = current_user.petitions.create(permitted_params)
    redirect_to petition
  end

  def new
    @petition = current_user.petitions.new
  end

  def upvote
  @petition = Petition.find(params[:id])
  @petition.votes.create(user_id: current_user.id)
  redirect_to(petitions_path)
  end

  def edit
    @petition = Petition.find(params[:id])
    render "new"
  end

  def update
    petition = Petition.find(params[:id])
    petition.update(permitted_params)
    redirect_to petition
  end

  def destroy
    petition = Petition.find(params[:id])
    petition.delete
    redirect_to petitions_path(my: true)
  end

  private

  def permitted_params
    params.require(:petition).permit(:id, :title, :description)
  end
end
