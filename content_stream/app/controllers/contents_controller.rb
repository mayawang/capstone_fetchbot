require 'recommendation_wrapper'

class ContentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def search
    query = params[:q] || ''
    user_id = params[:uid] || 242
    test_mode = params[:test]

    if test_mode == "random"
      offset = rand(Article.count)
      recommended_articles = [
        Article.offset(offset).first
      ]
    else
      recommended_articles = RecommendationApiWrapper.get_recommendation(user_id, query)
    end

    items = []
    recommended_articles.each do |recommended_article|
      content = ensure_content(user_id, recommended_article)
      items << content.to_frontend_hash
    end

    response = {
      items: items
    }
    return render :json => response.as_json
  end

  def click
    # @user = User.new
    # @user.id = params[:uid]
    # @content = Content.new
    # @content.user_id = params[:uid]
    #
    # @user.save
  end

  def like
    user_id = params[:uid]
    content_id = params[:cid]

    content = Content.find_by_id(content_id)

    unless content
      puts "Unable to find content #{content_id}"
      return render :json => {item: []}.as_json
    end

    content.rates = Content::RATE_LIKE
    content.save

    return like_dislike_helper(user_id, content_id, true)
  end

  def dislike
    user_id = params[:uid]
    content_id = params[:cid]

    content = Content.find_by_id(content_id)

    unless content
      puts "Unable to find content #{content_id}"
      return render :json => {item: []}.as_json
    end

    content.rates = Content::RATE_DISLIKE
    content.save

    return like_dislike_helper(user_id, content_id, false)
  end

  def ensure_content(user_id, article)
    puts "ensure content for user_id #{user_id} #{article}"
    existing_content = Content.where({
      user_id: user_id,
      article_id: article.id,
    }).first

    return existing_content if existing_content

    return Content.create({
      user_id:      user_id,
      article_id:   article.id,
      title:        article.title,
      link:         article.link,
      summary:      article.summary,
      keywords:     article.keywords,
      text:         article.text,
    })
  end

  def like_dislike_helper(user_id, content_id, is_like)

    User.find_each do |user|
      user_id = user.id
    end

    user_id = params[:uid]
    content_id = params[:cid]

    content = Content.find_by_id(content_id)

    user = User.find_by_id(user_id)

    unless user
      puts "Unable to find user #{user_id}"
      return []
    end

    article_id = content.article_id

    unless article_id
      puts "content #{content_id} does not have article_id"
      content.delete
      return []
    end


    if is_like
      recommended_articles = RecommendationApiWrapper.like(article_id, user_id)
    else
      recommended_articles = RecommendationApiWrapper.dislike(article_id, user_id)
    end

    puts "recommended_articles: #{recommended_articles.inspect}"
    puts "user: #{user.id}"


    items = []
    recommended_articles.each do |recommended_article|
      puts "================================"
      puts recommended_article.inspect
      # create a new content for this user
      content = ensure_content(user_id, recommended_article)
      items << content.to_frontend_hash
    end

    response = {
      items: items
    }

    return render :json => response.as_json
  end

end
