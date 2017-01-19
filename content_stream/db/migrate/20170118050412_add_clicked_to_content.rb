class AddClickedToContent < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :clicked, :boolean
  end
end
