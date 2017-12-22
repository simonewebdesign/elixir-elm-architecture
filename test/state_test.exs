defmodule StateTest do
  use ExUnit.Case, async: true

  describe "Counter example" do

    setup do
      {:ok, pid} = State.start_link(Counter)
      {:ok, server: pid}
    end

    test "Initial state", %{server: pid} do
      assert :sys.get_state(pid) ==
        %{
          module: Counter,
          frames: [],
          initial_model: Counter.model
        }
    end

    test "Update the model", %{server: pid} do
      {:ok, new_model} = State.step(pid, :Increment)

      assert new_model == 1
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


  describe "Form example" do

    setup do
      {:ok, pid} = State.start_link(Form)
      {:ok, server: pid}
    end

    test "Initial state", %{server: pid} do
      assert :sys.get_state(pid) ==
        %{
          module: Form,
          frames: [],
          initial_model: Form.model
        }
    end

    test "Update the model", %{server: pid} do
      {:ok, new_model} = State.step(pid, {:Name, "John"})

      assert new_model.name == "John"
    end

    test "Undoing the state preserves the order", %{server: pid} do
      {:ok, _new_model} = State.step(pid, {:Name, "John"})
      {:ok, _new_model} = State.step(pid, {:Password, "123"})
      {:ok, new_model} = State.step(pid, {:PasswordAgain, "123"})

      assert new_model ==
        %{
          name: "John",
          password: "123",
          password_again: "123",
        }

      {:ok, old_model} = State.undo(pid)

      assert old_model ==
        %{
          name: "John",
          password: "123",
          password_again: "",
        }
    end

    test "Undoing the initial state is a no-op", %{server: pid} do
      {:ok, _new_model} = State.step(pid, {:Name, "John"})
      {:ok, _new_model} = State.step(pid, {:Name, "Freddy"})
      {:ok, new_model} = State.step(pid, {:Name, "Bob"})

      assert new_model.name == "Bob"

      {:ok, old_model} = State.undo(pid)

      assert old_model.name == "Freddy"

      {:ok, old_model}   = State.undo(pid)
      {:ok, older_model} = State.undo(pid)

      assert old_model == older_model
    end

  end

end
