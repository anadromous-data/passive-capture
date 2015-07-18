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
			puts node.css('title').inner_text
			puts node.css('description').inner_text
 		end

		
	end

end