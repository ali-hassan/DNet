ActiveAdmin.register ActivateUserPackage do
  actions :index, :new, :create, :destroy
  permit_params :package_id, :user_id
  form do |f|
    f.inputs do
      f.input :package_id, collection: FindPackages.new("100").packages.map { |k, hash| ["#{hash[:category]}-#{hash[:price]}", hash[:price] ] }
      f.input :user, collection: User.all.map { |usr| [usr.username, usr.id] }
    end
    actions
  end
end
