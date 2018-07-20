@domain @api
Feature: Listing tasks

  As a user I can list tasks that belong to a project

  Rules:
  - Project is required

  Background:
    Given a project

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
