# StartApp.start
{:ok, pid} = Main.main

State.step(pid, :Increment)
