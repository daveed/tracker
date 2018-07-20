@domain @api
Feature: Listing tasks

  As a user I can list tasks that belong to a project

  Rules:
  - Project is required

  Background:
    Given a project

  Scenario: No parameters are specified and there are 26 tasks
    Given 26 tasks
    When I request for the tasks list
    Then I get 25 tasks back
    And the current page is 1
    And the total pages is 2
    And the total results is 26

  Scenario: Verifying the format shape
    When I create a task
    And I request for the tasks list
    Then I get the data:
      """
        {
          tasks: [
            {
              name: "Sample Task",
              description: "A sample task",
              state: "todo"
            }
          ],
          count: 1,
          current_page_number: 1,
          total_page_count: 1
        }
      """
