module ApplicationHelper
  # tahks gemini
  def h1(text)
    content_tag(:h1, text, class: "text-3xl font-bold mb-4 text-blue-600")
  end

  def h2(text)
    content_tag(:h2, text, class: "text-2xl font-semibold mb-2 text-gray-800")
  end
end
