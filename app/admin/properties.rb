ActiveAdmin.register Property do
	permit_params :name, :status, :price, :prop_type, :publish, :is_paid, 
                :user_id, flat_detail_attributes: [:area, :flat_type, :available_for],
                amenity_ids: [],
                 attachments_attributes: [image: {}],address_attributes: [:address_line, :street, :state ,:city, :country]


	filter :name 
	filter :price

	index do
		selectable_column
		column :name
		column :price
		column :amenities
		# column :user
		actions
	end

	form do |f|
	    f.inputs "Property Details" do
	    	f.input :user_id, as: :select, collection: User.pluck(:email, :id)
	      f.input :name
	      f.input :price
	      f.input :prop_type, as: :select, collection: Property.prop_types.keys, include_blank: false
	      f.input :publish, as: :select, collection: Property.publishes.keys
	      f.input :amenities, :as => :check_boxes, :collection => Amenity.all.collect {|amenity| [amenity.title, amenity.id] }
	    end
	    # Conditional display of flat_details fields based on prop_type selection
        f.inputs "Flat Details", id: 'flat_details_fields', style: ('display:none;' unless f.object.prop_type == 'FLAT') do
	      f.semantic_fields_for :flat_detail, f.object.flat_detail || FlatDetail.new do |flat_detail_fields|
	        flat_detail_fields.input :area
	        flat_detail_fields.input :flat_type, as: :select, collection: FlatDetail.flat_types.keys
	        flat_detail_fields.input :available_for
	      end
	    end

	   	f.inputs " Property Address" do
	      f.semantic_fields_for :address, f.object.address || Address.new do |address_fields|
	        address_fields.input :address_line
	        address_fields.input :street
	        address_fields.input :city
	        # address_fields.input :country
	      end
	    end

	    f.inputs "Attachments" do
	      f.has_many :attachments, heading: false, allow_destroy: true, new_record: 'Add Attachment' do |attachment_fields|
	        attachment_fields.input :image, as: :file
	       	attachment_fields.semantic_fields_for :image, attachment_fields.object.image  do |image_fields|
		        image_fields.input :image, as: :file
	      	end
	      end
	    end

	    f.actions
 	end


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