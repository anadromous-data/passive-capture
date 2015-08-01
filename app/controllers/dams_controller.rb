class DamsController < ApplicationController

	def index
		# If including count/fish data, includes will perform better
		@dams = Dam.all
	end

	def show
		@dam = Dam.includes(:fish_counts, :fish).friendly.find(params[:id])
	end

end
