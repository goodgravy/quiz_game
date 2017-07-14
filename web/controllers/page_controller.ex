defmodule QuizGame.PageController do
  @moduledoc """
  A basic controller to show the primary landing pages.
  """
  use QuizGame.Web, :controller

  @doc """
  Players view the welcome screen and every time they do, we generate
  a new random player id that will be used to identify them when they
  join and play games.
  """
  def index(conn, _params) do
    player_id = conn.cookies["player"] || QuizGame.generate_player_id

    conn
    |> put_resp_cookie("player", player_id, max_age: 24*60*60)
    |> render("index.html", id: player_id)
  end
end
