class AddUserCategoryToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_category, :integer
  end
end
