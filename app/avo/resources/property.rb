class Avo::Resources::Property < Avo::BaseResource
  self.includes = []
  self.search = {
    query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  }
  self.default_view_type = :grid

  def fields
    field :id, as: :id
    field :name, as: :text,link_to_record: true
    field :status, as: :select, enum: ::Property.statuses,filterable: true
    field :price, as: :number
    field :prop_type, as: :select, enum: ::Property.prop_types
    field :publish, as: :select, enum: ::Property.publishes
    field :is_paid, as: :boolean
    field :user, as: :belongs_to, use_resourc: Avo::Resources::User
   
    # field :address, as: :has_one
    # field :amenities, as: :has_and_belongs_to_many
    field :attachments, as: :has_many
    field :appointments, as: :has_many
    field :flat_detail, as: :has_one, hide_on: [:index]
  end

  def filters
    filter Avo::Filters::Property
    filter Avo::Filters::Status
    filter Avo::Filters::Textfilter
    filter Avo::Filters::Punlished 
  end
end
