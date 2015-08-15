class FishController < ApplicationController

	def index
		@fishes = Fish.all
	end

	def show
		@fishes = Fish.all
		@fish = Fish.includes(:fish_counts).friendly.find(params[:id])
		@dam = Dam.includes(:fish_counts, :fish)
	end

end
