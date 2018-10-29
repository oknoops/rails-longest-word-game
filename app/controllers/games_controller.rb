require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'...'z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    definition = JSON.parse(open(url).read)
    if definition['found'] == false
      @answer = 'Not an english word'
      @score = 0
    elsif @word.chars.all? { |letter| @word.count(letter) <= letters.count(letter) } == false
      @answer = 'Not in the grid'
      @score = 0
    else
      @answer = 'Well Done!'
      @score = @word.length * 10
    end
  end
end
