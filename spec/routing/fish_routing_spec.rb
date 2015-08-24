require 'rails_helper'

RSpec.describe FishCountsController, type: :routing do
  it { expect(get:    "/fish").to   route_to("fish#index") }
  it { expect(get:    "/fish/1").to route_to("fish#show", id: "1") }
end