Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost.com:3000'
    resource '*', headers: :any, methods: [:get, :post]
  end
end