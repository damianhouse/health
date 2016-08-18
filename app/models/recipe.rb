require 'httparty'

class Recipe
  def initialize
    @recipe = HTTParty.get("https://api.knackhq.com/v1/objects/object_1/records",:headers => { "Content-Type" => "application/json","X-Knack-Application-Id":"5758346f7b9005881941f3f8","X-Knack-REST-API-Key":"74b650b0-4470-11e6-a821-f926d92f6f11"})
    # @search_term = HTTParty.get("https://api.spotify.com/v1/search?q=%22#{search_term}%22&type=playlist")
  end

  def length
    @recipe["records"].length
  end

  def random_recipe
    numero = rand(0..(self.length-1))
    @recipe["records"][numero]
  end

end
