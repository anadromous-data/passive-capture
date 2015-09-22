require 'rails_helper'

describe "the dams views" do
  before(:all) do
    @dams = []
    3.times{ @dams << Fabricate(:dam)}
  end

  it 'should list the dam names on the index page' do
    visit dams_path
    @dams.each do |dam|
      page.should have_content(dam.name)
    end
  end
end