class PageController < ApplicationController

  def home
    @title = 'Početna'
    @public_news = News.find(:all, :conditions => {:status => 'public'}, :order => "created_at DESC", :limit => 4 )
    @public_count = News.find(:all, :conditions => {:status => 'public'} ).count
    @internal_news = News.find(:all, :conditions => {:status => 'public'}, :order => "created_at DESC" )
    @events = Event.find(:all, :conditions => ["start_date > ?", Date.today], :order => "start_date ASC")
  end

  def calendar
    @title = 'Kalendar'
  end

  def contact
    @title = 'Kontakt'
    @message = Message.new
  end

# PUT receive params and send contact email
  def send_mail
    @message = params[:message]
    user = User.find_by_email('lucev.ivan@gmail.com')
    ContactMailer.contact_message(user, @message).deliver
    redirect_to :back, :notice => 'Uspješno poslan email'
  end

end

