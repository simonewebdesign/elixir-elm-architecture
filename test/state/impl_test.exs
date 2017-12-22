defmodule State.ImplTest do
  use ExUnit.Case, async: true
  import State.Impl

  describe "step" do
    test "updates the model" do
      state = %{module: Counter, frames: [], initial_model: 0}
      expected_frame = %{message: :Increment, model: 1}

      assert step(:Increment, state) == { 1, expected_frame }
    end
  end


  describe "undo" do

    @tag :skip
    test "can revert a change" do

    end

    @tag :skip
    test "is idempotent" do

    end
  end

end
