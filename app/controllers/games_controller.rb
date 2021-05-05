class GamesController < ApplicationController
  helper_method :score
  def new
    @letters = (0..9).map { (65 + rand(26)).chr }
  end

  def score
    @attempt = params[:attempt]
    require 'json'
    require 'open-uri'
    
    letters = params[:letters].split(" ")
    user_letters = @attempt.split("")
    valid_letters = user_letters.map { |letter| letters.include? letter }
    word = @attempt.downcase
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    result_serialized = URI.open(url).read
    result = JSON.parse(result_serialized)

    if valid_letters.include? false
      "Sorry but #{word.upcase} can't be build out of #{params[:letters]}"
    elsif result["found"]
      "Congratulations! #{word.upcase} is a valid English word!"
    else
      "Sorry but #{word.upcase} does not seem to be a valid English word..."
    end

  end

end
