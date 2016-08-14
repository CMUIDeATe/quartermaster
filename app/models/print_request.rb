class PrintRequest < ApplicationRecord
  belongs_to :user
  has_many :print_request_actions

  has_attached_file :print_file
  # TODO: Replace this with actual validation.
  do_not_validate_attachment_file_type :print_file

  # TODO: Model size can be parsed out of the CMB file; validated to ensure it
  # does not exceed maximum build size.

  validate :due_at_valid

  def due_at_valid
    errors.add(:due_at, 'must be at least 3 days in advance') if (due_at < 3.days.from_now)
    errors.add(:due_at, 'must be no more than 120 days in advance') if (due_at > 120.days.from_now)
  end

  def status_bar
    latest = self.print_request_actions.order(created_at: :desc).first
    status = latest.print_request_status.name
    status_order = latest.print_request_status.order

    case status_order
      when 0
        bar = "<div class=\"progress-bar progress-bar-danger\" role=\"progressbar\" style=\"width: 100%\">#{status}</div>"
      when 1000
        bar = "<div class=\"progress-bar progress-bar-warning\" role=\"progressbar\" style=\"width: 10%\">#{status}</div>"
      when 1500
        bar = "<div class=\"progress-bar progress-bar-info\" role=\"progressbar\" style=\"width: 20%\">#{status}</div>"
      when 3000
        bar = "<div class=\"progress-bar progress-bar-success\" role=\"progressbar\" style=\"width: 30%\">#{status}</div>"
      when 3500
        bar = "<div class=\"progress-bar progress-bar-success\" role=\"progressbar\" style=\"width: 40%\">#{status}</div>"
      when 5000
        bar = "<div class=\"progress-bar progress-bar-info progress-bar-striped active\" role=\"progressbar\" style=\"width: 60%\">#{status}</div>"
      when 5500
        bar = "<div class=\"progress-bar progress-bar-warning progress-bar-striped active\" role=\"progressbar\" style=\"width: 80%\">#{status}</div>"
      when 7000
        bar = "<div class=\"progress-bar progress-bar-success\" role=\"progressbar\" style=\"width: 90%\">#{status}</div>"\
        "<div class=\"progress-bar progress-bar-warning\" role=\"progressbar\" style=\"width: 10%\"></div>"
      when 7500, 9000
        bar = "<div class=\"progress-bar progress-bar-success\" role=\"progressbar\" style=\"width: 100%\">#{status}</div>"
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
