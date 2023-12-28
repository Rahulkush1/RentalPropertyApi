class Avo::Filters::Punlished < Avo::Filters::SelectFilter
  self.name = "Punlished"
  # self.visible = -> do
  #   true
  # end

  def apply(request, query, value)
    case value
    when 'is_published'
      query.where(publish: 'YES')
    when 'is_unpublished'
      query.where(publish: 'NO')
    else
      query
    end
  end

  def options
    {
      is_published: 'Yes',
      is_unpublished: 'No'
    }
  end
end
