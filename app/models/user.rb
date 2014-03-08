class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  # devise :rememberable, :trackable
  devise :omniauthable

  def self.retrieve_or_create(auth_hash)
    existing_user = User.where(:provider => auth_hash.provider, :uid => auth_hash.uid).first

    if existing_user
      return existing_user
    else
      existing_user = User.create(:provider => auth_hash.provider, :uid => auth_hash.uid)
    end 
  end

end
