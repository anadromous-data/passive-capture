class FishController < ApplicationController

	def index
		@fishes = Fish.all.order(name: :asc)
	end

	def show
		@fishes = Fish.all.order(name: :asc)
		@fish = Fish.includes(:fish_counts).friendly.find(params[:id])
    @fish_counts = @fish.current_highest_counts
		@dam = Dam.includes(:fish_counts, :fish)
	end

	def edit
		@fish = Fish.friendly.find(params[:id])
	end
    
    def update
    	@fish = Fish.friendly.find(params[:id])
    	respond_to do |format|
      		if @fish.update(fish_params)
        		format.html { redirect_to @fish, notice: 'Fish was successfully updated.' }
        		format.json { head :no_content }
      		else
        		format.html { render action: 'edit' }
        		format.json { render json: @fish.errors, status: :unprocessable_entity }
      		end
    	end
  	end

	private 

	    def fish_params
	      params.require(:fish).permit(:name, :avatar)
	    end
end
