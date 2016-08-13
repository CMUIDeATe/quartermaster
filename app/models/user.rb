class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def andrewid
    if self.email.ends_with? "@andrew.cmu.edu"
      "#{self.email.gsub("@andrew.cmu.edu", "")}"
    else
      "#{self.email}"
    end
  end

end
