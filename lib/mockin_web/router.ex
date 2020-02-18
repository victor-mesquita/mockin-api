defmodule MockinWeb.Router do
  use MockinWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(ProperCase.Plug.SnakeCaseParams)
  end

  scope "/api/", MockinWeb do
    pipe_through(:api)

    # Route routes
    get("/route/:id", RouteController, :get)
    get("/route", RouteController, :index)
    post("/route", RouteController, :create)
    put("/route", RouteController, :update)
    delete("/route/:id", RouteController, :delete)

    # Route routes
    get("/routeDetail/:user_id/:route_id", RouteDetailController, :get)
    post("/routeDetail/", RouteDetailController, :create)
    put("/routeDetail/", RouteDetailController, :update)
    delete("/routeDetail/:id", RouteDetailController, :delete)

    # User routes
    get("/user/:id", UserController, :get)
    get("/user", UserController, :index)
    post("/user", UserController, :create)
    put("/user", UserController, :update)
    delete("/user/:id", UserController, :delete)

    # Segment routes
    get("/segment", SegmentController, :index)
    # post("/segment", UserController, :create)

    # SubSegment routes
    get("/subsegment", SubSegmentController, :index)
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
