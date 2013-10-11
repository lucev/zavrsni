class User < ActiveRecord::Base
  attr_protected :password_hash, :password_salt
  attr_accessor :password, :avatar


  has_attached_file :avatar, :storage => :s3,
                                         :bucket => 'tigris',
                                         :s3_credentials => {
                                            :access_key_id => ENV['S3_KEY'],
                                            :secret_access_key => ENV['S3_SECRET']
                                          },
                                          :styles => { :medium => "200x200>", :thumb => "100x100>"}



#  validates_attachment_presence :avatar

 # validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']

  has_many :participations
  has_many :events, :through => :participations
  has_many :news

  before_save :encrypt_password

  validates_presence_of :name, :surname, :email
  validates_presence_of :password, :on => :create

  validates_confirmation_of :password

  validates_format_of   :email,
                        :with       => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                        :message    => 'email must be valid'
  validates_uniqueness_of :email

  def self.inherited(child)
    child.instance_eval do
      def model_name
        User.model_name
      end
    end
    super
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['lower(name) LIKE ? or lower(surname) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%"],
                 :order => "surname, name ASC")
    else
      find(:all, :order => "surname, name ASC")
    end
  end

  def self.select_options
    subclasses.map{ |c| c.to_s }.sort
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end

