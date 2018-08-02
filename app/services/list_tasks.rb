class ListTasks < ListCollection

  attr_defaultable :task_repository, -> { Task }
  attr_defaultable :result_serializer, -> { V1::TaskSerializer }

  def initialize project_id
    @project_id = project_id
    super()
  end

  def collection_type
    :tasks
  end

  def collection
    @tasks ||= task_repository.tasks
  end

  attr_reader :project_id

end
