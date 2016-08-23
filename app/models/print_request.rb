class PrintRequest < ApplicationRecord
  belongs_to :user
  has_many :print_request_actions
  has_attached_file :print_file

  # TODO: Replace this with actual validation.
  validates :print_file, presence: { message: 'was not uploaded' }
  do_not_validate_attachment_file_type :print_file

  # TODO: Model size can be parsed out of the CMB file; validated to ensure it
  # does not exceed maximum build size.

  validates :model_volume, numericality: { greater_than: 0 }
  validates :support_volume, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validate :due_at_valid


  def due_at_valid
    # TODO: Consider using business_time to specify these bounds in terms of business days, which is more appropriate.
    near_bound = 3.days.from_now
    far_bound = 120.days.from_now
    errors.add(:base, 'Desired completion must be at least 3 full days in advance (i.e., after %s)' % near_bound.to_s(:short)) if (due_at < near_bound)
    errors.add(:base, 'Desired completion must be no more than 120 days in advance (i.e., before %s)' % far_bound.to_s(:short)) if (due_at > far_bound)
  end

  def status
    self.print_request_actions.order(created_at: :desc).first.print_request_status
  end
  def status_bar
    status_name = status.name
    status_order = status.order

    case status_order
      when 0
        bar = "<div class=\"progress-bar progress-bar-danger\" role=\"progressbar\" style=\"width: 100%\">#{status_name}</div>"
      when 1000, 1100
        bar = "<div class=\"progress-bar progress-bar-danger\" role=\"progressbar\" style=\"width: 25%\">#{status_name}</div>"
      when 1500
        bar = "<div class=\"progress-bar progress-bar-info\" role=\"progressbar\" style=\"width: 30%\">#{status_name}</div>"
      when 3000
        bar = "<div class=\"progress-bar progress-bar-success\" role=\"progressbar\" style=\"width: 35%\">#{status_name}</div>"
      when 3500
        bar = "<div class=\"progress-bar progress-bar-success\" role=\"progressbar\" style=\"width: 50%\">#{status_name}</div>"
      when 5000
        bar = "<div class=\"progress-bar progress-bar-info progress-bar-striped active\" role=\"progressbar\" style=\"width: 65%\">#{status_name}</div>"
      when 5500
        bar = "<div class=\"progress-bar progress-bar-warning progress-bar-striped active\" role=\"progressbar\" style=\"width: 80%\">#{status_name}</div>"
      when 7000
        bar = "<div class=\"progress-bar progress-bar-success\" role=\"progressbar\" style=\"width: 95%\">#{status_name}</div>"\
        "<div class=\"progress-bar progress-bar-warning\" role=\"progressbar\" style=\"width: 5%\"></div>"
      when 7500, 9000
        bar = "<div class=\"progress-bar progress-bar-success\" role=\"progressbar\" style=\"width: 100%\">#{status_name}</div>"
      else
        bar = "<div class=\"progress-bar\" role=\"progressbar\" style=\"width: 100%\">Status Unknown</div>"
    end

    "<div class=\"progress\">#{bar}</div>".html_safe
  end
  def status_time
    latest = self.print_request_actions.order(created_at: :desc).first
    time = latest.created_at.to_s(:short)

    "<small><strong>#{time}</strong></small>".html_safe
  end

end
