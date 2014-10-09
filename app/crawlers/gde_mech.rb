require 'mechanize'

#
# A Mech class that should be extended to make crawlers.
# Here you'll find some auxiliar methods to extract data from HTML
#
class GdeMech < Mechanize

  # Extract a clean string from a node founded by the given xpath
  #
  # @param xpath [String] the xpath with the string location
  # @return [String] a clean string extracted from the HTML
  def extract_str(xpath)
    clean_str(page.at(xpath).text)
  end

  # Extract an integer from a node founded by the given xpath
  #
  # @param xpath [String] the xpath with the integer location
  # @return [Integer] the integer extracted from the html
  def extract_int(xpath)
    page.at(xpath).text[/\d+/].to_i
  end

  # Cleans a string, removing trailing spaces, converting all
  # characters to UTF-8, removing duplicated spaces and
  # removing \xC2\xA0 characters
  #
  # @param string [String] any string
  # @return [String] the clean version of the string
  def clean_str(string)
    string.mb_chars.tidy_bytes.gsub(/(\s{2,}|\u00a0)/, ' ').strip.to_s
  end
end
