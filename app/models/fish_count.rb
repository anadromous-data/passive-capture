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
    	self.date.strftime("%B %d, %Y")
    end

    def last_count
    	begin
    		count = FishCount.where('(count_date = ? AND fish_id = ? AND dam_id = ?)', self.count_date.ago(1.day), self.fish_id, self.dam_id).first.count
    	rescue 
    		return false
    	end
    end

end
