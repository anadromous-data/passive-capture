require 'open-uri'


class DataFeedCapture

	def create
		# Snag FPC RSS
		doc = Nokogiri::XML(open("http://www.fpc.org/rss/rssAdultCounts.aspx"))

		# Validate RSS consistency. Future versions should include a mailer that notifies admins if this is ever false
		doc.xpath("//item").count == 14 ? true : false
	end



	def parse_to_db(capture)
		# Parse FPC report
		capture.css('item').each do |node|
			dam_name_and_date = node.css('title').inner_text
			@dam_id = extract_dam_id(dam_name_and_date)
			@date = extract_date(dam_name_and_date)

			# convert xml string to array of fish counts
			fish_species_and_count = node.css('description').inner_text.split(';') 
			fish_species_and_count.each do |feed_desc|

				@fish_id = extract_fish_species(feed_desc)
				@fish_count = extract_fish_count(feed_desc) 

				Count.create (
					:dam_id = @dam_id
					:date = @date
					:fish_id = @fish_id
					:count = @fish_count
				)
			end
 		end
	end


	private 
    
    # Refactor this verboseness
    # Extracting the Dam name and Date of count from the xml title
	def extract_date(str)
		regex = /\d{1,2}\/\d{1,2}\/\d{4}/
		str[regex].to_date
	end

	def extract_dam_id(str)
		regex = /\d{1,2}\/\d{1,2}\/\d{4}/
		dam_name = str.gsub(regex, '').strip!
		dam_id = (Dam.find_by :name => dam_name).id
		return dam_id
	end

	# Extracting the species & count from the xml description
	def extract_fish_species(str)
		fish_name = item.split(/\d/).first.strip! # remove digits & whitespace to just name
		fish_id = (Fish.find_by :name => fish_name).id
		#item.match("Adult") ? true : false # confirm whether Adult or Jack Chinook
		return fish_id
	end

	def extract_fish_count(str)
		count = i[/\d{1,10}/]
		count.gsub(',','').to_i
	end

end