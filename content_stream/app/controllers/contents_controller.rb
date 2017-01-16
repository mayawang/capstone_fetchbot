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

  def clicked

  end

  def like
    return render :json => {}.as_json
  end

  def dislike
    return render :json => {}.as_json
  end

end
