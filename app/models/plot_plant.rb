class PlotPlant < ApplicationRecord
  belongs_to :plant
  belongs_to :plot

  def self.find_by_parent_ids(plot_id, plant_id)
    where("plot_id = ? AND plant_id = ?", plot_id, plant_id).first
  end
end
