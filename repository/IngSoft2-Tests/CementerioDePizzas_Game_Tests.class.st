Class {
	#name : #'CementerioDePizzas_Game_Tests',
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CementerioDePizzas_Game_Tests >> should: block raise: kindOfError withMessage: errorMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test000_CreateABoard [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	| myBoard myDie laQueHablaRaro myPlayers |
	
	laQueHablaRaro:= Player withName: 'laQueHablaRaro'.
	self assert: (laQueHablaRaro location) equals:0.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
	
	myPlayers:= (OrderedCollection with: laQueHablaRaro).
	
	myBoard:= Game withSize:10 andPlayers: myPlayers andDie: myDie.
	
	self assert: (myBoard sizeOfBoard) equals: 10.

	self assert: (myBoard players) equals: myPlayers.
	
	self assert: (myBoard die) equals: myDie.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test001_invalidBoardValuesRaiseError [
	"a dummy test comment"

	"un dia en un cementerio de pizzas habian 2 pizzas"

	| myBoard myDie laQueHablaRaro boardWithoutPlayers boardWithoutDie block kindOfError errorMessage block2 block3 |
	
	laQueHablaRaro := Player withName: 'laQueHablaRaro'.
	self assert: laQueHablaRaro location equals: 0.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
		
	block := [ 
		myBoard := Game
		withSize: 0
		andPlayers: (OrderedCollection with: laQueHablaRaro)
		andDie: myDie. 
		].
	kindOfError := Error.
	errorMessage := 'Un tablero no puede tener menos de 1 casilla.'.
	
	self should: block raise: kindOfError withMessage: errorMessage.
	
	block2:= [
		boardWithoutPlayers :=Game
		withSize: 1
		andPlayers: OrderedCollection new
		andDie: myDie.
		].
	
	self should: block2 raise: Error withMessage: 'Un tablero no puede tener menos de 1 jugador.'.
		
	block3:=[boardWithoutDie := Game
		withSize: 20
		andPlayers: (OrderedCollection with: laQueHablaRaro)
		andDie: OrderedCollection new
		].
		
	self should: block3 raise: Error withMessage: 'Un tablero no puede tener menos de 1 dado.'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test002_CreateAPlayer [
	| myPlayer block |
	myPlayer := Player withName: 'Push-Pop :)'.
	self assert: (myPlayer location) equals:0.
	self assert: (myPlayer name) equals: 'Push-Pop :)'.
	
	block:= [Player withName: ''.].
	self should: block raise: Error withMessage: 'Todo jugador debe tener un nombre.'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test004_CreateADiceWithNSides [
	| myDice block |
	myDice := Dice withSides: 6.
	self assert: (myDice sides) equals:6.
	
	block:= [Dice withSides: 0.].
	self should: block raise: Error withMessage: 'Un dado no puede tener menos de 1 cara(s).'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test006_CreateAGameSinglePlayer [
	
	| myBoard myDie laQueHablaRaro positions |
	
	laQueHablaRaro:= Player withName: 'laQueHablaRaro'.
	self assert: (laQueHablaRaro location) equals:0.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
	
	myBoard:= Game withSize: 5 andPlayers: (OrderedCollection with: laQueHablaRaro) andDie: myDie.
	
	positions:= myBoard play.
	self deny: (laQueHablaRaro location) equals:0.
	self assert: (myBoard isFinished).
	self assert: ((positions at:1) equals: laQueHablaRaro).
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test007_CreateAGameMultiPlayer [
	
	| myBoard myDie napolitana positions margarita testPlayers mozzarella sizeOfBoard |
	
	napolitana:= Player withName: 'napolitana'.	
	margarita:= Player withName: 'margarita'.
	mozzarella:= Player withName: 'mozzarella'.
	
	sizeOfBoard:=10.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	myDie := OrderedCollection with: (LoadedDice withSides: 6).
	
	myBoard:= Game withSize: sizeOfBoard andPlayers: testPlayers andDie: myDie.
	
	positions:= myBoard play.
	
	self assert: (napolitana location) equals: sizeOfBoard.
	self assert: (margarita location) equals:6.
	self assert: (mozzarella location) equals:6.
	self assert: (myBoard isFinished).
	self assert: ((positions at:1) equals: napolitana).
	self assert: ((positions at:2) equals: mozzarella).
	self assert: ((positions at:3) equals: margarita).
	
]
