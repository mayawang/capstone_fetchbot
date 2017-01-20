class User < ApplicationRecord
  has_many :contents
  recommends :contents
end
