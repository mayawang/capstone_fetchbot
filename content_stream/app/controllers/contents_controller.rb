class ContentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def search
    # content = Content.new
    # content.title = params[:q]

    item = {
      id: '1',
      title: 'test',
      link: 'http://test/1.html',
      summary: 'I know...nothing!!!! >,<',
      keywords: 'project sucks',
      text: 'aaaaaaahhhhhhhhhh!!! >.<'
    }

    items = []
    items << item

    response = {
      items: items
    }
    return render :json => response.as_json

  end

  def click
    print "clicked"
    return render :json => {clicked:"yes"}.as_json
  end

  def like
    print "liked"
    return render :json => {liked:"yes"}.as_json
  end

  def dislike
    print "disliked"
    return render :json => {disliked:"yes"}.as_json
  end

end
