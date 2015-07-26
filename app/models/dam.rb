class Dam < ActiveRecord::Base
	has_many :fish_counts
	validates :name, presence: true, uniqueness: true
end
