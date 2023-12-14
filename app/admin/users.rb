ActiveAdmin.register User do
	permit_params :email 

	filter :email
	scope :all, default: true
	scope("Active") { |scope| scope.where(activated: true) }
	scope("Inactive") { |scope| scope.where(activated: false) }

	index do
	selectable_column 
		column :id
		column :email
		column :created_at
		column :updated_at
		column :confirmed_at
		column :roles
		column :activated
		actions
	end
end