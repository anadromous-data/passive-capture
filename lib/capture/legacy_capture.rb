class LegacyCapture
	require 'csv'

	# Translate FPC reports to database objects
	
	def initialize(csv, dam_name)
		#Load initial csv, and fix
		crude = CSV.read("public/#{csv}.csv")
		fix_csv(crude)
		@report = CSV.read("public/ephemeral.csv", headers:true)
		@dam = extract_dam(dam_name)
	end

	def parse_to_db
		puts 'Hello'
		puts "#{@report}"

		@report.each do |fish_run|
			@date = extract_date(fish_run["Date"])

			begin
				@new_count = FishCount.new(dam_id: @dam_id, count_date: @date, fish_id: @fish_id, count: @fish_count)
				@new_count.save!
			rescue ActiveRecord::RecordInvalid => invalid
				puts invalid.record.errors
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

	def extract_date(str)
		Date.strptime(str, '%m/%d/%Y')
	end

	def extract_dam(dam_name)
		dam = (Dam.where("LOWER(name) LIKE ?", dam_name.downcase).first).id
	end

	def extract_species_array
	end

end