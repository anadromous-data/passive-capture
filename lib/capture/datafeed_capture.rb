class DataFeedCapture
	require 'open-uri'
	require 'Nokogiri'

	def initialize
		# Snag FPC RSS
		@doc = Nokogiri::XML(open("http://www.fpc.org/rss/rssAdultCounts.aspx"))

		# Validate RSS consistency. Future versions should include a mailer that notifies admins if this is ever false
		# doc.xpath("//item").count == 14 ? true : false
	end



	def parse_to_db
		# Parse FPC report
		capture = @doc
		capture.css('item').each do |node|
			dam_name_and_date = node.css('title').inner_text
			@dam_id = extract_dam_id(dam_name_and_date)
			@date = extract_date(dam_name_and_date)

			# convert xml string to array of fish counts
			fish_species_and_count = node.css('description').inner_text.split(';') 
			fish_species_and_count.each do |feed_desc|

				@fish_id = extract_fish_species(feed_desc)
				@fish_count = extract_fish_count(feed_desc) 

				FishCount.create(dam_id: @dam_id, count_date: @date, fish_id: @fish_id, count: @fish_count)
			end
 		end
	end
end


private 
    
    # Refactor this verboseness
    # Extracting the Dam name and Date of count from the xml title
	def title_regex
		regex = /\d{1,2}\/\d{1,2}\/\d{4}/
	end

	def extract_date(str)
		date = str[title_regex]
		Date.strptime(date, '%m/%d/%Y')
	end

	def extract_dam_id(str)
		dam_name = str.gsub(title_regex, '').strip!
		dam_id = (Dam.where("LOWER(name) LIKE ?", dam_name.downcase).first).id
		return dam_id
	end

	# Extracting the species & count from the xml description
	def extract_fish_species(str)
		fish_name = str.split(/\d/).first.strip! # remove digits & whitespace to just name
		fish_id = (Fish.where("LOWER(name) LIKE ?", fish_name.downcase).first).id
		#item.match("Adult") ? true : false # confirm whether Adult or Jack Chinook
		return fish_id
	end

	def extract_fish_count(str)
		count = str[/\d{1,10}/]
		count.gsub(',','').to_i
	end
