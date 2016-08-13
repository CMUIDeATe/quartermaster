class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include Gravtastic
  gravtastic secure: true, size: 20, rating: 'G', default: 'identicon'

  def andrewid
    if self.email.ends_with? "@andrew.cmu.edu"
      "#{self.email.gsub("@andrew.cmu.edu", "")}"
    else
      "#{self.email}"
    end
  end

end
