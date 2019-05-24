ActiveAdmin.register User, as: "UpgradePinUsersToPackage" do
  permit_params :select_package_id
  form do |f|
    f.inputs do
      f.input :select_package_id, as: :select, collection: FindPackages.new.packages.map { |k, hsh| [hsh[:price], k] }, required: true
    end
    f.actions
  end
  controller do
    def scoped_collection
      User.where(is_pin: true)
    end
    def update
      update! do |format|
        format.html { ChargeAmountAtA.new(resource, resource.package_id, false, false).charge!; redirect_to([:admin, :users], notice: "User successfully converted to paid user") } if resource.valid?
      end
    end
  end
end
