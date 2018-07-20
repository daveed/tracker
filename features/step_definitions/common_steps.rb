Then(/^I get (\d+) (.*) back$/) do |count, kind|
  count = count.to_i
  kind = kind.pluralize.to_sym
  expect(d.results[kind].count).to eq count
end

Then(/^the current page is (\d+)$/) do |page|
  expect(d.results[:current_page_number]).to eq page.to_i
end

Then(/^the total pages is (\d+)$/) do |count|
  expect(d.results[:total_page_count]).to eq count.to_i
end

Then(/^the total results is (\d+)$/) do |count|
  expect(d.results[:count]).to eq count.to_i
end

Then(/^I get the error "([^"]*)"$/) do |message|
  d.verify_error message
end

Then(/^I get the data:$/) do |string|
  data = eval string
  expect(HashDiff.diff d.results, data).to be_empty
end
