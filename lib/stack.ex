# Elixir list is already a stack so I'm not going to need this

# defmodule Stack do
#   @moduledoc """
#   Collect all the triggered messages and ensures that they are executed
#   in the correct order.
#   """
#   use GenServer

#   # Client API

#   def start_link do
#     GenServer.start_link(__MODULE__, [])
#   end

#   def push(pid, item) do
#     GenServer.call(pid, {:push, item})
#   end

#   def pop(pid) do
#     GenServer.call(pid, :pop)
#   end

#   # Server (callbacks)

#   def handle_call({:push, item}, _from, stack) do
#     {:reply, [item | stack]}
#   end

#   def handle_call(:pop, _from, [h | t]) do
#     {:reply, h, t}
#   end

#   # def handle_call(request, from, state) do
#   #   # Call the default implementation from GenServer
#   #   super(request, from, state)
#   # end

#   # def handle_cast(request, state) do
#   #   super(request, state)
#   # end
# end


# # defmodule State do
# #   @moduledoc """
# #   Handles the events in a stack and in a synchronous way.
# #   """
# #   use GenServer

# #   # def start_link(initial_state) do
# #   #   GenServer.start_link(__MODULE__, [initial_state])
# #   # end

# #   # Callbacks

# #   def handle_call(:pop, _from, [h | t]) do
# #     {:reply, h, t}
# #   end

# #   def handle_call({:push, item}, state) do
# #     {:reply, [item | state]}
# #   end
# # end

# # # Start the server
# # # {:ok, pid} = GenServer.start_link(State, [:hello])

# # # This is the client
# # GenServer.call(pid, :pop)
# # #=> :hello

# # # GenServer.cast(pid, {:push, :world})
# # #=> :ok

# # GenServer.call(pid, :pop)
# # #=> :world
