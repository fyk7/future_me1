class AddMicropostCategoryToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :micropost_category, :integer
  end
end
