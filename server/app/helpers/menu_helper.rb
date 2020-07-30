module MenuHelper
  def menu_link(paths, icon_class = nil, options = nil, html_options = {}, &block)
    # anchor class
    html_options['class'] = "
      flex flex-wrap content-center justify-center
      h-20 w-20 outline-none
      opacity-50 hover:opacity-100 active:opacity-100 focus:opacity-100
      #{html_options['class']}
    "

    # link active
    html_options['class'] += ' opacity-100' if menu_item_active?(paths)

    # icon
    icon_class = "fas text-4xl #{icon_class}"
    icon = content_tag :i, nil, class: icon_class

    # return anchor tag
    link_to icon, options, html_options, &block
  end

  def menu_item_active?(paths)
    # never active
    return false if paths.nil?

    # normalize arguments
    paths = [paths] unless paths.is_a? Array

    paths.each do |path|
      # page active
      return true if current_page? path
    end

    # page not active
    false
  end
end
