require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  describe 'instance methods' do
    before(:each) do
      Garden.destroy_all
      Plot.destroy_all
      Plant.destroy_all
      PlotPlant.destroy_all
      @garden = Garden.create!(name: 'magic garden', organic: 'true')
      @wrong_garden = Garden.create!(name: 'non-magic garden', organic: 'false')
      @plot_1 = @garden.plots.create!(number: 1, size: 'small', direction: 'north')
      @plot_2 = @garden.plots.create!(number: 2, size: 'small', direction: 'north')
      @plot_3 = @garden.plots.create!(number: 3, size: 'medium', direction: 'east')
      @plot_4 = @wrong_garden.plots.create!(number: 4, size: 'medium', direction: 'east')
      @plot_5 = @garden.plots.create!(number: 5, size: 'large', direction: 'west')
      @plot_6 = @wrong_garden.plots.create!(number: 6, size: 'large', direction: 'west')
      @plant_1 = Plant.create!(name:'tomato', description: 'tasty', days_to_harvest: 200)
      @plant_2 = Plant.create!(name:'potato', description: 'sweet', days_to_harvest: 10)
      @plant_3 = Plant.create!(name:'cabbage', description: 'crunchy', days_to_harvest: 20)
      @plant_4 = Plant.create!(name:'arugula', description: 'fruity', days_to_harvest: 30)
      @plant_5 = Plant.create!(name:'pea', description: 'smelly', days_to_harvest: 40)
      @plant_6 = Plant.create!(name:'swiss chard', description: 'odd', days_to_harvest: 50)
      @plant_7 = Plant.create!(name:'broccoli', description: 'green', days_to_harvest: 60)
      @plant_8 = Plant.create!(name:'okra', description: 'amazing', days_to_harvest: 70)
      @plant_9 = Plant.create!(name:'bell pepper', description: 'hot', days_to_harvest: 180)
      @plant_10 = Plant.create!(name:'carrot', description: 'cold', days_to_harvest: 120)
      @plot_plant_1 = PlotPlant.create!(plot: @plot_1, plant: @plant_1)
      @plot_plant_2 = PlotPlant.create!(plot: @plot_1, plant: @plant_9)
      @plot_plant_3 = PlotPlant.create!(plot: @plot_1, plant: @plant_6)
      @plot_plant_4 = PlotPlant.create!(plot: @plot_2, plant: @plant_9)
      @plot_plant_5 = PlotPlant.create!(plot: @plot_2, plant: @plant_8)
      @plot_plant_6 = PlotPlant.create!(plot: @plot_3, plant: @plant_7)
      @plot_plant_7 = PlotPlant.create!(plot: @plot_3, plant: @plant_6)
      @plot_plant_8 = PlotPlant.create!(plot: @plot_3, plant: @plant_5)
      @plot_plant_9 = PlotPlant.create!(plot: @plot_4, plant: @plant_4)
      @plot_plant_10 = PlotPlant.create!(plot: @plot_4, plant: @plant_3)
      @plot_plant_11 = PlotPlant.create!(plot: @plot_4, plant: @plant_2)
      @plot_plant_12 = PlotPlant.create!(plot: @plot_4, plant: @plant_1)
      @plot_plant_13 = PlotPlant.create!(plot: @plot_5, plant: @plant_2)
      @plot_plant_14 = PlotPlant.create!(plot: @plot_6, plant: @plant_3)
      @plot_plant_15 = PlotPlant.create!(plot: @plot_6, plant: @plant_4)
    end

    describe 'plants_under_100_days' do
      it 'does not return duplicates' do
        expect(@garden.plants_under_100_days).to eq([@plant_2, @plant_5, @plant_6, @plant_7, @plant_8])
        expect(@wrong_garden.plants_under_100_days).to eq([@plant_2, @plant_3, @plant_4])
      end

      it 'returns plants with harvest time under 100 days' do
        expected = @garden.plants_under_100_days

        expect((expected[0].days_to_harvest) < 100).to eq true
        expect((expected[1].days_to_harvest) < 100).to eq true
        expect((expected[2].days_to_harvest) < 100).to eq true
        expect((expected[3].days_to_harvest) < 100).to eq true
        expect((expected[4].days_to_harvest) < 100).to eq true
      end
    end
  end
end
