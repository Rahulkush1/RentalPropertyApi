class AppointmentSerializer 
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  attributes :id, :name, :email, :phone, :date

  attribute :property do |object| 
    Property.find(object.property_id)
  end

end