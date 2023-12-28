class Avo::Resources::User < Avo::BaseResource
  self.title = :email
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :email, as: :text
    field :firts_name, as: :text
    field :last_name, as: :text
    field :activated, as: :boolean
    field :confirmed_at, as: :date_time
    field :phone_number, as: :number
    field :country_code, as: :text
    field :provider, as: :text
    field :uid, as: :text
    field :roles, as: :has_and_belongs_to_many
    field :properties, as: :has_many
    field :appointments, as: :has_many
  end
end
