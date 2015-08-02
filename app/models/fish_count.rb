class FishCount < ActiveRecord::Base
	belongs_to :fish 
	belongs_to :dam

	# Date validation will limit the feed to only pull in the first first per date.
	# Will need to refactor in order to validate all three fields are unique (fish, dam, date)
	validates :dam_id, presence: true
	validates :fish_id, presence: true
	validates :count_date, presence: true
	validates :count_date, :uniqueness => { :scope => [:dam_id, :fish_id] }

	def format_date
    	self.date.strftime("%B %d, %Y")
    end

    def previous_count

    end

end
