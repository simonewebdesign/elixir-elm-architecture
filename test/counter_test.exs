defmodule CounterTest do
  use ExUnit.Case
  import Counter

  # @messages [
  #   :Increment,
  #   :Increment,
  #   :Increment,
  #   :Decrement
  # ]

  @initial_state 0

  test "Initial state is zero" do
    assert view(@initial_state) == "0"
  end

  test "Increment the counter by 1" do
    updated_model = update(:Increment, @initial_state)

    assert updated_model == 1
  end

  test "Increment the counter by 3" do
    updated_model = update(:Increment, @initial_state)
    updated_model = update(:Increment, updated_model)
    updated_model = update(:Increment, updated_model)

    assert updated_model == 3
  end

  test "Increment and decrement" do
    updated_model = update(:Increment, @initial_state)
    updated_model = update(:Increment, updated_model)
    updated_model = update(:Increment, updated_model)
    updated_model = update(:Decrement, updated_model)

    assert updated_model == 2
  end
end
