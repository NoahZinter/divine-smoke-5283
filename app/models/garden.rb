class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plot_plants

  def plants_under_100_days
    plants.where("days_to_harvest < ?", 100).distinct
  end
end
