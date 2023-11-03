ActiveAdmin.register Property do

	
	show do 
		attributes_table do
			row :name
			row :price
			row :amenities
			row :prop_type
			row :status
			row :publish
			row :is_paid
			row "flat_detail" do |obj|
				ul do
					li do 
						 obj.flat_detail.area
					end
					li do 
						obj.flat_detail.available_for
					end
					li do 
						obj.flat_detail.flat_type
					end
				end	
			end

			row "Address" do |obj|
				ul do
					li do 
						 obj.address.address_line
					end
					li do 
						obj.address.street
					end
					li do 
						obj.address.state
					end
					li do 
						obj.address.city
					end
					li do 
						obj.address.country
					end
				end	
				
			end

			row "Images" do |obj|
				ul do
					obj.attachments.each do |i|
						li do
							image_tag(Rails.application.routes.url_helpers.rails_blob_url(i.image,only_path: true), height: 200, width: 200)
						end
					end
				end	
			end

		end
	end

end