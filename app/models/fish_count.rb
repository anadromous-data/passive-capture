class FishCount < ActiveRecord::Base
	belongs_to :fish 
	belongs_to :dam

	validates :date, presence: true, uniqueness: true

	def format_date
    	self.date.strftime("%B %d, %Y")
    end

end
