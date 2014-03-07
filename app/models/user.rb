class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  # devise :rememberable, :trackable
  devise :omniauthable

  def self.retrieve_or_create(user_info)
    existing_user = User.where(:provider => user_info.provider, :uid => user_info.uid).first

    if existing_user
      return existing_user
    else
      existing_user = User.create(:provider => user_info.provider, :uid => user_info.uid)
    end 
  end

end
