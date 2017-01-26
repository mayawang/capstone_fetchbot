require 'redis'

Recommendable.configure do |config|
  # Recommendable's connection to Redis
  if ENV["REDISCLOUD_URL"]
    uri = URI.parse(ENV["REDISCLOUD_URL"])
    puts "using redis-cloud at #{uri}"
    config.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  else
    redis_host = ENV['REDIS_HOST'] || 'localhost'
    puts "using redis at #{redis_host}"
    config.redis = Redis.new(:host => redis_host, :port => 6379, :db => 0)
  end

  config.orm = :active_record

  # A prefix for all keys Recommendable uses
  config.redis_namespace = :recommendable

  # Whether or not to automatically enqueue users to have their recommendations
  # refreshed after they like/dislike an item
  config.auto_enqueue = true

  # The name of the queue that background jobs will be placed in
  config.queue_name = :recommendable

  # The number of nearest neighbors (k-NN) to check when updating
  # recommendations for a user. Set to `nil` if you want to check all
  # other users as opposed to a subset of the nearest ones.
  config.nearest_neighbors = 5
end
