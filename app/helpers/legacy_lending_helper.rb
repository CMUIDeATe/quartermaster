module LegacyLendingHelper

  def nav_link(text, path, link_options = {})
    options = current_page?(path) ? { class: "active" } : {}
    content_tag(:li, options) do
      link_to text, path, link_options
    end
  end

end
