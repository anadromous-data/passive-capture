require 'rails_helper'

RSpec.describe DamsController, type: :routing do
  it { expect(get:    "/dams").to   route_to("dams#index") }
  it { expect(get:    "/dams/1").to route_to("dams#show", id: "1") }
end