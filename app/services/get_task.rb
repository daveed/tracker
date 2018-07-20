class GetTask

  attr_defaultable :task_repository, -> { Task }
  attr_defaultable :result_serializer, -> { V1::TaskSerializer }

  def initialize project_id:, id:
    @project_id = project_id
    @id = id
    @errors = []
  end

  def call
    [response, errors]
  end

  def response
    {
      member_type => serialized_member
    }
  rescue StandardError => e
    errors.push e.message
    nil
  end

  def member_type
    :task
  end

  def member
    @task ||= task_repository.by_id(@id)
  end

  def serialized_member
    result_serializer.new(member).attributes
  end

  attr_reader :project_id, :id, :errors

end
