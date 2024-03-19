class ApiFeatures
  def initialize(query, query_str)
    @query = query
    @query_str = query_str
  end

  def search
    keyword = @query_str[:keyword].present? && @query_str[:keyword] != 'null' ? { city: @query_str[:keyword] } : {}
    if keyword.present?
      @query = @query.joins(:address).where(address: keyword)
    else
      @query
    end
    return self
  end

  def filter
    query_copy = @query_str.dup
    remove_fields = ["keyword", "page", "limit","perPage"]
    remove_fields.each { |key| query_copy.delete(key) }
    # query_str = query_copy.to_json
    # query_str.gsub!(/\b(gt|gte|lt|lte)\b/) { |match| "$#{match}" }
    # @query = @query.where(JSON.parse(query_str))
    if query_copy.present? 
      if query_copy[:sort_option] == "low_to_high"  
        @query = @query.order(price: :asc)  
      end
      if query_copy[:sort_option] == "high_to_low"  
        @query = @query.order(price: :desc)
      end
      if query_copy[:sort_option] == "name"
        @query = @query.order(name: :asc)
      end
      if query_copy[:status] == "sold"  
        @query = @query.where(status: "sold")
      end
      if query_copy[:status] == "available"
        @query = @query.where(status: "available")
      end
      if query_copy[:status] == "pending"
        @query = @query.where(status: "pending")
      end
      if query_copy[:min_price] != 'null' && query_copy[:max_price] != 'null' 
        @query  = @query.where('price BETWEEN ? AND ?',query_copy[:min_price],query_copy[:max_price]) 
      end

      if query_copy[:prop_type] != 'null'
        @query  = @query.where(prop_type: query_copy[:prop_type]) 
      end
      if query_copy[:posted] == "owner" or query_copy[:posted] == "broker"  
        @properties = []
        @query.each do |prop|
          user = User.find(prop.user_id)
          user.roles.each do |role|
            if role.name != "user"
              if role.name == params[:posted]
                @properties << prop
              end
            end
          end
        end
        @query = @properties
      end
    else
      @query
    end
    return @query
  end
end