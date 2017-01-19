class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :summary
      t.string :link
      t.string :keywords
      t.text :text

      t.timestamps
    end
  end
end
