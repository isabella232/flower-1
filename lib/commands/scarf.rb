require 'typhoeus'
require 'nokogiri'
class Scarf < Flower::Command
  respond_to "scarf", "erik"
  URL = "http://reklamaremedhalsdukinomhus.tumblr.com/random"

  def self.description
    "Reklamare med halsduk inomhus"
  end

  def self.respond(command, message, sender, flower)
    flower.say(image)
  end

  def self.image
    document = Nokogiri.HTML(Typhoeus::Request.get(URL, :followlocation => true).body)
    document.at_css(".photo img").attribute('src').value
  end
end
