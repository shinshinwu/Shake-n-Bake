class User <ActiveRecord::Base
	has_many :surveys

  validates :username, :presence => true
  validates :email, :presence => true
  validates :password_hash, :presence => true

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(params)
    user = User.find_by(email: params[:email])
    (user && user.password == params[:password]) ? user : nil
  end

end
