require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def word_check
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.open(url).read
    @check = JSON.parse(word_serialized)
    return @check
  end

  def score
    # The word can’t be built out of the original grid
    # The word is valid according to the grid, but is not a valid English word
    # The word is valid according to the grid and is an English word
    @word = params[:word]
    @letters = params[:letters]
    @check = word_check
    @word_array = @word.split("")
    @letters_array = @letters.split(" ")
    if @check["found"] == false
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
    elsif @word_array.all? { |letter| @word_array.count(letter) <= @letters_array.count(letter) } == false
      @message = "Sorry but #{@word} can't be built out of #{@letters}"
    else
      @message = "Congratulations! #{@word} is a valid English word!"
    end
  end
end
