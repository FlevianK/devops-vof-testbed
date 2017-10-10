ture: Install Mysql

  Scenario: Setup and Install Mysql
    Given I have a running ubuntu docker container
    When I run my config scripts
    Then It should succeed
    And mysql should be running and listening on port 3306
