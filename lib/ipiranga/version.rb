module Ipiranga
  # Joins the version numbers
  VERSION = [0, 0, 5, 1].join('.')

  # Returns {VERSION}
  # @return [String]
  def self.version
    VERSION
  end
end
