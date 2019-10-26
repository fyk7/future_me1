class CreateMicropostsTags < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts_tags, id: false do |t|
      t.references :micropost, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
    end
  end
end
