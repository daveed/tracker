@domain @api
Feature: Updates a task

  As a user I can transition tasks between states

  Valid states transitions:
   - todo -> in_progress
   - in_progress -> todo
   - in_progress -> done

  Rules:
  - Project is required
  - Id is required
  - A task with the state todo can be updated to in_progress
  - A task with the state in_progress can be updated to todo
  - A task with the state in_progress can be updated to done

  Background:
    Given a project

  Scenario: Updating the state from todo to in progress
    Given a task
    When I "start" working on the task
    Then its state is updated to "in_progress"


  Scenario: Updating the state from in progress to todo
    Given a task with a state "in_progress"
    When I "stop" working on the task
    Then its state is updated to "todo"


  Scenario: Updating the state from in_progress to done
    Given a task with a state "in_progress"
    When I "finish" working on the task
    Then its state is updated to "done"


  Scenario: Updating the state from todo to todo
    Given a task with a state "todo"
    When I "stop" working on the task
    Then its state is still "todo"


  Scenario: Updating the state from done to done
    Given a task with a state "done"
    When I "finish" working on the task
    Then its state is still "done"


  Scenario: Updating the state from in_progress to in_progress
    Given a task with a state "in_progress"
    When I "start" working on the task
    Then its state is still "in_progress"


  Scenario: Trying to update the state from todo to done
    Given a task with a state "todo"
    When I "finish" working on the task
    Then its state is still "todo"


  Scenario: Trying to update the task name
    Given a task that has the name "Sample Task"
    When I change it to "Simple Task"
    Then its name is "Simple Task"
