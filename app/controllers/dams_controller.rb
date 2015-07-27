class DamsController < ApplicationController

	def index
		# If including count/fish data, includes will perform better
		@dams = Dam.includes(:fish_counts, :fish)
	end

	def show
		@dam = Dam.friendly.find(params[:id])
	end

end
