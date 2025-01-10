defmodule OctosTestWeb.Router do
  @moduledoc """
  The Router module is responsible for defining the routes and pipelines for the Phoenix application.
  """

  use OctosTestWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", OctosTestWeb do
    pipe_through :api
  end

  if Application.compile_env(:octos_test, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: OctosTestWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  forward "/graphql", Absinthe.Plug, schema: OctosTestWeb.Schema

  if Mix.env() == :dev do
    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: OctosTestWeb.Schema,
      interface: :simple
  end
end
