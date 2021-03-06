class UsersController < ApplicationController
  before_filter :authenticate, :except => [:new, :create]

  # GET /users
  # GET /users.xml
  def index
    condition = params[:search]
    @users = User.search(condition)
    @title = 'Članovi'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @title = "#{@user.name} #{@user.surname}"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @title = 'Novi član'

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    if authorized_for @user
      @title = 'Izmjena detalja člana'
    else
      redirect_to user_path(@user), :notice => 'Nemate dovoljno prava za ovu akciju.'
    end
  end

  # POST /users
  # POST /users.xml
  def create
    @user = Member.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    if authorized_for @user
      respond_to do |format|
        if @user.update_attributes(params[:user])
          @user.avatar = params[:user][:avatar]
          @user.save!
          format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, :notice => 'Nemate dovoljno prava za ovu akciju.'}
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    if authorized_for @user
      @user.destroy
      respond_to do |format|
        format.html { if current_user.id == @user.id
                        redirect_to log_out_path
                      else
                        redirect_to(users_url)
                      end
                    }
        format.xml  { head :ok }
      end
    else
      redirect_to :back, :notice => 'Nemate dovoljno prava za ovu akciju.'
    end
  end

  def detail_search
    @title = 'Napredna pretraga'
    @search = Search.new
  end

end

