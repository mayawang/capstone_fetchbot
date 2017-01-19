class AddRatesToContent < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :rates, :integer
  end
end
