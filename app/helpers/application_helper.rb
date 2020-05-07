module ApplicationHelper

  def auth_token
    # This creates us an auth token tage with ruby.
    # We need to embed with ruby, and clean our output so we dont get XSS
    html= '<input type="hidden" name="authenticity_token"'
    html+= "value=\"#{h(form_authenticity_token)}\"/>"

    html.html_safe
  end

  def ugly_lyrics(lyrics)
    split_lyrics = lyrics.split("\r\n")

    html = ""
    split_lyrics.each do |line|
      if line.length > 0
        html += '<pre>'
        html += '&#9835; '
        html += "#{h(line)}"
        html += '</pre>'
      end
    end

    html.html_safe

  end

end
