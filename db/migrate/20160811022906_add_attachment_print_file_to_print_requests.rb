class AddAttachmentPrintFileToPrintRequests < ActiveRecord::Migration
  def self.up
    change_table :print_requests do |t|
      t.attachment :print_file
    end
  end

  def self.down
    remove_attachment :print_requests, :print_file
  end
end
