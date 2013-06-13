class SessionController < ApplicationController
  skip_before_filter :store_target_url

  def signin
    redirect_to session[:target_url] and return if session[:access_token]
    redirect_to GithubOAuth.authorize_url ENV["GITHUB_ID"], ENV["GITHUB_TOKEN"]
  end

  def auth
    session[:access_token] = GithubOAuth.token ENV["GITHUB_ID"], ENV["GITHUB_TOKEN"], params[:code]
    redirect_to session[:target_url]
  end

  def signout
    session[:access_token] = nil
    redirect_to '/'
  end
end
