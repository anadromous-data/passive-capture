class DamsController < ApplicationController

	def index
		# If including count/fish data, includes will perform better
		@dams = Dam.all
	end

	def show
		@dams = Dam.all
		@dam = Dam.includes(:fish_counts, :fish).friendly.find(params[:id])
		@fish_counts = FishCount.for_year(Date.today.year).where("dam_id =?", @dam.id).limit(200).order(count_date: :desc).paginate(:page => params[:page], :per_page => 20)
	end

end
