desc "This task is called by the Heroku scheduler add-on"
task :datafeed_capture => :environment do
  Resque.enqueue(DataFeedCaptureJob)
end
