class PageController < ApplicationController

  def home
    @news = News.find(:all, :order => "created_at DESC" )
    @events = Event.find(:all, :order => "start_date ASC")
  end

end

