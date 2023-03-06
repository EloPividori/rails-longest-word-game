require 'open-uri'

class GamesController < ApplicationController
  def new
    string = (0...10).map { ('A'..'Z').to_a[rand(26)] }
    @letters = string.to_a
  end

  def score
    @word = params[:word]
    @grid = params[:grid]

    if !grid_word
      @result = "Sorry but #{@word} can't be built out of #{@grid}"
    elsif !valid_word
      @result = "Sorry but #{@word} does not seem to be a valid English word..."
    elsif grid_word && !valid_word
      @result = "Sorry but #{@word} does not seem to be a valid English word..."
    elsif grid_word && valid_word
      @result = "Congratulations! #{@word} is a valid English word!"
    end
  end

  private

  def valid_word
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"

    serialized_words = URI.open(url).read
    JSON.parse(serialized_words)
  end

  def grid_word
    @word.downcase.chars.all? { |letter| @grid.downcase.include?(letter) }
  end
end
