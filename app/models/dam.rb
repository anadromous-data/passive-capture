class Dam < ActiveRecord::Base
	extend FriendlyId
	require 'open-uri'
	friendly_id :name, use: :slugged
	validates :name, presence: true, uniqueness: true

	has_many :fish_counts
	has_many :fish, through: :fish_counts

	validates :name, presence: true, uniqueness: true

	def water_quality
		if self.code?
			puts "#{self.code}"
			string = URI.parse("http://www.nwd-wc.usace.army.mil/ftppub/water_quality/#{self.code}.txt")
			output = ""
			string.open {|f| f.each_line {|line| output << line + '<br/>'}}
			return output.html_safe
		else
			output = "No Water Quality Data Found"
		end
	end
end
