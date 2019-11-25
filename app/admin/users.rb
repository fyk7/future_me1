ActiveAdmin.register User do
  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :email, :password_digest, :remember_digest, :admin, :image_name, :user_category, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :password_digest, :remember_digest, :admin, :image_name, :user_category, :image]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
