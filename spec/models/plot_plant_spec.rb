require 'rails_helper'

RSpec.describe PlotPlant, type: :model do
  describe 'relationships' do
    it { should belong_to(:plant) }
    it { should belong_to(:plot) }
  end

  describe 'class methods' do
    describe 'find by parent ids' do
      it 'finds plot_plant by parent ids' do
        Garden.destroy_all
        Plot.destroy_all
        Plant.destroy_all
        PlotPlant.destroy_all
        @garden = Garden.create!(name: 'magic garden', organic: 'true')
        @plot_1 = @garden.plots.create!(number: 1, size: 'small', direction: 'north')
        @plant_1 = Plant.create!(name:'tomato', description: 'tasty', days_to_harvest: 100)
        @plant_2 = Plant.create!(name:'potato', description: 'sweet', days_to_harvest: 10)
        @plant_3 = Plant.create!(name:'cabbage', description: 'crunchy', days_to_harvest: 20)
        @plot_plant_1 = PlotPlant.create!(plot: @plot_1, plant: @plant_1)
        @plot_plant_2 = PlotPlant.create!(plot: @plot_1, plant: @plant_2)
        @plot_plant_3 = PlotPlant.create!(plot: @plot_1, plant: @plant_3)

        expect(PlotPlant.find_by_parent_ids(@plot_1.id, @plant_3.id)).to eq(@plot_plant_3)
      end
    end
  end
end
