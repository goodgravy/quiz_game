defmodule QuizGame.PageController do
  use QuizGame.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
