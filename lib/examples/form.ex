defmodule Form do

  # MODEL

  @type model :: %{
    name: String.t,
    password: String.t,
    password_again: String.t
  }

  @initial_model %{
    name: "",
    password: "",
    password_again: ""
  }

  def model do
    @initial_model
  end


  # UPDATE

  @type msg ::
       {:Name, String.t}
     | {:Password, String.t}
     | {:PasswordAgain, String.t}


  @spec update(msg, model) :: model
  def update(msg, model) do
    case msg do
      {:Name, name} ->
        %{ model | name: name }

      {:Password, password} ->
        %{ model | password: password }

      {:PasswordAgain, password} ->
        %{ model | password_again: password }
    end
  end


  # VIEW

  @spec view(model) :: String.t
  def view(model) do
    """
    Name:              #{model.name}
    Password:          #{model.password}
    Re-enter Password: #{model.password_again}
    """
  end

end
