class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  # devise :rememberable, :trackable
  devise :omniauthable
  has_many :lists

  validates :provider, :uid, :nickname, presence: true

  def self.retrieve_or_create(auth_hash)
    existing_user = User.where(:provider => auth_hash.provider, :uid => auth_hash.uid).first

    if existing_user
      return existing_user
    else
      logger.info "#{auth_hash}"
      existing_user = User.create( :provider => auth_hash.provider,
        :uid => auth_hash.uid,
        :nickname => auth_hash.info.nickname )
    end 
  end
end
