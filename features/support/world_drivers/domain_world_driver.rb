class DomainWorldDriver < WorldDriver

  def initialize
    p 'Running Features in the Domain World'
    super
  end

  def request_list collection_type, params
    @results, e = "List#{collection_type.camelize}".constantize.new(params).call
    @errors.push *e
  end

  def request_member collection_type, params
    @results, e = "Get#{collection_type.camelize}".constantize.new(params).call
    @errors.push *e
  end

  def create_project params
    project = Project.create params
    @errors.push *project.errors.full_messages
  end

  def create_task params
    task = Task.create params
    @errors.push *task.errors.full_messages
  end

  def update_task params
    task = Task.find_by id: params[:id]
    task.present? && task.update_attributes(params)
    @errors.push *task.errors.full_messages
  end

  def transition_task params, event
    task = Task.find_by id: params[:id]
    task.present? && task.send("#{event}!")
    @errors.push *task.errors.full_messages
  end

end
