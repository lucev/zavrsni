class PageController < ApplicationController

  def home
    @title = 'Početna'
    @news = News.find(:all, :order => "created_at DESC" )
    @events = Event.find(:all, :order => "start_date ASC")
  end

  def calendar
    @title = 'Kalendar'
  end

end

