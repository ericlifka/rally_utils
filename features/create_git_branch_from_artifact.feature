Feature: Create a git branch from an artifact

  Scenario: Retrieve an artifact name using the artifact id
    When I retrieve username and password from subscriptions file
    And I log into ALM with test@test.com and Password1
    And I prompt for an artifact_id
    And I get "DE1440" from stdin
    Then I can retrieve an artifact name using the artifact_id

