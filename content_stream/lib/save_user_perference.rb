require 'recommendation_wrapper'

user_bookmark_file = "/Users/mengyao/capstone_fetchbot/crawler/pagecrawler/user_taggedbookmarks.dat"

line_number = 0

def fix_python_utf(text)
  if text.start_with?("[u'")
    text.delete("[u'")
    text.chomp("]")
  end
end

user_id_map = {}
article_id_map = {}

File.foreach(user_bookmark_file) do |f|
  row = f.chomp("\n").split("\t")

  line_number += 1

  if line_number < 80360
    next
  end

  user_id = row[0].to_i
  if user_id_map[user_id]
    user = user_id_map[user_id]
  elsif User.where(id: user_id).count() > 0
    # puts "user #{user_id} already exists"
    user = User.find_by_id(user_id)
    user_id_map[user_id] = user
  else
    user = User.create(id: user_id)
  end

  puts "line #{line_number}"

  article_id = row[1].to_i
  if article_id_map[article_id]
    article = article_id_map[article_id]
  else
    article = Article.find_by_id(article_id)
    if article
      article_id_map[article_id] = article
    end
  end

  next unless article

  # Fix article Python title, and text weirdness
  # [u'Kidsreads |']

  RecommendationApiWrapper.like(article_id, user_id)
  if Content.where(article_id: article_id, user_id: user_id).count() > 0
    puts "content already exists"
    next
  end

  content = Content.create(
    title: article.title,
    summary: article.summary,
    link: article.link,
    keywords: article.keywords,
    # text: article.text,
    rates: Content::RATE_LIKE,
    article_id: article_id,
    user_id: user_id
  )
  puts "content created: #{content.article_id} rates: #{content.rates}"
end
