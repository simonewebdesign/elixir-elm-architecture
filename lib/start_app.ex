defmodule StartApp do
  @spec start(module) :: {:ok, term}
  def start(config) do
    {:ok, _pid} = State.start_link(config)
  end
end
