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
			name_and_date = node.css('title').inner_text
			name = extract_name(name_and_date)
			date = extract_date(name_and_date)
			
			puts node.css('description').inner_text
 		end

		
	end


	private 
    
    # Refactor this verboseness
	def extract_date(str)
		regex = /\d{1,2}\/\d{1,2}\/\d{4}/
		str["regex"]
	end

	def extract_name(str)
		regex = /\d{1,2}\/\d{1,2}\/\d{4}/
		str.gsub(regex, '').strip!
	end

end