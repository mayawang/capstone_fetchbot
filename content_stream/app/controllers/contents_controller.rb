require 'recommendation_wrapper'

class ContentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def search
    response = {
      items:  RecommendationApiWrapper.get_recommendation(params[:q])
    }
    return render :json => response.as_json
  end

  def click
    return render :json => {clicked:"yes", user: params[:uid]}.as_json
  end

  def like
    return render :json => {liked:"yes", user: params[:uid]}.as_json
  end

  def dislike
    return render :json => {disliked:"yes", user:params[:uid]}.as_json
  end

end
