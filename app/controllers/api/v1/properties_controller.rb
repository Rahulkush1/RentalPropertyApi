class Api::V1::PropertiesController < ApplicationController
  before_action :authenticate_user, :only => [:index,:create, :update, :destroy, :delete_image_attachment]
  # before_action :validate_user, :only => [:update, :destroy, :delete_image_attachment]
  load_and_authorize_resource
  Not_Authorized = "Not Authorized"
  def index
    if params[:self_property] == true
  	 @properties = current_user.properties.where(publish: 1).where(status: 0).where(is_paid: false)

    else
     @properties = Property.where(publish: 1).where(status: 0).where(is_paid: false)
    end
  	render json: @properties, status: :ok
  end

  def property_detail  
    @property = Property.find(params[:id])

    render json: @property,status: :ok
    # render json: PropertySerializer.new(@property).serialized_json, status: :ok
  end

  def create
    @property  = current_user.properties.new(property_params)
    if @property.save
      url_img = []
      @property.attachments.each do |attachment|
        url_img << url_for(attachment.image)
      end
      render json: {data: @property, url: url_img}, status: :created
    else
      render json: @property.erorrs, status: :unprocessable_entity
    end
  end

  def update
    if validate_user
      if params[:property][:status]
        @property.update(status: property_params[:status])
        render json: @property, status: :ok
      elsif params[:property][:publish]
        @property.update(publish: property_params[:publish])
        render json: @property, status: :ok
      else
      	if @property.update(property_params)
      		render json: @property, status: :ok
      	else
      		render json: @property.errors, status: :unprocessable_entity
      	end
      end
    else
      render json: {error: Not_Authorized}, status: 401
    end
  end

  def destroy
    if validate_user
    	@property.destroy
    	render json: {message: "Property Deleted successfully"}, status: :see_other
    else
      render json: {error: Not_Authorized}, status: 401
    end
  end

  def filter_property
    @property = Property.where(publish: 1).where(status: 0)
    if params[:sort_option] == "low_to_high"  
      @property = @property.order(price: :asc)  
    end
    if params[:sort_option] == "high_to_low"  
      @property = @property.order(price: :desc)
    end
    if params[:sort_option] == "name"
      @property = @property.order(name: :asc)
    end
    if params[:status] == "sold"  
      @property = @property.where(status: "sold")
    end
    if params[:status] == "available"
      @property = @property.where(status: "available")
    end
    if params[:status] == "pending"
      @property = @property.where(status: "pending")
    end
    if params[:min_price].present? && params[:max_price].present?
      @property  = @property.where('price BETWEEN ? AND ?',params[:min_price],params[:max_price], images: [:data]) 
    end
    if params[:posted] == "owner" or params[:posted] == "broker"  
      @properties = []
      @property.each do |prop|
        user = User.find(prop.user_id)
        user.roles.each do |role|
          if role.name != "user"
            if role.name == params[:posted]
              @properties << prop
            end
          end
        end
      end
      @property = @properties
    end
    render json: @property , status: :ok
  end

  def delete_image_attachment
    if validate_user
      @property = Property.find(params[:id])
      @attachment = @property.attachments.find_by(id: params[:attachment_id])
      @attachment.destroy
      render json: {message: "Image Attachment Deleted successfully"}, status: :see_other
    else
      render json: {error: Not_Authorized}, status: 401
    end
  end

  private
  def validate_user
    @property = Property.find(params[:id])
    if current_user.id == @property.user_id
      return true
    else
      return false
    end
  end

  private
  def property_params 
   	params.require(:property).permit(:name, :price,:status, :publish,  flat_detail_attributes: [:flat_type, :area, :available_for], amenity_ids: [], address_attributes: [:address_line, :street, :state ,:city, :country], attachments_attributes: [image: {}])
  end 
end
