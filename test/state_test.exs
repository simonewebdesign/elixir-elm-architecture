defmodule StateTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = State.start_link(Counter)
    {:ok, state: pid}
  end

  test "Initial state", %{state: state} do
    assert State.get(state) == 0
  end

  test "Update the state", %{state: state} do
    {:ok, new_state} = State.step(state, :Increment)

    assert new_state == 1
  end

  test "An invalid message should produce an error and state should be unchanged", %{state: state} do
    {:error, error_message} = State.step(state, :DefinitelyNotAValidMessage)

    assert error_message == :invalid_message
    assert State.get(state) == 0
  end
end
