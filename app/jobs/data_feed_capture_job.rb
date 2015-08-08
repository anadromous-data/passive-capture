class DataFeedCaptureJob
	extend HerokuResqueAutoscaler if Rails.env.production?
	require 'capture/datafeed_capture'

	def self.queue
		:datafeed_capture
	end
	
	def self.perform
		stream = DataFeedCapture.new
		puts "your mom" * 1000
		rails.logger.info(stream)
		stream.parse_to_db
	end
end