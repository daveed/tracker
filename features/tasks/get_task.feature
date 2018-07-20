@domain @api
Feature: Get a task

  As a user I can get a task by id

  Rules:
  - Project is required
  - Id is required

  Background:
    Given a project
    And a task

  Scenario: Verifying the format shape
    When I request for the task using its id
    Then I get the following task with:
      """
        {
          task:
            {
              name: "Sample Task",
              description: "A sample task",
              state: "todo"
            }
        }
      """
