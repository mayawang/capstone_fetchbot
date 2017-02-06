class Content < ApplicationRecord
  belongs_to :user
  belongs_to :article

  RATE_LIKE = 1
  RATE_DISLIKE = 2
  RATE_UNKNOWN = 0

  def to_frontend_hash
    unless self.id
      self.reload
    end

    unless self.id
      puts "content has NO ID!!!!!!!! user_id #{self.user_id} article_id #{self.article_id}"
    end

    return {
      id: self.id,
      title: self.title,
      link: self.link,
      summary: self.summary,
      keywords: self.keywords,
    }
  end
end
