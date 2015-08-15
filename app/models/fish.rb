class Fish < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_many :fish_counts
	
	validates :name, presence: true, uniqueness: true
end
