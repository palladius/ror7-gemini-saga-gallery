module ApplicationHelper
  # tahks gemini
  def h1(text)
    content_tag(:h1, text, class: "text-3xl font-bold mb-4 text-blue-600")
  end

  def h2(text)
    content_tag(:h2, text, class: "text-2xl font-semibold mb-2 text-gray-800")
  end

  def fancy_link_to(name, options = {}, html_options = {}, &block)
    html_options[:class] = "text-blue-500 hover:text-blue-700 underline" # Add Tailwind CSS classes
    link_to(name, options, html_options, &block)
  end
  def gemini_fancy_text(text)
    content_tag(:span, text, class: "font-bold text-transparent bg-clip-text bg-gradient-to-r from-blue-500 to-red-500")
  end

end
