require 'sinatra'
require 'sinatra/reloader' if development?

helpers do

  def get_word
    words = File.readlines('dictionary.txt')
    game_words = []

    words.each do |word|
        word.gsub!(/\s+/, '')
        game_words << word if word.length.between?(5, 12) && word[0] != word[0].upcase
    end
    game_words[rand(0...game_words.size)]
  end

end

get '/' do
    @word = get_word
    erb :home
end
