class FishCount < ActiveRecord::Base
	belongs_to :fish 
	belongs_to :dam

	def format_date
    	self.date.strftime("%B %d, %Y")
    end

end
