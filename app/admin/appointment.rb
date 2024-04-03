ActiveAdmin.register Appointment do
	permit_params :id, :name, :email, :phone, :date, :time, :status
	filter :name
	filter :email
	filter :date
	filter :time

	form title: 'Appointment form' do |f|
	    inputs 'Details' do
	      input :name
	      input :email
	      input :date
	      input :status
	    end
	    actions
 	end
end