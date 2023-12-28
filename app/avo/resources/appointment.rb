class Avo::Resources::Appointment < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :email, as: :text
    field :phone, as: :number
    field :date, as: :date_time
    field :time, as: :date_time
    field :user_id, as: :number
    field :property_id, as: :number
    field :status, as: :select, enum: ::Appointment.statuses
    field :visit_status, as: :select, enum: ::Appointment.visit_statuses
    field :user, as: :belongs_to
    field :property, as: :belongs_to
  end
end
