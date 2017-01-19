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
    response = {
      items:  RecommendationApiWrapper.like(params[:cid], params[:uid])
    }
    return render :json => response.as_json
  end

  def dislike
    response = {
      items:  RecommendationApiWrapper.dislike(params[:cid], params[:uid])
    }
    return render :json => response.as_json
  end
end
