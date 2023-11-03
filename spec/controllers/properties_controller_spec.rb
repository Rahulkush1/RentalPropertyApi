require 'rails_helper'

RSpec.describe Api::V1::PropertiesController, type: :controller do
  before(:each) do 
  	@amenity1 = FactoryBot.create(:amenity,title: "Gym")
    @user = FactoryBot.create(:user)
    @property = FactoryBot.create(:property, user_id: @user.id)
  	@attachment = FactoryBot.create(:attachment,property_id: @property.id)
  	@token = JsonWebTokenService.encode({ id: @user.id })
    @req_params = request.headers.merge!("HTTP_AUTH_TOKEN" => "#{@token}")
  end

  let(:property_params) do {
  	"property":
  	{
  	  	"name": "Dmeo2 Property",
	  	"price": 12345, 
	  	"publish": "NO", 
	  	"flat_detail_attributes": 
	  		{  
		  		"area": " 240 square feet",
		        "flat_type": 1,
		        "available_for": "Family"
	        },
	    "address_attributes": {
	            "address": "hsuhghjh",
	            "street": "jkduymsnns",
	            "city": "dskjieuw",
	            "country": "india"
	    }
  	}
 	}
	end

  describe "Get /index" do 
    it "Get All User Properties" do 
      get :index, params: @req_params.merge!(self_property: true)
      expect(response.status).to eq 200
    end
  end

  describe "Get /index" do 
    it "Get All  Properties" do 
      get :index, params: @req_params.merge!(self_property: false)
      expect(response.status).to eq 200
    end
  end

  describe "Get /show" do 
  	it "Get Property Detail" do 
  		get :show, params:@req_params.merge!(id: @property.id)
      	expect(response.status).to eq 200
  	end
  end

  describe "Post /create" do 

  	it "Create Property" do 
  		post :create, params: @req_params.merge!(property: property_params)
  		expect(response.status).to eq 201
  	end
  end

  describe "Put /update" do 
  	it "Update Property" do 
  		put :update, params: @req_params.merge!(property: property_params, id: @user.id)
  		expect(response.status).to eq 200  		
  	end
  end

   describe "Put /update" do 
  	it "Only Update Property status" do 
  		put :update, params: @req_params.merge!(:property => {status: "sold"})
  		expect(response.status).to eq 200  		
  	end
  end

  describe "Delete /destroy " do 
  	it "Delete Property" do 
  		delete :destroy, params: @req_params.merge!( id: @user.id)
  		expect(response.status).to eq 303
  	end
  end

  describe 'Get /filter Property' do 
  	it "Filter Properties" do 
  		get :filter_property, params: { sort_option: "low_to_high",status: "sold"}
  		expect(response.status).to eq 200
  	end
  end

  describe 'Delete /delete_image_attachment' do
  	it " Delete Image Attachment" do 
  		delete :delete_image_attachment, params: @req_params.merge!( id: @property.id, attachment_id: @attachment.id)
  		expect(response.status).to eq 303
  	end
  end

end
