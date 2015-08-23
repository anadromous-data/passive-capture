class Fish < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_many :fish_counts
	validates :name, presence: true, uniqueness: true

	validates :avatar,
        attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
        attachment_size: { less_than: 5.megabytes }

    has_attached_file :avatar, 
        styles: {thumb: '100x100>', med: '600x240>', full: '1200x480>'}
end
