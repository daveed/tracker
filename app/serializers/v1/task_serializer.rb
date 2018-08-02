module V1
  class TaskSerializer < ActiveModel::Serializer

    attributes :name, :description, :state

  end
end
