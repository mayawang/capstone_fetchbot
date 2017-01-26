require 'recommendation_wrapper'

User.all.each do |user|
  puts "user: #{user.id}"
  Recommendable::Helpers::Calculations.update_similarities_for(user.id.to_s)
  Recommendable::Helpers::Calculations.update_recommendations_for(user.id.to_s)
  puts "recommended_articles:#{user.recommended_articles.inspect}"
end
