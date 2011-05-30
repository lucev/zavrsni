class NewsController < ApplicationController
  before_filter :authenticate, :only => [:new, :edit, :update]
  # GET /news
  # GET /news.xml
  def index
    @news = News.all
    @title = 'Novosti'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @news }
    end
  end

  # GET /news/1
  # GET /news/1.xml
  def show
    @news = News.find(params[:id])
    @title = @news.title

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @news }
    end
  end

  # GET /news/new
  # GET /news/new.xml
  def new
    @news = News.new
    @title = 'Nova obavijest'

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @news }
    end
  end

  # GET /news/1/edit
  def edit
    @news = News.find(params[:id])
    if authorized_for @news
      @title = 'Izmjena detalja novosti'
    else
      redirect_to news_path(@news), :notice => 'Nemate dovoljno prava za ovu akciju.'
    end
  end

  # POST /news
  # POST /news.xml
  def create
    @news = News.new(params[:news])

    respond_to do |format|
      if @news.save
        format.html { redirect_to(@news, :notice => 'News was successfully created.') }
        format.xml  { render :xml => @news, :status => :created, :location => @news }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /news/1
  # PUT /news/1.xml
  def update
    @news = News.find(params[:id])
    if authorized_for @news
      respond_to do |format|
        if @news.update_attributes(params[:news])
          format.html { redirect_to(@news, :notice => 'News was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to :back, :notice => 'Nemate dovoljno prava za ovu akciju.'
    end
  end

  # DELETE /news/1
  # DELETE /news/1.xml
  def destroy
    @news = News.find(params[:id])
    if authorized_for @news
      @news.destroy

      respond_to do |format|
        format.html { redirect_to(news_index_url) }
        format.xml  { head :ok }
      end
    else
      redirect_to :back, :notice => 'Nemate dovoljno prava za ovu akciju.'
    end
  end
end

