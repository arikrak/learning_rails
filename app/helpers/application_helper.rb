module ApplicationHelper

  def full_title(page_title)
    btitle =  "Ruby on Rails"
      if page_title.empty?
        return btitle
      else
          return "#{btitle} | #{page_title}"
      end
  end
end
