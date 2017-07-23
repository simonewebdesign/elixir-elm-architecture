defmodule StateTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = State.start_link(Counter)
    {:ok, server: pid}
  end

  test "Initial state", %{server: pid} do
    assert :sys.get_state(pid) ==
      %{
        module: Counter,
        frames: [],
        initial_model: 0
      }
  end

  test "Update the model", %{server: pid} do
    {:ok, new_model} = State.step(pid, :Increment)

    assert new_model == 1
  end

  test "An invalid message should produce an error and state should be unchanged", %{server: pid} do
    {:error, error_message} = State.step(pid, :DefinitelyNotAValidMessage)

    assert error_message == :invalid_message
    assert :sys.get_state(pid) ==
      %{
        module: Counter,
        frames: [],
        initial_model: 0
      }
  end

  test "Undoing the state preserves the order", %{server: pid} do
    {:ok, _new_model} = State.step(pid, :Increment) # 1
    {:ok, _new_model} = State.step(pid, :Decrement) # 0
    {:ok, new_model} = State.step(pid, :Increment)  # 1

    assert new_model == 1

    {:ok, old_model} = State.undo(pid)

    assert old_model == 0
  end

  test "Undoing the initial state is a no-op", %{server: pid} do
    {:ok, _new_model} = State.step(pid, :Increment)
    {:ok, new_model} = State.step(pid, :Decrement)

    assert new_model == 0

    {:ok, old_model} = State.undo(pid)

    assert old_model == 1

    {:ok, old_model}   = State.undo(pid)
    {:ok, older_model} = State.undo(pid)

    assert old_model == older_model
  end
end
