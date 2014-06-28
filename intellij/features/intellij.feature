Feature: User can access intellij from the command line

In order to use intellij
As a programmer
I need to be able to access intellij from the command line

Background:
  
  Given I have provisioned the following infrastructure:
      | Server Name | Operating System | Version     | Chef Version | Run List          |
      | intellij    | ubuntu           | 14.04-amd64 |       11.4.4 | intellij::default |
  And I have run Chef

Scenario: User runs intellij

  When a user executes ijult
  Then intellij should run
