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

Given("{int} tasks") do |int|
  d.given_tasks count: int
end

Given("a task") do
  @task = create(:task)
end

When(/^I request for the (.*) using its id$/) do |collection_type|
  params = {project_id: @project.id, id: @task.id}
  d.request_member collection_type, params
end

Then("I get the following task with:") do |string|
  data = eval string
  expect(HashDiff.diff d.results, data).to be_empty
end

When("I {string} working on the task") do |string|
  event = string
  params = {project_id: @project.id, id: @task.id}
  d.transition_task params, event
end

Then("its state is updated to {string}") do |string|
  expect(@task.reload.state).to eq string
end

Given("a task with a state {string}") do |string|
  @task = create(:task, string.to_sym)
end

Then("its state is still {string}") do |string|
  expect(@task.reload.state).to eq string
end

Given("a task that has the name {string}") do |string|
  @task = create(:task, name: string)
end

When("I change it to {string}") do |string|
  params = {project_id: @project.id, id: @task.id, name: string}
  d.update_task params
end

Then("its name is {string}") do |string|
  expect(@task.reload.name).to eq string
end

Then("I am notified by text message") do
  "Looking at your phone! More notifications!"
end
