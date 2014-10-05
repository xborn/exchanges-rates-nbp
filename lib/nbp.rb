require 'exchanges/version'
require 'exchanges/rates'
require 'exchanges/import'

class Nbp
  def self.root
    File.expand_path('../..', __FILE__)
  end
end