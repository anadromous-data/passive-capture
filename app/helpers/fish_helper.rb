module FishHelper

  def find_dam(fish_count)
    Dam.find(fish_count.dam_id)
  end
  
end