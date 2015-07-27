class Dam < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_many :fish_counts
	has_many :fish, through: :fish_counts
	validates :name, presence: true, uniqueness: true
end
