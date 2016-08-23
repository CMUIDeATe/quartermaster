class User < ApplicationRecord
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:shibboleth]

  include Gravtastic
  gravtastic secure: true, size: 20, rating: 'G', default: 'identicon'

  def andrewid
    if self.email.ends_with? "@andrew.cmu.edu"
      "#{self.email.gsub("@andrew.cmu.edu", "")}"
    else
      "#{self.email}"
    end
  end

  def self.find_for_shibboleth_oauth(request, signed_in_resource=nil)
    user = User.where(:email => request.env['REMOTE_USER']).first
    unless user
      user = User.create(email: request.env['REMOTE_USER'],
                         password: Devise.friendly_token[0,20])
    end
    return user
  end


end
