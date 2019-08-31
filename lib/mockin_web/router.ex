defmodule MockinWeb.Router do
  use MockinWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(ProperCase.Plug.SnakeCaseParams)
  end

  scope "/", MockinWeb do
    pipe_through(:api)

    # Route routes
    get("/route", RouteController, :index)
    post("/route", RouteController, :create)

    # User routes
    get("/user", UserController, :index)
    post("/user", UserController, :create)

    # Segment routes
    get("/segment", SegmentController, :index)
    # post("/segment", UserController, :create)

    # SubSegment routes
    get("/subsegment", SubSegmentController, :index)

    # get("/articles/feed", ArticleController, :feed)

    # resources "/articles", ArticleController, except: [:new, :edit] do
    #   resources("/comments", CommentController, except: [:new, :edit])
    # end

    # # to allow comments_path in test
    # resources("/comments", CommentController, except: [:new, :edit])

    # post("/articles/:slug/favorite", ArticleController, :favorite)
    # delete("/articles/:slug/favorite", ArticleController, :unfavorite)

    # get("/tags", TagController, :index)
    # get("/user", UserController, :current_user)
    # put("/user", UserController, :update)
    # post("/users", UserController, :create)
    # post("/users/login", SessionController, :create)

    # get("/profiles/:username", ProfileController, :show)
    # post("/profiles/:username/follow", ProfileController, :follow)
    # delete("/profiles/:username/follow", ProfileController, :unfollow)
  end
end
