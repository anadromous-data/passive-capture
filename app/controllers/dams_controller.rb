class DamsController < ApplicationController

	def index
		@dams = Dam.all
	end

	def show
	end

end
