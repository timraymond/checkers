Feature: Fetch a move from the AI
  As a server with many things to do
  I want to fetch a move from an AI by providing the state of the game

  Scenario: New Game, Black to Move
    When I successfully run `chagent bbbbbbbbbbbbxxxxxxxxwwwwwwwwwwww:b`
    Then the stdout should contain "9x13"

  Scenario: With Depth Option and Pruning
    When I successfully run `chagent --pruning -d 3 bbbbbbbbbbbbxxxxxxxxwwwwwwwwwwww:b`
    Then the stdout should contain "9x13"
