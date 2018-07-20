# == Schema Information
#
# Table name: projects
#
#  id          :uuid             not null, primary key
#  name        :string
#  description :text
#  state       :integer          default("active")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_projects_on_name  (name) UNIQUE
#

require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :state }
end
