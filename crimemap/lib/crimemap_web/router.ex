defmodule CrimemapWeb.Router do
  use CrimemapWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CrimemapWeb do
    pipe_through  [:browser, CrimemapWeb.Plugs.Guest]

    resources "/register", UserController, only: [:create, :new]
    get "/login", SessionController, :new
    post "/login", SessionController, :create
  end

  scope "/", CrimemapWeb do
    pipe_through  [:browser, CrimemapWeb.Plugs.Auth]

    delete "/logout", SessionController, :delete
    get "/show", PageController, :show

    get "/user", UserController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", CrimemapWeb do
  #   pipe_through :api
  # end
end
