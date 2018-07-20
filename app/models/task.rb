# == Schema Information
#
# Table name: tasks
#
#  id          :uuid             not null, primary key
#  name        :string           not null
#  description :text
#  project_id  :uuid
#  state       :integer          default("todo")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#

class Task < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true
  validates :state, presence: true

  after_initialize :set_default_state

  enum state: {
    todo: 0,
    in_progress: 1,
    done: 2
  }

  scope :tasks, -> { joins(:project) }

  private

  def set_default_state
    self.state ||= :todo
  end
end
