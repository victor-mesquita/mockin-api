defmodule MockinWeb.Router do
  use MockinWeb, :router
  use Pow.Phoenix.Router

  pipeline :mockinapi do
    plug(:accepts, ["json"])
    plug(ProperCase.Plug.SnakeCaseParams)
    plug MockinWeb.APIAuthPlug, otp_app: :mockin
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: MockinWeb.APIAuthErrorHandler
  end


  scope "/mockinapi/", MockinWeb do
    pipe_through :mockinapi

    resources "/registration", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew

    pipe_through :protected

    # Route routes
    get("/route/:id", RouteController, :get)
    get("/route/", RouteController, :index)
    post("/route", RouteController, :create)
    put("/route", RouteController, :update)
    delete("/route/:id", RouteController, :delete)

    # MockUser routes
    get("/mock-user/:id", MockUserController, :get)
    get("/mock-user", MockUserController, :index)
    post("/mock-user", MockUserController, :create)
    put("/mock-user", MockUserController, :update)
    delete("/mock-user/:id", MockUserController, :delete)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(ProperCase.Plug.SnakeCaseParams)
  end

  scope "/", MockinWeb do
    pipe_through(:api)


    get "/*path", DynamicController, :get
    post "/*path", DynamicController, :post
    put "/*path", DynamicController, :put
    patch "/*path", DynamicController, :patch
    delete "/*path", DynamicController, :delete
  end

end
