class AppointmentSerializer 
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  attributes :id, :name, :email, :phone

  attribute :status do |object| 
    object.status.capitalize()
  end

  attribute :date do |object| 
    object.date.strftime("%A, %B %d, %Y")
  end

  attribute :property do |object| 
    Property.find(object.property_id)
  end

end