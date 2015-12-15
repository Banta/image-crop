require 'image/crop/engine'
require 'image/crop/version'

module Image
  module Crop
    # Load configuration from initializer
    def self.setup
      yield self
    end
  end
end
