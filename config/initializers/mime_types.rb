Rails.application.config.to_prepare do
  # Register additional MIME types
  Mime::Type.register "text/html", :html
  Mime::Type.register "application/json", :json
  
  # Allow more permissive Accept header handling
  ActionController::Base.prepend_before_action do
    request.format = :html if request.format.nil? || request.format == Mime::ALL
  end
end
