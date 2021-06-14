require 'rails_helper'

describe 'gardens show page' do
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
    @plot_plant_16 = PlotPlant.create(plot: @plot_1, plant: @plant_10)
    visit "/gardens/#{@garden.id}"
  end
  it 'has a header' do
    expect(page).to have_content('Information for magic garden')
  end

  it 'lists garden name' do
    expect(page).to have_content('Garden Name: magic garden')
  end

  it 'lists organic status' do
    expect(page).to have_content('Is magic garden organic? true')
  end

  it 'has a unique list of plants in garden plots' do
    expect(page).to have_content('The following plants can be found at magic garden')
    expect(page).to have_content('potato', :count => 1)
    expect(page).to have_content('pea', :count => 1)
    expect(page).to have_content('swiss chard', :count => 1)
    expect(page).to have_content('broccoli', :count => 1)
    expect(page).to have_content('okra', :count => 1)
  end

  it 'does not include plants with harvest time over 100 days' do
    expect(page).not_to have_content('tomato')
    expect(page).not_to have_content('bell pepper')
    expect(page).not_to have_content('carrot')
  end

end