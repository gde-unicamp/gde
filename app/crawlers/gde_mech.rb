require 'mechanize'

class GdeMech < Mechanize

  def extract_str(xpath)
    clean_str(page.at(xpath).text)
  end

  def extract_int(xpath)
    page.at(xpath).text[/\d+/].to_i
  end

  def clean_str(string)
    string.mb_chars.tidy_bytes.gsub(/(\s{2,}|\u00a0)/, ' ').strip.to_s
  end
end
