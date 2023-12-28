class Avo::Resources::Attachment < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :property_id, as: :number
    field :image, as: :file,direct_upload: true
    field :property, as: :belongs_to
  end
end
