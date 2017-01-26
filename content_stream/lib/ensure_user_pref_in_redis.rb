require 'recommendation_wrapper'

Content.all.each do |content|
  user_id = content.user_id
  article_id = content.article_id

  unless user_id
    puts "content #{content.id} is missing user_id"
    next
  end

  unless article_id
    puts "content #{content.id} is missing article_id"
    next
  end

  if content.rates == Content::RATE_LIKE
    RecommendationApiWrapper.like(article_id, user_id)
    puts "content liked: user #{user_id} article #{article_id}"
  else
    puts "content ignored: user #{user_id} article #{article_id} rates: #{content.rates}"
  end
end
