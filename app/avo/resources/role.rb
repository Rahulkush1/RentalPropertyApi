class Avo::Resources::Role < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :resource_type, as: :text
    field :resource_id, as: :number
    field :users, as: :has_and_belongs_to_many
    field :resource, as: :belongs_to
  end
end
