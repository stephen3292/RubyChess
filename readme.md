#Welcome to Chess!

* This is a console based chess game written in Ruby. The game features
four major classes: piece, board, display and game.

![screenshot1]





![screenshot2]





![screenshot3]


## Features and Details
  * Uses parent/child relationships to determine valid moves for each piece  
  * Game recognizes turns as well as check and checkmate
  * If check, player's moves are restricted to bring them out of check
  * Pieces rendered with unicode chess piece codes
  * Uses cursorable for piece and move selection with arrow keys

## Classes

### Game
  * Controls board and display
  * Allows users to select piece and move
  * Switches players after each turn

### Piece
  * Designed to reduce redundant code
  * Base class has all possible deltas, or coordinate shifts, allowed in chess
  * Has three child classes, Pawn, SlidingPiece, and SteppingPiece
  * Child classes inherit appropriate deltas
  * SteppingPiece and SlidingPiece have appropriate chess pieces as children
  * Pawn can move forward two spaces on first move

### Board
  * Populates 8 X 8 matrix with current chess pieces and selections for each
    turn
  * Contains logic for piece and move selection  
  * Warns when piece is in check and announces checkmate

### Display
  * Renders board, pieces, move selection, and piece to be moved

  [screenshot1]: ./images/screenshot1.png
  [screenshot2]: ./images/screenshot2.png
  [screenshot3]: ./images/screenshot3.png
