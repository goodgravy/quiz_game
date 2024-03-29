defmodule QuizGame do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(QuizGame.Repo, []),
      # Start the endpoint when the application starts
      supervisor(QuizGame.Endpoint, []),
      # Start your own worker by calling: QuizGame.Worker.start_link(arg1, arg2, arg3)
      # worker(QuizGame.Worker, [arg1, arg2, arg3]),
      supervisor(QuizGame.Game.Supervisor, []),
      supervisor(Registry, [:unique, :game_registry]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QuizGame.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    QuizGame.Endpoint.config_change(changed, removed)
    :ok
  end

  @doc """
  Each player needs a unique id, this creates a random one
  """
  def generate_player_id do
    id_length
    |> :crypto.strong_rand_bytes
    |> Base.url_encode64()
    |> binary_part(0, id_length)
  end

  defp id_length, do: Application.get_env(:quiz_game, :id_length)
end
