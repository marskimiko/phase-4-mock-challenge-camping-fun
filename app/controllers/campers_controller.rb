class CampersController < ApplicationController

  def index
    render json: Camper.all
  end

  def show
    camper_found = Camper.find_by_id( params[:id] )

    if camper_found
      render json: camper_found, serializer: CamperShowSerializer
    else
      render json: { error: "Camper not found" }, status: :not_found
    end
    # .find = instance in best case and except in worst case and
    # find_by gives instance in best case and nil in worst case (use truthy falsy logic)
  end

  def create 
    new_camper = Camper.create( new_camper_params )
    if new_camper.valid?
      render json: new_camper
    else
      render json: {
        "errors": new_camper.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def new_camper_params
    # strong params
    params.permit( :name, :age)
  end

end
