class PageController < ApplicationController

  def home
    @news = News.find(:all, :order => "created_at DESC" )
  end

end

