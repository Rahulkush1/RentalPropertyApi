class Api::V1::PropertiesController < ApplicationController
  before_action :authenticate_user, :only => [:create, :update, :destroy, :delete_image_attachment]
  # before_action :validate_user, :only => [:update, :destroy, :delete_image_attachment]
  load_and_authorize_resource
  
  Not_Authorized = "Not Authorized"
  def index

    if params[:self_property].present? &&  params[:self_property] == true
      @properties = current_user.properties.where(publish: 1).where(status: 0).where(is_paid: false)
    elsif params[:recomended_property].present? && params[:recomended_property] == "true"

      @properties = Property.where(publish: 1).where(status: 0).where(is_paid: false)
      @properties = @properties.joins(:address).where(address: {city: params[:user_city].downcase}).limit(4)
      return render json: PropertySerializer.new(@properties).serialized_json, status: :ok
    else
      apiFeature =  ApiFeatures.new(Property.all, request.query_parameters).search().filter()
      @properties = apiFeature
    end
    @total_property_count = @properties.count
    @properties = @properties.where.not(status: 1).page(params[:page]).per(25)
    render json: {properties: JSON.parse(PropertySerializer.new(@properties).serialized_json), total_property_count: @total_property_count}, status: :ok
  end

  def property_detail
     
    @property = Property.find(params[:id])
    render json: PropertySerializer.new(@property).serialized_json, status: :ok
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
    if params[:min_price] != 'null' && params[:max_price] != 'null'
      @property  = @property.where('price BETWEEN ? AND ?',params[:min_price],params[:max_price]) 
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
    render json: PropertySerializer.new(@property).serialized_json, status: :ok
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
   	params.require(:property).permit(:name, :price,:status, :publish, :prop_type,  flat_detail_attributes: [:flat_type, :area, :available_for], amenity_ids: [], address_attributes: [:address_line, :street, :state ,:city, :country], attachments_attributes: [image: {}])
  end 
end


















# class ApiFeatures
#   def initialize(query, query_str)
#     @query = query
#     @query_str = query_str
#   end

#   def search
#     keyword = @query_str[:keyword].present? ? { name: /#{@query_str[:keyword]}/i } : {}
#     binding.pry
#     @query = @query.where(keyword)
#     self
#   end

#   # def filter
#   #   query_copy = @query_str.dup
#   #   remove_fields = ["keyword", "page", "limit"]
#   #   remove_fields.each { |key| query_copy.delete(key) }

#   #   query_str = query_copy.to_json
#   #   query_str.gsub!(/\b(gt|gte|lt|lte)\b/) { |match| "$#{match}" }
#   #   @query = @query.where(JSON.parse(query_str))
#   #   self
#   # end

# end
