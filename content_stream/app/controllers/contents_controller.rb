class ContentsController < ApplicationController
  def search
    # content = Content.new
    # content.title = params[:q]

    item = {
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

  end

  def dislike

  end

end
