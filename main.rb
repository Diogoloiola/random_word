# frozen_string_literal: true

require_relative 'api/word'

class Game
  CHOICES = 4 # quantidade de chances jogadas
  def initialize
    @erros = 0
    @client = Src::Api::Word.new
  end

  def init_game
    puts 'Iniciando o jogo....'
    word = @client.get.word
    loop do
      print_puppet

      caractere = read_user_information

      @erros += 1 unless word.include?(caractere)

      break print_puppet if @erros >= CHOICES
    end

    if @erros >= 4
      puts 'Você perdeu o jogo'
    else
      puts 'Parabéns. Você ganhou'
    end
  end

  def read_user_information
    loop do
      puts 'Infome uma letra'
      caractere = gets.chomp

      return caractere if caractere.size == 1

      puts 'Você só pode digitar um caractere'
    end
  end

  private

  def print_puppet
    printf("  _______       \n")
    printf(" |/      |      \n")
    printf(" |      %c%c%c  \n", (@erros >= 1 ? '(' : ' '), (@erros >= 1 ? '_' : ' '), (@erros >= 1 ? ')' : ' '))
    printf(" |      %c%c%c  \n", (@erros >= 3 ? '\\' : ' '), (@erros >= 2 ? '|' : ' '), (@erros >= 3 ? '/' : ' '))
    printf(" |       %c     \n", (@erros >= 2 ? '|' : ' '))
    printf(" |      %c %c   \n", (@erros >= 4 ? '/' : ' '), (@erros >= 4 ? '\\' : ' '))
    printf(" |              \n")
    printf("_|___           \n")
    printf("\n\n")
  end
end

Game.new.init_game
