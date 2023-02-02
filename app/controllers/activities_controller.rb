class ActivitiesController < ApplicationController

  def index
    render json: Activity.all
  end
  
  def destroy
    
    found_activity = Activity.find_by_id( params[:id] )

    if found_activity
      found_activity.signups.destroy_all
      found_activity.destroy

      head :no_content
    else
      render json: {
        "error": "Activity not found"
      }, status: :not_found
    end
  end

end
