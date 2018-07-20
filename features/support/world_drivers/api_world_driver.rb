class ApiWorldDriver < WorldDriver
  include Rack::Test::Methods

  def initialize
    p 'Running Features in the API World'
    super
  end

  def app
    Rails.application
  end

  def request_list collection_type, params
    request_path = request_path collection_type, params
    result = get request_path
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
      @results = nil
    else
      @results = body
    end
  end

  def request_member collection_type, params
    project_id = params[:project_id]
    id = params[:id]
    result = get "/v1/projects/#{project_id}/tasks/#{id}"
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
      @results = nil
    else
      @results = body
    end
  end

  def create_project attributes
    result = post '/v1/projects', { project: attributes }
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
    end
  end

  def create_task attributes
    project_id = attributes["project_id"]
    result = post "/v1/projects/#{project_id}/tasks", { task: attributes }
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
    end
  end

  private

  def request_path collection_type, params
    case collection_type
    when "projects"
      "/v1/#{collection_type}?#{params.to_query}"
    when "tasks"
      "/v1/projects/#{params[:project_id]}/tasks"
    end
end
end
