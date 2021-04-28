Class {
	#name : #Tests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
Tests >> should: block raise: kindOfError withMessage: errorMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : #tests }
Tests >> test000_CreateABoard [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	| myBoard myDie laQueHablaRaro myPlayers |
	
	laQueHablaRaro:= Player withName: 'laQueHablaRaro'.
	self assert: (laQueHablaRaro location) equals:0.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
	
	myPlayers:= (OrderedCollection with: laQueHablaRaro).
	
	myBoard:= Board withSize:10 andPlayers: myPlayers andDie: myDie.
	
	self assert: (myBoard sizeOfBoard) equals: 10.

	self assert: (myBoard players) equals: myPlayers.
	
	self assert: (myBoard die) equals: myDie.
	
]

{ #category : #tests }
Tests >> test001_invalidBoardValuesRaiseError [
	"a dummy test comment"

	"un dia en un cementerio de pizzas habian 2 pizzas"

	| myBoard myDie laQueHablaRaro boardWithoutPlayers boardWithoutDie block kindOfError errorMessage block2 block3 |
	
	laQueHablaRaro := Player withName: 'laQueHablaRaro'.
	self assert: laQueHablaRaro location equals: 0.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
		
	block := [ 
		myBoard := Board
		withSize: 0
		andPlayers: (OrderedCollection with: laQueHablaRaro)
		andDie: myDie. 
		].
	kindOfError := Error.
	errorMessage := 'Un tablero no puede tener menos de 1 casilla.'.
	
	self should: block raise: kindOfError withMessage: errorMessage.
	
	block2:= [
		boardWithoutPlayers :=Board
		withSize: 1
		andPlayers: OrderedCollection new
		andDie: myDie.
		].
	
	self should: block2 raise: Error withMessage: 'Un tablero no puede tener menos de 1 jugador.'.
		
	block3:=[boardWithoutDie := Board
		withSize: 20
		andPlayers: (OrderedCollection with: laQueHablaRaro)
		andDie: OrderedCollection new
		].
		
	self should: block3 raise: Error withMessage: 'Un tablero no puede tener menos de 1 dado.'.
]

{ #category : #tests }
Tests >> test002_CreateAPlayer [
	| myPlayer |
	myPlayer := Player withName: 'Push-Pop :)'.
	self assert: (myPlayer location) equals:0.
	self assert: (myPlayer name) equals: 'Push-Pop :)'.
]

{ #category : #tests }
Tests >> test003_CreateAPlayerWithNLocationAndName [
	| myPlayer |
	myPlayer := Player withLocation: 6 andName: 'Pizza Mediana'.
	self assert: (myPlayer location) equals:6.
	self assert: (myPlayer name ) equals: 'Pizza Mediana'.
		
	myPlayer := Player withLocation: 7 andName: 'Pizza Napolitana'.
	self assert: (myPlayer location) equals:7.
	self assert: (myPlayer name ) equals: 'Pizza Napolitana'.
]

{ #category : #tests }
Tests >> test004_CreateADiceWithNSides [
	| myDice block |
	myDice := Dice withSides: 6.
	self assert: (myDice sides) equals:6.
	
	block:= [Dice withSides: 0.].
	self should: block raise: Error withMessage: 'Un dado no puede tener menos de 1 cara(s).'.
]

{ #category : #tests }
Tests >> test006_CreateAGameSinglePlayer [
	
	| myBoard myDie laQueHablaRaro positions |
	
	laQueHablaRaro:= Player withName: 'laQueHablaRaro'.
	self assert: (laQueHablaRaro location) equals:0.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
	
	myBoard:= Board withSize: 5 andPlayers: (OrderedCollection with: laQueHablaRaro) andDie: myDie.
	
	positions:= myBoard play.
	self deny: (laQueHablaRaro location) equals:0.
	self assert: (myBoard isFinished).
	self assert: ((positions at:1) equals: laQueHablaRaro).
	
]

{ #category : #tests }
Tests >> test007_CreateAGameMultiPlayer [
	
	| myBoard myDie napolitana positions margarita testPlayers mozzarella |
	
	napolitana:= Player withLocation: 5 andName: 'napolitana'.
	self assert: (napolitana location) equals:5.
	
	margarita:= Player withLocation: 0 andName: 'margarita'.
	self assert: (margarita location) equals:0.

	mozzarella:= Player withLocation: 1 andName: 'mozzarella'.
	self assert: (mozzarella location) equals:1.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	myDie := OrderedCollection with: (LoadedDice withSides: 6).
	
	myBoard:= Board withSize: 10 andPlayers: testPlayers andDie: myDie.
	
	positions:= myBoard play.
	"self assert: (napolitana location) equals:10.
	self assert: (margarita location) equals:4.
	self assert: (mozzarella location) equals:5."
	self assert: (myBoard isFinished).
	self assert: ((positions at:1) equals: napolitana).
	self assert: ((positions at:2) equals: mozzarella).
	self assert: ((positions at:3) equals: margarita).
	
]
