class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :status, :visit_status,   :phone, :date, :time
  belongs_to :user
  belongs_to :property
end
