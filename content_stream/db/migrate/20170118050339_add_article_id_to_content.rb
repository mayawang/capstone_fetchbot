class AddArticleIdToContent < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :article_id, :integer
  end
end
