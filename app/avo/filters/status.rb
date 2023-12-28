class Avo::Filters::Status < Avo::Filters::SelectFilter
  self.name = "Property Status"
  # self.visible = -> do
  #   true
  # end

  def apply(request, query, value)
    case value
    when 'available'
      query.where(status: 'available')
    when 'sold'
      query.where(status: 'sold')
    else
      query
    end

        
  end

  def options
    {
      available: 'Available',
      sold: 'Sold'
    }
  end

  def default
    {
      available: 'Available'
    }
  end
end
