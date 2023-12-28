class Avo::Filters::Property < Avo::Filters::BooleanFilter
  self.name = "Payment Status"
  # self.visible = -> do
  #   true
  # end

  def apply(request, query, value)
    query = query.where(is_paid: true)
    query
  end

  def options
    {
      is_paid: 'Paid'
    } 

      # Property.select(:id, :name).each_with_object({}) { |property, options| options[property.id] = property.id }
  end
end
