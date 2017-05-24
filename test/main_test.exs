defmodule MainTest do
  use ExUnit.Case

  # @messages [
  #   :Increment,
  #   :Increment,
  #   :Increment,
  #   :Decrement
  # ]

  @initial_state  0
  @expected_state 1

  test "counter example" do
    assert Main.view(@initial_state) == "0"

    updated_model = Main.update(:Increment, @initial_state)

    assert updated_model == @expected_state
  end
end
