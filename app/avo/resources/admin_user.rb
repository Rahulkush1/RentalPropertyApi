class Avo::Resources::AdminUser < Avo::BaseResource
  self.includes = []
  self.title = :email 
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :email, as: :text
  end
end
