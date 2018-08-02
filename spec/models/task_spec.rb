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

require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should belong_to :project }
  it { should validate_presence_of :name }
  it { should validate_presence_of :state }
  it { should define_enum_for :state }
end
