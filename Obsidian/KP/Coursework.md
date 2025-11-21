Goal: Implementing Chess in Go and Kotlin
# Chess
## Implementation
### Functionality
Parent ChessPiece
- piece type -> movement rules
- board position
- 

Movement ChessPieces (RuleBook)
- Pawn: moves foward one
	- move two on first move
	- take chess piece on diagonal
	- Schlagen en Passant
- Bishop: moves diagonally
- Knight: moves in L shape
- Rook: moves in straight line
	- Rochade: switch position with unmoved King
- Queen: moves in any direction
- King: moves in any direction one tile
	-  Rochade: switch position with unmoved Rook

BoardManager
- chess piece configuration
- get valid moves
- execute move
- check check +  mate
- check remis
- chess piece value -> determine winner

GUI
- chess board
- chess pieces
	- valid moves

### User Interface/ Input
- do simple command line I/O?
	- input like this: "E2 to E3"
		- error when not in that format, case-insensitive
	- board visualisation via ASCII art?
- proper UI with buttons
	- when selecting chess piece show valid moves (toggleable?)
