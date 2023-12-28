class Avo::Filters::Textfilter < Avo::Filters::TextFilter
  self.name = "Search By Name"
  self.button_label = 'Filter by Name'
  # self.visible = -> do
  #   true
  # end

  def apply(request, query, value)
    query.where('LOWER(name) LIKE ?', "%#{value}%")
  end

end
