module ApplicationHelper
  def ugly_lyrics(lyrics)
    formatted_lyrics = ""
    lyrics.lines.map do |line|
      "&#9835 #{line}"
    end.safe_join

    "<pre>#{formatted_lyrics}</pre>".html_safe
  end
end
