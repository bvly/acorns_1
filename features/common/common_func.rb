module CommonCapy
  include Capybara::DSL

  def find_by_css(my_css)
    page.find(:css,my_css)
  end

  def find_by_css_and_text(my_css, my_text)
    page.find(my_css, :text => my_text)
  end
  
  def trigger_click(elem)
    elem.trigger('click')
  end

end
