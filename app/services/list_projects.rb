class ListProjects < ListCollection

  attr_defaultable :project_repository, -> { Project }
  attr_defaultable :result_serializer, -> { V1::ProjectSerializer }

  def collection_type
    :projects
  end

  def collection
    @projects ||= project_repository.active
  end

end
