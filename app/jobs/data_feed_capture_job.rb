class DataFeedCaptureJob
	require 'capture/datafeed_capture'

	def self.queue
		:datafeed_capture
	end
	
	def self.perform
		@stream = DataFeedCapture.new
		@stream.parse_to_db
	end
end