class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def create
    @search = Search.new(params[:search])
    if @search.type == 'user'
      @users = @search.users
    end
 #   redirect_to 'users/index'

    render :action => users_search_path
  end

  def users
    @title = 'Rezultati'
  end

end

