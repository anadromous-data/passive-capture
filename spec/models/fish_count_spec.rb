require "rails_helper"


describe FishCount do

	it 'should order the counts in a year' do
		first_count = FishCount.create!(dam_id: 4, count_date: Date.today, fish_id: 1, count: 33)
    	second_count = FishCount.create!(dam_id: 4, count_date: Date.today.ago(1.month), fish_id: 1, count: 66)
    	third_count = FishCount.create!(dam_id: 4, count_date: Date.today.ago(1.year), fish_id: 1, count: 99)

    	expect(first_count.ordered_year_count).to eq([first_count, second_count])
	end
	
	it 'should find its previous count if exists, else return false' do
		first_count = FishCount.create!(dam_id: 4, count_date: Date.today, fish_id: 1, count: 33)
    	second_count = FishCount.create!(dam_id: 4, count_date: Date.today.ago(1.day), fish_id: 1, count: 66)
    	third_count = FishCount.create!(dam_id: 4, count_date: Date.today.ago(2.day), fish_id: 1, count: 99)

    	expect(first_count.last_count).to eq(66)
    	expect(second_count.last_count).to eq(99)
    	expect(third_count.last_count).to be false
    end

end