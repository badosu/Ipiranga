module Ipiranga
  # Major version number
  MAJOR = 0
  # Minor version number
  MINOR = 0
  # Tiny version number
  TINY = 3

  # Joins the version numbers
  VERSION = [MAJOR, MINOR, TINY].join('.')

  # Returns {VERSION}
  # @return [String]
  def self.version
    VERSION
  end
end
