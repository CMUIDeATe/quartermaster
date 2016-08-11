class PrintRequest < ApplicationRecord
  belongs_to :user

  def to_s
    "##{self.id}: #{self.user.email} (#{self.created_at})"
  end
end
