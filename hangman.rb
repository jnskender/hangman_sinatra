class Hangman

  attr_accessor :secret_word, :correct_guesses, :incorrect_guesses, :turns

  def initialize()
    @secret_word = get_word
    @turns = 8
    @correct_guesses = []
    @secret_word.length.times { @correct_guesses << "_" }
    @incorrect_guesses = []
  end

    def get_word
        words = File.readlines('dictionary.txt')
        game_words = []

        words.each do |word|
            word.gsub!(/\s+/, '')
            game_words << word if word.length.between?(5, 12) && word[0] != word[0].upcase
        end
        game_words[rand(0...game_words.size)]
    end

    def check_winner
        return true if !@correct_guesses.include? "_"
        false
    end

    def check_loser
        return false if @turns > 1
        true
    end

    def make_guess(char)
      if @secret_word.include? char
        occurences = (0...@secret_word.length).find_all { |i| @secret_word[i] == char } # check for multiple occurences
        occurences.each { |i| @correct_guesses[i] = char }
        return true
      else
        if @incorrect_guesses.include? char
             return false
        else
            @incorrect_guesses << char
            @turns -= 1
            return false
        end
      end
    end

end
