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
  include AASM

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
  scope :by_id, -> (id) { joins(:project).find_by(id: id) }

  aasm whiny_transitions: false, column: :state, enum: true do
    state :todo, :initial => true
    state :in_progress, :done

    after_all_transitions :log_state_update

    event :start do
      transitions :from => [:todo, :in_progress], :to => :in_progress
    end

    event :finish do
      transitions :from => [:in_progress, :done], :to => :done, after: :notify
    end

    event :stop do
      transitions :from => [:in_progress, :todo], :to => :todo
    end
  end

  def log_state_update
    logger.info "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
  end

  def transition(event)
    return true unless event.present?
    self.send(event)
  end

  def notify
    Notifyer.new("#{self.name} is #{self.state}").notify
  end

  private

  def set_default_state
    self.state ||= :todo
  end

end
