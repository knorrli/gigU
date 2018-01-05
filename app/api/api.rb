class API < Grape::API
  version 'v1', :using => :path
  format :json

  rescue_from ActiveRecord::RecordInvalid do |error|
    Rack::Response.new(
      {
        'status' => 422,
        'message' => error.record.errors.full_messages.to_sentence,
        'errors' => error.record.errors
      }.to_json, 422
    )
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    Rack::Response.new(
      {
        'status' => 404,
        'message' => error.message
      }.to_json, 404
    )
  end

  mount Resources::Events
  mount Resources::Locations

  add_swagger_documentation(
    :hide_documentation_path => true,
    :base_path => '/api',
    :api_version => 'v1'
  )
end
