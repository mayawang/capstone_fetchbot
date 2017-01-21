class User < ApplicationRecord
  has_many :contents
  recommends :articles
end
