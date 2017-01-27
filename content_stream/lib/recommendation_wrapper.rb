require 'httparty'

class RecommendationApiWrapper
  ARTICLE_LIMIT = 3

  def self.accumulate_articles(article_hash, new_articles, limit)
    new_articles.each do |article|
      if article_hash.keys.length >= limit
        return
      end

      article_hash[article.id] = article
    end
  end

  def self.get_recommendation(user_id, query)
    user = User.find_by_id(user_id)
    unless user
      puts "unable to find user #{user_id}"
      return []
    end

    found_articles = {}
    title_matched = Article.where('title LIKE ?', "%#{query}%")

    self.accumulate_articles(found_articles, title_matched, ARTICLE_LIMIT)
    if found_articles.keys.length >= ARTICLE_LIMIT
      return found_articles.values[0, ARTICLE_LIMIT]
    end

    summary_matched = Article.where('summary LIKE ?', "%#{query}%")
    self.accumulate_articles(found_articles, summary_matched, ARTICLE_LIMIT)
    if found_articles.keys.length >= ARTICLE_LIMIT
      return found_articles.values[0, ARTICLE_LIMIT]
    end

    text_matched = Article.where('text LIKE ?', "%#{query}%")
    self.accumulate_articles(found_articles, text_matched, ARTICLE_LIMIT)
    if found_articles.keys.length >= ARTICLE_LIMIT
      return found_articles.values[0, ARTICLE_LIMIT]
    end

    puts "NO SEARCH RESULTS!!!! return recommandation articles"
    # if no text search results, try our luck with recommendations

    recommended = user.recommended_articles
    self.accumulate_articles(found_articles, recommended, ARTICLE_LIMIT)
    if found_articles.keys.length >= ARTICLE_LIMIT
      return found_articles.values[0, ARTICLE_LIMIT]
    end

    attempts = 0
    while found_articles.keys.length < ARTICLE_LIMIT
      offset = rand(Article.count)
      rand_article = Article.offset(offset).first
      self.accumulate_articles(found_articles, [rand_article], ARTICLE_LIMIT)

      if attempts > 2 * ARTICLE_LIMIT
        puts "After #{attempts} attempts, still cannot find enough articles, returning"
        break
      end
      attempts += 1
    end

    return found_articles.values[0, ARTICLE_LIMIT]
  end

  def self.clicked(content_id, user_id)

  end

  def self.like(article_id, user_id)
    article = Article.find_by_id(article_id)
    user = User.find_by_id(user_id)

    unless user
      puts "NO user found for id #{user_id}"
      return []
    end

    unless article
      puts "NO article found for id #{article_id}"
      return []
    end

    user.like(article)
    Recommendable::Helpers::Calculations.update_similarities_for(user.id.to_s)
    Recommendable::Helpers::Calculations.update_recommendations_for(user.id.to_s)
    return user.recommended_articles
=begin
    item_6 = {
      id: '6',
      title: "What Better Way for the Marines to Prepare for Future Wars Than With Sci-Fi?",
      link: 'https://www.wired.com/2017/01/better-way-marines-prepare-future-wars-sci-fi/',
      summary: 'The Singularity Summit approaches this weekend in New York. But the Microsoft cofounder and a colleague say the singularity itself is a long way off.',
      keywords: 'marines, Military, Sci-fi, Science Fiction',
      text: ''
    }

    return [item_6]
=end
  end

  def self.dislike(article_id, user_id)
    article = Article.find_by_id(article_id)
    user = User.find_by_id(user_id)

    unless user
      puts "NO user found for id #{user_id}"
      return []
    end

    unless article
      puts "NO article found for id #{article_id}"
      return []
    end

    # user.dislike(article)
    user.hide(article)
    Recommendable::Helpers::Calculations.update_similarities_for(user.id.to_s)
    Recommendable::Helpers::Calculations.update_recommendations_for(user.id.to_s)
    return user.recommended_articles
=begin
      item_7 = {
      id: '7',
      title: "Oscar Wilde and Walt Whitman Once Spent an Afternoon Together. Here's What Happened",
      link: 'https://newrepublic.com/article/119885/when-walt-whitman-met-oscar-wilde',
      summary: 'I come as a poet to call upon a poet, Wilde said, when Whitman opened his door.',
      keywords: 'History,Culture,Books,Oscar Wilde,Walt Whitman',
      text: ''
    }

    return [item_7]
=end
  end
end
