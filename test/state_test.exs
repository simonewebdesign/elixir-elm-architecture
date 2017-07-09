defmodule StateTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = State.start_link(Counter)
    {:ok, state: pid}
  end

  test "Initial state", %{state: pid} do
    assert :sys.get_state(pid) == 0
  end

  test "Update the state", %{state: pid} do
    {:ok, new_state} = State.step(pid, :Increment)

    assert new_state == 1
  end

  test "An invalid message should produce an error and state should be unchanged", %{state: pid} do
    {:error, error_message} = State.step(pid, :DefinitelyNotAValidMessage)

    assert error_message == :invalid_message
    assert :sys.get_state(pid) == 0
  end
end
