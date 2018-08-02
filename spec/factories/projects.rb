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

FactoryBot.define do
  factory :project do
    name
    description 'A sample project'
  end
end
