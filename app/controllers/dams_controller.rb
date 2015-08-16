class DamsController < ApplicationController

	def index
		@dams = Dam.all
	end

	def show
		@dams = Dam.all
		@dam = Dam.includes(:fish_counts, :fish).friendly.find(params[:id])
		@fish_counts = @dam.fish_counts.for_year(Date.today.year).limit(200).order(count_date: :desc).paginate(:page => params[:page], :per_page => 20)
	end

	def count_data
		@dam = Dam.includes(:fish_counts, :fish).friendly.find(params[:dam_id])
		fish_counts = @dam.fish_counts.for_year(Date.today.year).limit(15).order(count_date: :desc)
		@daily_total = fish_counts.where("count_date = ?", fish_counts.first.count_date)

		respond_to do |format|
			format.json {
				render json: @daily_total.to_json(:include => :fish)
			}
		end
	end
end
