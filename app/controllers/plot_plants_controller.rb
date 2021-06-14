class PlotPlantsController < ApplicationController
  def destroy
    PlotPlant.find_by_parent_ids(params[:plot_id], params[:plant_id]).destroy
    redirect_to "/plots"
  end
end