Goal: Implementing Chess in Go and Kotlin
# To Do
- [ ] check necessary dependencies to run project in intellij idea when pulling from git repo
	- [ ] Jetbrains Runtime 21.0.9 (SDK)

- [x] fix en passant function
- [x] implement knight
- [x] implement queen
- [x] implement king
- [x] implement bishop

- check if all OOP concepts are present:
- [x] Class
- [x] Objects
- [ ] Data Abstraction 
- [x] Encapsulation
- [x] Inheritance
- [x] Polymorphism
- [ ] Dynamic Binding
- [x] Message Passing

# Notes for Presentation
- it's fine to include slides from the lightning round, duplication is allowed

# Goals
- decentralized and modular
	- Chesspieces govern themselves
	- Chessboard is just for queries
	- UI/Graphics is separate from logic
- demonstrate OOP

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

## Technical Loop (UI)
1. Game start
	-> setup board
2. Player chooses ChessPiece
	-> calculate available moves
	-> mark piece selected
	-> notify manager, save piece selected
	-> highlight available moves
	2. Player deselects ChessPiece
		-> mark piece deselected
		-> notify manager, delete piece selected
		-> hide available moves
3. Player select tile to move to
	-> mark piece deselected
		-> pre-calc next moves and save
	-> notify manager
		-> block player input
		-> check if piece takes other piece
		-> capture piece
	-> move piece to target tile
	-> deselect piece
	-> give turn over to other player
	-> unblock player input
<span style="color:rgb(0, 176, 240)">loop 2 and 3</span>

### Addendum: I/O
for go (and the inital base implementation in kotlin) interactions are done via user input and output

overall, the player should be able to use basic "[Square] to [Square]" notation when moving a chess piece. additionally, the player should be 

# Implementation
## Functionalities

Save System?

### struct PieceType
- dictates tile movement

### ParentClass ChessPiece
- PieceType type
- board position
- special action pre<span style="color:rgb(0, 176, 240)">-</span>move
- special action post-move

#### Movement ChessPieces
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

- maybe pre-calculate the piece's moves whenever it is set down onto the board
- when player moves piece, check pre-calculated moves with input and execute if available

### Class GameManager

### Class BoardStateManager
- chess piece configuration
- selected chess piece
	- get valid moves
	- execute chess piece move
- check check +  mate
- check remis
- chess piece value -> determine winner

  #### Board Indices and Algebraic Notation
![[BoardIndices_Algebraic.jpg]]
![[Board.jpg]]
![[Pasted image 20251231234300.png]]
**Note**: indices actually go from top left to right bottom but were flipped in the presentation to have white on the bottom
#### BitBoard
- consists of a 64 bit (equv. to Long in Kotlin) and each bit signifies whether a piece is occupying that space or not
- 12 bitboards are required, one for each piece (6) in each color (2)
- move and attack patterns are done through bit shifting and bit operations to determines if either the field is unoccupied (xor) or occupied (for attack, and)
- bitboards as implemented in the projects go from [left to right (files, a -> h) and bottom to top (ranks, 1 -> 8)]

- single bits can be read through this ([Link](https://stackoverflow.com/questions/64535067/kotlin-retrieve-bit-position-from-byte-and-convert-it-as-int)): 
	fun getBit(b: Byte, bitNumber: Int): Boolean {
    val shift: Int = 8 - bitNumber
    val bitMask = (1 shl shift).toByte()
    val masked = (b and bitMask)
    return masked.toInt() != 0
    }
    - [x] check if function needs to be modified for Long 

> bitwise operation is only in range 0..31!! -> shift twice if operation out of range (will not throw warning or error)

 - bitboard maybe not viable since it is too complicated but takeaway:
	- magic board: does bitoperations on bitboard to find difference and thus attack pattern/ move pattern
	- move patterns are predetermined and board is one-dimensional array (since it is a 64 bit)
### Class BoardRenderer
Responsibility: render the board according to the current game state
- visual of board
- toggle highlight depending on list

### Class InputHandler
- receive player input (board square coords)
- render board
	- chess pieces
	- board tiles
	- highlight squares
#### Unicode
- 1 -> 8 is 49 to 56
- a -> h is 97 to 104

### Player Feedback
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

## Domain/ Responsibility
### InputHandler
- receive and validate player input (algebraic notation)
- send out move in algebraic notation
### BoardStateManager
- save and answer queries of current board configuration
### GameManager
- perpetuate game loop
- communication center between 

### TestCases
- [x] Input
- [ ] test every chess piece
	- [ ] bishop
	- [ ] king
	- [ ] knight
	- [ ] pawn
	- [x] queen
	- [ ] rook
- [x] board rendering
## Error Handling
### Input Handling: Move Check
For a move input to be valid, the following must be true:
- input is longer than 4 characters
- input is in standard notation
- selected chess piece can move where the input dictates

## Notes Kotlin
- printing bits as actual bits works as follows: println(a.toString(2)) -> 2 is radix that determines base
![[Pasted image 20251229154221.png]]
- it is stupid that the autogenerated  getters and setters are named like this: get[VarName] so that when you create a function with the same name, it throws an error
- additionally, renaming the function with the same name as the getter renames all instances of that variable (wtf)
- except for that, renaming is very easy and works very reliably
- for loop is very versatile and checks via ranges are easy to read
- silent fail on bitshift over 32 bits is stupid

## Notes Golang
- naming variables the same as packages leads to wrong code interpretation
- naming parameters the same as keywords leads to wrong code interpretation
- renaming is not as easy and as error free as it is in kotlin, often renaming packages by appending a '2' even if the previous package doesnt exist anymore
- polymorphism through interface but can only do it with one interface, so if you need a different structs that implement multiple, then you cant do it with that
- hate cyclical dependencies
- cannot implement en passant and rochade due to cyclical dependencies

## Old Code
//*fun getBitViaMask(b: ULong, bitIndex: Int): Boolean {  
//shifts bitmask max 31 left    val shift: Int = 63 - bitIndex    var bitMask: ULong = (1 shl shift.coerceIn(0..31)).toULong()  
//if shift is > 31, then it shifts the remaining indices left    if(shift > 31){        val secondShift: Int = shift - 31        bitMask = (bitMask shl secondShift).toULong()    }    //masks the two    var masked = (b and bitMask)    //and then shifts the bit being looked at right, so that it is least significant bit    masked = masked shr shift    return masked.toInt() != 0}

//        val boardState = boardStateManager.getBoardState()  
//        val enPassantIndexLeft = if(posIndex%8 != 0) posIndex - 1 else -1  
//        val enPassantIndexRight = if(posIndex%7 != 0) posIndex + 1 else -1  
//  
//        var enPassant: ULong = empty  
//        if(enPassantIndexLeft != -1 && getBit(boardState, enPassantIndexLeft)) {  
//            enPassant = setBit(bitIndex = enPassantIndexLeft)  
//        }  
//        if(enPassantIndexRight != -1 && getBit(boardState, enPassantIndexRight)) {  
//            enPassant = enPassant xor setBit(bitIndex = enPassantIndexRight)  
//        }  
//        return enPassant

