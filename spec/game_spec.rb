# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { Game.new }

  describe 'choose_column' do
    context 'when player 1 chooses a valid column that is empty' do
      before do
        allow(game).to receive(:gets).and_return('B')
      end

      it 'positions number 1 on the bottom and does not prompt user to choose again' do
        expect(game).to receive(:gets).at_most(:once)
        game.choose_column
        column = game.instance_variable_get(:@board)
        expect(column[1]).to eq([1, 0, 0, 0, 0, 0])
      end

      it 'changes player for the next round' do
        game.choose_column
        player = game.instance_variable_get(:@player)
        expect(player).to eq(2)
      end
    end

    context 'when player 2 chooses a valid column that is empty' do
      before do
        allow(game).to receive(:gets).and_return('B')
        game.instance_variable_set(:@player, 2)
      end

      it 'positions number -1 on the bottom and does not prompt user to choose again' do
        expect(game).to receive(:gets).at_most(:once)
        column = game.instance_variable_get(:@board)
        game.choose_column
        expect(column[1]).to eq([-1, 0, 0, 0, 0, 0])
      end

      it 'changes player for the next round' do
        game.choose_column
        player = game.instance_variable_get(:@player)
        expect(player).to eq(1)
      end
    end

    context 'when player chooses a column that does not have a free spot and then a valid column' do
      before do
        allow(game).to receive(:gets).and_return('A', 'B')
      end

      it "displays 'full column' error message and prompts user to choose again" do
        board = [[1, -1, 1, -1, 1, -1], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
                 [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
                 [0, 0, 0, 0, 0, 0]]
        game.instance_variable_set(:@board, board)
        error_message = 'Column full. Please choose another column:'
        expect(game).to receive(:puts).with(error_message)
        expect(game).to receive(:gets).twice
        game.choose_column
      end
    end

    context 'when player chooses an invalid column name and then a valid column' do
      before do
        allow(game).to receive(:gets).and_return('6', 'B')
      end

      it "displays 'invalid column name' error message and prompts user to choose again" do
        error_message = 'Invalid column name. Please choose another column:'
        expect(game).to receive(:puts).with(error_message)
        expect(game).to receive(:gets).twice
        game.choose_column
      end
    end
  end

  describe 'game_end?' do
    context 'when player 1 aligns 4 pieces along a row' do
      it 'returns true and declares the winner' do
        board = [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
                 [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0],
                 [0, 0, 0, 0, 1, 0]]
        game.instance_variable_set(:@board, board)
        result_message = 'Player 1 wins!'
        expect(game).to receive(:puts).with(result_message)
        result = game.game_end?
        expect(result).to eq(true)
      end
    end

    context 'when player 1 aligns only 3 pieces along a row' do
      it 'returns false and does not display message' do
        board = [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
                 [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0],
                 [0, 0, 0, 0, 0, 0]]
        game.instance_variable_set(:@board, board)
        result_message = 'Player 1 wins!'
        expect(game).not_to receive(:puts).with(result_message)
        result = game.game_end?
        expect(result).to eq(false)
      end
    end

    context 'when player 2 aligns 4 pieces along a row' do
      it 'returns true and declares the winner' do
        board = [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
                 [0, 0, 0, 0, -1, 0], [0, 0, 0, 0, -1, 0], [0, 0, 0, 0, -1, 0],
                 [0, 0, 0, 0, -1, 0]]
        game.instance_variable_set(:@board, board)
        result_message = 'Player 2 wins!'
        expect(game).to receive(:puts).with(result_message)
        result = game.game_end?
        expect(result).to eq(true)
      end
    end

    context 'when player 1 aligns 4 pieces along a column' do
      it 'returns true declares the winner' do
        board = [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
                 [0, 1, 1, 1, 1, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
                 [0, 0, 0, 0, 0, 0]]
        game.instance_variable_set(:@board, board)
        result_message = 'Player 1 wins!'
        expect(game).to receive(:puts).with(result_message)
        result = game.game_end?
        expect(result).to eq(true)
      end
    end

    context 'when player 1 aligns only 3 pieces along a column' do
      it 'returns false and does not display message' do
        board = [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
                 [0, 1, 1, 1, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
                 [0, 0, 0, 0, 0, 0]]
        game.instance_variable_set(:@board, board)
        result_message = 'Player 1 wins!'
        expect(game).not_to receive(:puts).with(result_message)
        result = game.game_end?
        expect(result).to eq(false)
      end
    end

    context 'when player 2 aligns 4 pieces along a column' do
      it 'returns true declares the winner' do
        board = [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
                 [0, -1, -1, -1, -1, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
                 [0, 0, 0, 0, 0, 0]]
        game.instance_variable_set(:@board, board)
        result_message = 'Player 2 wins!'
        expect(game).to receive(:puts).with(result_message)
        result = game.game_end?
        expect(result).to eq(true)
      end
    end
  end

  context 'when player 1 aligns 4 pieces along a diagonal' do
    it 'returns true declares the winner' do
      board = [[0, 0, 0, 0, 0, 0], [0, 1, 0, 0, 0, 0], [0, 0, 1, 0, 0, 0],
               [0, 0, 0, 1, 0, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 0]]
      game.instance_variable_set(:@board, board)
      result_message = 'Player 1 wins!'
      expect(game).to receive(:puts).with(result_message)
      result = game.game_end?
      expect(result).to eq(true)
    end
  end

  context 'when player 1 aligns only 3 pieces along a column' do
    it 'returns false and does not display message' do
      board = [[0, 0, 0, 0, 0, 0], [0, 1, 0, 0, 0, 0], [0, 0, 1, 0, 0, 0],
               [0, 0, 0, 1, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 0]]
      game.instance_variable_set(:@board, board)
      result_message = 'Player 1 wins!'
      expect(game).not_to receive(:puts).with(result_message)
      result = game.game_end?
      expect(result).to eq(false)
    end
  end

  context 'when player 2 aligns 4 pieces along a column' do
    it 'returns true declares the winner' do
      board = [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, -1], [0, 0, 0, 0, -1, 0],
               [0, 0, 0, -1, 0, 0], [0, 0, -1, 0, 0, 0], [0, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 0]]
      game.instance_variable_set(:@board, board)
      result_message = 'Player 2 wins!'
      expect(game).to receive(:puts).with(result_message)
      result = game.game_end?
      expect(result).to eq(true)
    end
  end

  context 'when there are no free spots and no winning condition has been reached' do
    it 'returns true and declares it a draw' do
      board = [[1, -1, 1, -1, 1, -1], [1, -1, 1, -1, 1, -1], [-1, 1, -1, 1, -1, 1],
               [1, -1, 1, -1, 1, -1], [1, -1, 1, -1, 1, -1], [-1, 1, -1, 1, -1, 1],
               [-1, 1, -1, 1, -1, 1]]
      game.instance_variable_set(:@board, board)
      result_message = 'It\'s a draw!'
      expect(game).to receive(:puts).with(result_message)
      result = game.game_end?
      expect(result).to eq(true)
    end
  end

  context 'when there are free spots yet and no winning condition has been reached' do
    it 'returns false and does not display message' do
      board = [[1, -1, 1, -1, 1, -1], [1, -1, 1, -1, 1, -1], [-1, 1, -1, 1, -1, 1],
               [1, -1, 1, -1, 1, -1], [1, -1, 1, -1, 1, -1], [-1, 1, -1, 1, -1, 1],
               [-1, 1, -1, 0, -1, 1]]
      game.instance_variable_set(:@board, board)
      expect(game).not_to receive(:puts)
      result = game.game_end?
      expect(result).to eq(false)
    end
  end
end
