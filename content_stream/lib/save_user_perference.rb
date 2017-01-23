require 'recommendation_wrapper'

user_bookmark_file = "/Users/mengyao/capstone_fetchbot/crawler/pagecrawler/user_taggedbookmarks.dat"

File.foreach(user_bookmark_file) do |f|
  row = f.chomp("\n").split("\t")

  user_id = row[0].to_i
  if User.where(id: user_id).count() > 0
    # puts "user #{user_id} already exists"
    user = User.find_by_id(user_id)
  else
    user = User.create(id: user_id)
  end

  article_id = row[1].to_i
  article = Article.find_by_id(article_id)
  if article
    RecommendationApiWrapper.like(article_id, user_id)
    if Content.where(article_id: article_id, user_id: user_id).count() > 0
      puts "content already exists"
    else
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
  end


end
