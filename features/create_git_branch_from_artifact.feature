Feature: Create a git branch from an artifact

  Scenario: Retrieve an artifact name using the artifact id
    When I use the credentials user test@test.com with password Password
    Then I can retrieve an artifact name for US1

