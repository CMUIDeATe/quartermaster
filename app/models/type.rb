class Type < ApplicationRecord
  has_and_belongs_to_many :items

  def to_s
    return name
  end

end
