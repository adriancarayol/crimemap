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
    pipe_through [:browser, CrimemapWeb.Plugs.Auth]

    delete "/logout", SessionController, :delete
    get "/", PageController, :show

    get "/crimes", CrimeController, :index

    get "/crime", CrimeController, :new
    post "/crime", CrimeController, :create
    get "/crime/:id", CrimeController, :show
    get "/crime/edit/:id", CrimeController, :edit
    put "/crime/edit/:id", CrimeController, :update
    delete "/crime/:id", CrimeController, :delete

    get "/user", UserController, :show
  end

  # API
  scope "/api", CrimemapWeb do
    pipe_through :api

    resources "/crimes", API.CrimeController, only: [:index]
  end
end
