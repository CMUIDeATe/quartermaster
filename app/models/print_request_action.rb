class PrintRequestAction < ApplicationRecord
  belongs_to :print_request
  belongs_to :print_request_status
  belongs_to :user

  def to_s
    "<small>#{self.created_at.to_s(:short)}</small> <strong>#{print_request_status.name}</strong> (#{self.user.andrewid})".html_safe
  end

end
