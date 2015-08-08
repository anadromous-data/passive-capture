# resque initializer file

# Resque.redis = Redis.new(:url => 'http://localhost:6379')
# Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }

ENV["REDISTOGO_URL"] ||= ENV["redistogo_url"]

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)