class LegacyCapture
	require 'csv'

	# Translate FPC reports to database objects
	
	def initialize(csv, dam_name)
		#Load initial csv, and fix
		crude = CSV.read("public/#{csv}.csv")
		fix_csv(crude)
		@report = CSV.read("public/ephemeral.csv", headers:true)
		@dam_id = extract_dam(dam_name)
	end

	def parse_to_db
		@species = extract_species_array(@report)
		@report.each do |fish_run|
			@date = extract_date(fish_run["Date"])
			@species.each do |spc|
				@fish_id = extract_fish(spc) 
				@fish_count = (fish_run[spc]).to_i
				begin
					new_count = FishCount.new(dam_id: @dam_id, count_date: @date, fish_id: @fish_id, count: @fish_count)
					new_count.save!
				rescue ActiveRecord::RecordInvalid => invalid
					puts invalid.record.errors
				end
			end
		end
	end

	# Splits fish name headers so they can add to DB seamlessly
	def proper_headers(arr)
		arr.first.map! {|i| i.split(/(?=[A-Z])/).join(' ')}
	end

	#Pop off string, add space to headers, write to new file to be used
	def fix_csv(old_csv)
		old_csv.pop
		proper_headers(old_csv)
		CSV.open("public/ephemeral.csv", 'wb') do |write_crude|
			old_csv.each do |fix_csv|
				write_crude << fix_csv
			end
		end
	end

	# Create a Date object from a string as provided by FPC
	def extract_date(str)
		Date.strptime(str, '%m/%d/%Y')
	end

	def extract_fish(str)
		fish_id = (Fish.where("LOWER(name) LIKE ?", str.downcase).first).id
		return fish_id
	end

	# Find a Dam object through a string
	def extract_dam(dam_name)
		dam_id = (Dam.where("LOWER(name) LIKE ?", dam_name.downcase).first).id
		return dam_id
	end

	# Build an array of all species counted by a certain dam
	def extract_species_array(csv)
		@collect = []
		spc_arr = Fish.all.map {|fish| fish.name}
		csv.headers.each do |read_header|
			spc_arr.each do |read_fish|
				if read_header == read_fish
					@collect.push(read_header)
				end
			end
		end
		return @collect
	end
end