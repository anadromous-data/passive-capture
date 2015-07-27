class LegacyCapture
	require 'csv'

	# Translate FPC reports to database objects
	
	def initialize(csv, dam_name)
		#Load initial csv, and fix
		crude = CSV.read("public/#{csv}.csv")
		fix_csv(crude)
		@report = CSV.read("public/ephemeral.csv", headers:true)
		@dam = (Dam.where("LOWER(name) LIKE ?", dam_name.downcase).first).id
	end

	def parse_to_db
		puts 'Hello'
		puts "#{@report}"

	end

	#date
	# Date.strptime(csv, '%m/%d/%Y')

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

end