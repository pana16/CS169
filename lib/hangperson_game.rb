class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    count = 0
    @guesses.each_char {|g| return false if letter==g}
    @wrong_guesses.each_char {|g| return false if letter==g}
    @word.each_char {|w| count +=1 if w==letter}
    if count > 0
      @guesses +=letter
    else
      @wrong_guesses +=letter
      return false if @wrong_guesses.length > 7
    end
    return true
  end
  
  def guess_several_letters(letters)
    letters.each_char do |letter|
      return true if guess(letter)
    end
    return false
  end

end
