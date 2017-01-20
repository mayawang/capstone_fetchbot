require 'recommendation_wrapper'

class ContentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def search
    query = params[:q] || ''
    response = {
      items:  RecommendationApiWrapper.get_recommendation(query)
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

    user = User.find(params[:uid])

    content = Content.new(
      :title => RecommendationApiWrapper.like(params[:cid], params[:uid])[:title],
      :link => RecommendationApiWrapper.like(params[:cid], params[:uid])[:link],
      :summary => RecommendationApiWrapper.like(params[:cid], params[:uid])[:summary],
      :keywords => RecommendationApiWrapper.like(params[:cid], params[:uid])[:keywords],
      :text => RecommendationApiWrapper.like(params[:cid], params[:uid])[:text],
      :user_id => params[:uid],
      :cid => params[:cid],
      :content.article_id => params[:id],
      :rates => 0
    )

    content.save
    user.save

    if user.like(content)
      head :ok
    else
      head :unprocessable_entity
    end

    response = {
      items:  RecommendationApiWrapper.like(params[:cid], params[:uid])
    }
    return render :json => response.as_json
  end

  def dislike

    user = User.find(params[:uid])

    content = Content.new(
      :title => RecommendationApiWrapper.dislike(params[:cid], params[:uid])[:title],
      :link => RecommendationApiWrapper.dislike(params[:cid], params[:uid])[:link],
      :summary => RecommendationApiWrapper.dislike(params[:cid], params[:uid])[:summary],
      :keywords => RecommendationApiWrapper.dislike(params[:cid], params[:uid])[:keywords],
      :text => RecommendationApiWrapper.dislike(params[:cid], params[:uid])[:text],
      :user_id => params[:uid],
      :cid => params[:cid],
      :content.article_id => params[:id],
      :rates => 0
    )

    if user.dislike(content)
      head :ok
    else
      head :unprocessable_entity
    end

    content.save
    user.save

    response = {
      items:  RecommendationApiWrapper.dislike(params[:cid], params[:uid])
    }
    return render :json => response.as_json
  end
end
