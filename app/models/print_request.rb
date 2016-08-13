class PrintRequest < ApplicationRecord
  belongs_to :user
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

end
