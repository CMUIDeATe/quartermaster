module ApplicationHelper

  def app_version
    if Rails.env.development?
      begin
        %x{git log --pretty=format:"%h" -n1}
      rescue
        "?"
      end
    else
      File.read(Rails.root.join("REVISION"))[0..6]
    end
  end

end
