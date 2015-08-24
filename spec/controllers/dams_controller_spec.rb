require 'rails_helper'

RSpec.describe DamsController, type: :controller do

	let(:valid_attributes) {
    	{ name: "John Day Dam", slug: "john-day-dam", code: "jdy" }
  	}

	let(:invalid_attributes) {
    	{ name: nil, slug: "john-day-dam", code: 123 }
  	}

  	let!(:dam) { Dam.create(valid_attributes) }

  	describe "GET #index" do
    	it "assigns all dams as @dams" do
      		get :index
      		expect(assigns(:dams)).to eq([dam])
    	end
  	end

  	describe "GET #show" do
    	it "assigns the requested dam as @dam" do
      		get :show, { id: dam.id}
      		expect(assigns(:dam)).to eq(dam)
    	end
  	end


end