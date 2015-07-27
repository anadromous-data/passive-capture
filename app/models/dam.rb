class Dam < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	validates :name, presence: true, uniqueness: true

	has_many :fish_counts
	has_many :fish, through: :fish_counts

end
