import 'dart:io';

void main() {
  print('🎮 Welcome to Tic-Tac-Toe Game! 🎲');
  print('Instructions:');
  print('- The board is a 3x3 grid, numbered 1 to 9 as follows:');
  print('  1 | 2 | 3');
  print('  ---------');
  print('  4 | 5 | 6');
  print('  ---------');
  print('  7 | 8 | 9');
  print('- Player X goes first, followed by Player O.');
  print('- Enter the number (1-9) corresponding to an empty cell.');
  print('- The first player to align 3 marks (row, column, or diagonal) wins.');
  print('- If the board is full without a winner, it\'s a draw.');

  while (true) {
    List<List<String>> board = List.generate(3, (_) => List.filled(3, ' '));

    print('Choose the starting player (X or O):');
    String currentPlayer = stdin.readLineSync()!.toUpperCase();

    while (currentPlayer != 'X' && currentPlayer != 'O') {
      print('Invalid choice. Please choose X or O:');
      currentPlayer = stdin.readLineSync()!.toUpperCase();
    }

    while (true) {
      clearConsole();
      printBoard(board);
      print("Player $currentPlayer's turn. Enter a move (1-9):");

      String? input = stdin.readLineSync();
      int? move = int.tryParse(input ?? '');

      if (move == null || move < 1 || move > 9) {
        print('🚫 Invalid input. Please enter a number between 1 and 9.');
        continue;
      }

      int row = (move - 1) ~/ 3;
      int col = (move - 1) % 3;

      if (board[row][col] != ' ') {
        print('🚫 Cell already taken. Try again.');
        continue;
      }

      board[row][col] = currentPlayer;

      if (checkWinner(board, currentPlayer)) {
        clearConsole();
        printBoard(board);
        print('🎉 Player $currentPlayer wins! 🎉');
        break;
      }

      if (board.expand((e) => e).every((e) => e != ' ')) {
        clearConsole();
        printBoard(board);
        print('🤝 It\'s a draw!');
        break;
      }

      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    }

    print('Would you like to play again? (yes/no):');
    String? replay = stdin.readLineSync()?.toLowerCase();
    if (replay != 'yes') {
      print('🎮 Thanks for playing Tic-Tac-Toe! Goodbye! 👋');
      break;
    }
  }
}

void clearConsole() => print('\x1B[2J\x1B[0;0H');

void printBoard(List<List<String>> board) {
  print('\n  1 | 2 | 3');
  print(' ---+---+---');
  for (int i = 0; i < 3; i++) {
    print('${i * 3 + 1} | ${board[i][0]} | ${board[i][1]} | ${board[i][2]}');
    if (i < 2) print(' ---+---+---');
  }
  print('');
}

bool checkWinner(List<List<String>> board, String player) {
  for (int i = 0; i < 3; i++) {
    if (board[i].every((cell) => cell == player)) return true;
    if (board.every((row) => row[i] == player)) return true;
  }

  if (board[0][0] == player && board[1][1] == player && board[2][2] == player) return true;
  if (board[0][2] == player && board[1][1] == player && board[2][0] == player) return true;

  return false;
}
