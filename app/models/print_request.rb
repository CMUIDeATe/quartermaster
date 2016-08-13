class PrintRequest < ApplicationRecord
  belongs_to :user
  has_attached_file :print_file
  # TODO: Replace this with actual validation.
  do_not_validate_attachment_file_type :print_file

  # TODO: Model size can be parsed out of the CMB file; validated to ensure it
  # does not exceed maximum build size.

  def to_s
    "##{self.id}: #{self.user.email} (#{self.created_at})"
  end
end
