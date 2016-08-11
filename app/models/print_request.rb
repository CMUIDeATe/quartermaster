class PrintRequest < ApplicationRecord
  belongs_to :user
  has_attached_file :print_file
  # TODO: Replace this with actual validation.
  do_not_validate_attachment_file_type :print_file

  def to_s
    "##{self.id}: #{self.user.email} (#{self.created_at})"
  end
end
