class Avo::Resources::FlatDetail < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :area, as: :text
    field :flat_type, as: :select, enum: ::FlatDetail.flat_types
    field :available_for, as: :text
    field :property_id, as: :number
    field :property, as: :belongs_to
  end
end
