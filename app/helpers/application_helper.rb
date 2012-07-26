module ApplicationHelper

  # return the full title for a page = base title plus sub-title
  def full_title(page_title)
    base_title = 'Sample App'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
end
