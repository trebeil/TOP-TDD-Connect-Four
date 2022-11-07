# frozen_string_literal: true

class Game
  def initialize
    @player = 1
    @board = [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
              [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
              [0, 0, 0, 0, 0, 0]]
  end

  def welcome
    puts 'Welcome to Connect Four!'
    sleep 1
    puts "Player 1 will be represented by \u25CF"
    sleep 1
    puts "Player 2 will be represented by \e[31m\u25CF\e[0m"
    sleep 2
    puts "Let's start!"
    sleep 1
  end

  def choose_column
    from_to = {
      'A' => @board[0],
      'B' => @board[1],
      'C' => @board[2],
      'D' => @board[3],
      'E' => @board[4],
      'F' => @board[5],
      'G' => @board[6]
    }

    choice = nil

    puts "Player #{@player} turn. Please choose a column:"

    until from_to[choice] && from_to[choice].index(0)
      choice = gets.chomp
      puts 'Column full. Please choose another column:' unless from_to[choice].nil? || from_to[choice].index(0)
      puts 'Invalid column name. Please choose another column:' unless from_to[choice]
    end

    from_to[choice][from_to[choice].index(0)] = @player == 1 ? 1 : -1

    @player = @player == 1 ? 2 : 1
  end

  def game_end?
    (0..3).each do |i|
      (0..5).each do |j|
        sum = @board[i][j] + @board[i + 1][j] + @board[i + 2][j] + @board[i + 3][j]
        case sum
        when 4
          puts 'Player 1 wins!'
          return true
        when -4
          puts 'Player 2 wins!'
          return true
        end
      end
    end

    (0..6).each do |i|
      (0..2).each do |j|
        sum = @board[i][j] + @board[i][j + 1] + @board[i][j + 2] + @board[i][j + 3]
        case sum
        when 4
          puts 'Player 1 wins!'
          return true
        when -4
          puts 'Player 2 wins!'
          return true
        end
      end
    end

    (0..3).each do |i|
      (0..2).each do |j|
        sum = @board[i][j] + @board[i + 1][j + 1] + @board[i + 2][j + 2] + @board[i + 3][j + 3]
        case sum
        when 4
          puts 'Player 1 wins!'
          return true
        when -4
          puts 'Player 2 wins!'
          return true
        end
      end
    end

    (0..3).each do |i|
      (3..5).each do |j|
        sum = @board[i][j] + @board[i + 1][j - 1] + @board[i + 2][j - 2] + @board[i + 3][j - 3]
        case sum
        when 4
          puts 'Player 1 wins!'
          return true
        when -4
          puts 'Player 2 wins!'
          return true
        end
      end
    end

    @board.each do |element|
      return false if element.index(0)
    end

    puts 'It\'s a draw!'
    true
  end

  def display_board
    puts " \e[1mA B C D E F G\e[0m"
    puts num_to_char(@board[0][5]) + num_to_char(@board[1][5]) + num_to_char(@board[2][5]) + num_to_char(@board[3][5]) +
         num_to_char(@board[4][5]) + num_to_char(@board[5][5]) + num_to_char(@board[6][5])
    puts num_to_char(@board[0][4]) + num_to_char(@board[1][4]) + num_to_char(@board[2][4]) + num_to_char(@board[3][4]) +
         num_to_char(@board[4][4]) + num_to_char(@board[5][4]) + num_to_char(@board[6][4])
    puts num_to_char(@board[0][3]) + num_to_char(@board[1][3]) + num_to_char(@board[2][3]) + num_to_char(@board[3][3]) +
         num_to_char(@board[4][3]) + num_to_char(@board[5][3]) + num_to_char(@board[6][3])
    puts num_to_char(@board[0][2]) + num_to_char(@board[1][2]) + num_to_char(@board[2][2]) + num_to_char(@board[3][2]) +
         num_to_char(@board[4][2]) + num_to_char(@board[5][2]) + num_to_char(@board[6][2])
    puts num_to_char(@board[0][1]) + num_to_char(@board[1][1]) + num_to_char(@board[2][1]) + num_to_char(@board[3][1]) +
         num_to_char(@board[4][1]) + num_to_char(@board[5][1]) + num_to_char(@board[6][1])
    puts num_to_char(@board[0][0]) + num_to_char(@board[1][0]) + num_to_char(@board[2][0]) + num_to_char(@board[3][0]) +
         num_to_char(@board[4][0]) + num_to_char(@board[5][0]) + num_to_char(@board[6][0])
  end

  def num_to_char(num)
    return " \u25CB" if num.zero?
    return " \u25CF" if num == 1
    return " \e[31m\u25CF\e[0m" if num == -1
  end
end
