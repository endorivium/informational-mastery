Goal: Implementing Chess in Go and Kotlin
# Game Loop
## Kotlin

The player opens the program and is met with a screen with a logo and three buttons that ask them whether they - as player 1 - would like to start as black or white or quit out of the program.

The program then opens the chess board with all the chess pieces set up. Hovering over any given piece *displays all its current possible moves* that the player can take.
LMB a piece selects it and lets the player move it to any of the marked tiles. RMB lets the player deselect the chess piece.
As soon as the piece has been selected and moved, the turn then is given over to the other player. From then on, the previously described loop is repeated.

When one player has accomplished a checkmate, the game ends and takes no more input. Each player score is accumulated and displayed side by side with one of them crowned as the winner.
The player can then either player again - which opens a small window asking if they would like to play as black or white - or close the program.

*Save System: the player can save the game at any point during the game.*
*The highlighting feature can be toggled on/off  via a button*

## Go
The program opens asks the player if they would like to play as black (0) or white (1) or close the program (2).

The program then renders the gameboard into the console window and asks the player for their first move. The move is input via the pattern "(StartSquare) to (TargetSquare)" in the console line. Depending on the input, the move is either executed or an error message is displayed:
1) move was not valid
	1) square does not contain a chess piece
	2) chess piece cannot move in that way
2) move command was in the wrong format
If the move was successfully executed, then the turn is given over to the other player. From then on, the game loops as previously described.

When a player accomplishes a checkmate, the player scores are calculated and displayed and a winner is crowned.

# Implementation
## Functionality

Save System?

Parent ChessPiece
- PieceType type
- board position
- special action pre<span style="color:rgb(0, 176, 240)">-</span>move
- special action post-move

struct PieceType
- tile movement

Movement ChessPieces (RuleBook)
- Pawn: moves foward one
	- move two on first move
	- take chess piece on diagonal
	- Schlagen en Passant
	- transform when reaching end of board
- Bishop: moves diagonally
- Knight: moves in L shape
	- can jump over other chess pieces
- Rook: moves in straight line
	- Rochade: switch position with unmoved King
- Queen: moves in any direction
- King: moves in any direction one tile
	-  Rochade: switch position with unmoved Rook

BoardManager
- chess piece configuration
- selected chess piece
	- get valid moves
	- execute chess piece move
- check check +  mate
- check remis
- chess piece value -> determine winner

GUI
- start game as black/white (might be unnecessary since it is local multiplayer)
- chess board
	- notify check + mate
	- display score and winner
- chess pieces
	- valid moves

## User Interface/ Input

- GO: do simple command line I/O?
	- input like this: "E2 to E3"
		- error when not in that format, case-insensitive
	- board visualisation via ASCII art?
- KOTLIN: proper UI with buttons
	- select: LMB, deselect: RMB
	- when selecting/hovering chess piece show valid moves (toggleable?)
	- show check + mate

