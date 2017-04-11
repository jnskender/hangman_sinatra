require 'sinatra'
require 'sinatra/reloader' if development?
require './hangman.rb'

enable :sessions

hangman = Hangman.new

#set :word , hangman.secret_word


get '/' do
    guess = params[:guess]
    hangman = Hangman.new unless !guess.nil?
    #redirect to("/new_game") if hangman.check_loser
    redirect to("/game_over") if hangman.check_loser
    hangman.make_guess(guess) unless guess.nil?
    @winner = hangman.check_winner
    session[:word] = hangman.secret_word
    session[:correct_guesses] = hangman.correct_guesses
    session[:turns] = hangman.turns
    session[:incorrect_guesses] = hangman.incorrect_guesses
    erb :home
end

get '/new_game' do
  session.clear
  redirect to("/")
end

get '/game_over' do
  erb :gameover
end
