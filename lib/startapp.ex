defmodule StartApp do
  # figure out where to feed messages.
  def start(config) do
    {:ok, pid} = State.start_link(config)
  end
end
