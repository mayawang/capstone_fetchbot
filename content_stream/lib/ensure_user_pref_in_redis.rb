require 'recommendation_wrapper'

USER_MAP = {}

def save_like(user_id, article_id)
  article = Article.find_by_id(article_id)
  user = USER_MAP[user_id] || User.find_by_id(user_id)

  unless user
    puts "NO user found for id #{user_id}"
    return
  end

  USER_MAP[user_id] = user

  unless article
    puts "NO article found for id #{article_id}"
    return
  end

  user.like(article)
end

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
    save_like(user_id, article_id)
    puts "content liked: user #{user_id} article #{article_id}"
  else
    puts "content ignored: user #{user_id} article #{article_id} rates: #{content.rates}"
  end
end

User.all.each do |user|
  puts "user: #{user.id}"
  Recommendable::Helpers::Calculations.update_similarities_for(user.id.to_s)
  Recommendable::Helpers::Calculations.update_recommendations_for(user.id.to_s)
  puts "recommended_articles:#{user.recommended_articles.inspect}"
end
