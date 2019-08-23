defmodule Mockin.Factory do
  use ExMachina.Ecto, repo: Mockin.Repo

  def user_factory do
    %Mockin.Accounts.User{
      email: "john@jacob.com",
      username: "john",
      password: "some password",
      bio: "some bio",
      image: "some image"
    }
  end

  def article_factory do
    %Mockin.Blog.Article{
      body: "some body",
      description: "some description",
      title: "some title",
      tag_list: ["tag1", "tag2"],
      slug: sequence(:slug, &"some-tile-#{&1}"),
      author: build(:user)
    }
  end

  def comment_factory do
    %Mockin.Blog.Comment{
      body: "some body",
      author: build(:user)
    }
  end

  def favorite_factory do
    %Mockin.Blog.Favorite{
      user: build(:user),
      article: build(:article)
    }
  end
end
