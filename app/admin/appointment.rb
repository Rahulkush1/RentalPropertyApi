ActiveAdmin.register Appointment do
	permit_params :id, :name, :email, :phone, :date, :time
	filter :name
	filter :email
	filter :date
	filter :time
end