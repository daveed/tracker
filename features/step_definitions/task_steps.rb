Given("a project") do
  @project = create(:project)
end

When("I create a task") do
  model = build_stubbed(:task, project: @project)
  d.create_task model.attributes
end

Then("there is a task with these attributes:") do |table|
  ActiveCucumber.diff_all! Task.order(:created_at), table
end

When("I try to create a task without a name") do
  model = build_stubbed(:task, name: nil, project: @project)
  d.create_task model.attributes
end

Then("the system has {int} tasks") do |int|
  expect(Task.count).to eq int
end

When("I create a task without a state") do
  model = build_stubbed(:task, project: @project)
  d.create_task model.attributes
end

Then("there is a task with the state {string}") do |string|
  expect(Task.first.todo?).to be true
end

When(/^I request for the (.*) list$/) do |collection_type|
  params = {project_id: @project.id}
  d.request_list collection_type, params
end
