class RenamePostIdColumnToMicropostId < ActiveRecord::Migration[5.2]
  def change
    rename_column :likes, :post_id, :micropost_id
  end
end
