class FishCount < ActiveRecord::Base
	belongs_to :fish 
	belongs_to :dam

	# Date validation will limit the feed to only pull in the first first per date.
	# Will need to refactor in order to validate all three fields are unique (fish, dam, date)
	validates :dam_id, presence: true
	validates :fish_id, presence: true
	validates :count_date, presence: true
	validates :count_date, :uniqueness => { :scope => [:dam_id, :fish_id] }

	scope :for_year, lambda {|year| where("count_date >= ? and count_date <= ?", "#{year}-01-01", "#{year}-12-31")}


	def format_date
    	self.count_date.strftime("%B %d, %Y")
    end

    #orders the scoped year by count_date
    def ordered_year_count
    	FishCount.for_year(Date.today.year).order(count_date: :desc)
    end

    #returns the last count for that species -- is the run is increasing or decreasing
    #could be cleaner...?
    def last_count
    	ordered_count = self.ordered_year_count.where("dam_id = ? AND fish_id = ?", self.dam_id, self.fish_id)
    	range = ordered_count.where(:count_date => self.count_date.ago(1.week)..self.count_date)
    	begin
    		count = range[1].count
    	rescue
    		return false
    	end
    end

end
