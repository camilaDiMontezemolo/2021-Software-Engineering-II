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
CementerioDePizzas_Game_Tests >> test000_AGameShouldHaveAtLeastOneLap [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	| myBoard myDie hawaiana myPlayers myGame block |
	
	hawaiana := Player withName: 'hawaiana'.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
	
	myPlayers:= (OrderedCollection with: hawaiana).
	
	block:=[Game withBoard:myBoard andPlayers: myPlayers andDie: myDie andLaps: 0].
	
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 vuelta.'.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test000_CreateAGameWithOnePlayerAnd10Boxes [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	| myBoard myDie hawaiana myPlayers myGame |
	
	hawaiana := Player withName: 'hawaiana'.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
	
	myPlayers:= (OrderedCollection with: hawaiana).
	
	myBoard:= Board withSize: 10.
	
	myGame:= Game withBoard:myBoard andPlayers: myPlayers andDie: myDie andLaps: 1.
	
	self assert: (myBoard sizeOfBoard) equals: 10.

	self assert: (myGame players) equals: myPlayers.
	
	self assert: (myGame die) equals: myDie.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test001_aBoardShouldHaveMoreThanCeroPlayeresAndDie [

	|  myDie laQueHablaRaro block2 block3 boardWithoutPlayers boardWithoutDie |

	laQueHablaRaro := Player withName: 'laQueHablaRaro'.
	
	myDie := OrderedCollection with: (Dice withSides: 1).

	block2:= [
		boardWithoutPlayers :=Game
		withBoard: (Board withSize: 1)
		andPlayers: OrderedCollection new
		andDie: myDie
		andLaps: 1.
		].
	
	self should: block2 raise: Error withMessage: 'Un juego no puede tener menos de 1 jugador.'.
		
	block3:=[boardWithoutDie := Game
		withBoard: (Board withSize: 20)
		andPlayers: (OrderedCollection with: laQueHablaRaro)
		andDie: OrderedCollection new
		andLaps: 1
		].
		
	self should: block3 raise: Error withMessage: 'Un juego no puede tener menos de 1 dado.'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test001_aBoardShouldHaveMoreThanCeroPlayeresBoxesAndDie [

	|  myDie block kindOfError errorMessage hawaiana block2 block3 boardWithoutPlayers 	boardWithoutDie |
	
	hawaiana := Player withName: 'hawaiana'.
	
	myDie := OrderedCollection with: (Dice withSides: 1).
	block := [ 
		Board withSize:0. 
		].
	kindOfError := Error.
	errorMessage := 'Un tablero no puede tener menos de 1 casillero.'.
	
	self should: block raise: kindOfError withMessage: errorMessage.

	block2:= [
		boardWithoutPlayers :=Game
		withBoard: (Board withSize: 1)
		andPlayers: OrderedCollection new
		andDie: myDie
		andLaps: 1.
		].
	
	self should: block2 raise: Error withMessage: 'Un juego no puede tener menos de 1 jugador.'.
		
	block3:=[boardWithoutDie := Game
		withBoard: (Board withSize: 20)
		andPlayers: (OrderedCollection with: hawaiana)
		andDie: OrderedCollection new
		andLaps: 1
		].
		
	self should: block3 raise: Error withMessage: 'Un juego no puede tener menos de 1 dado.'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test002_aPlayerMustHaveAName [
	| myPlayer block |
	myPlayer := Player withName: 'Push-Pop :)'.
	
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
CementerioDePizzas_Game_Tests >> test005_CreateABoardWithPositionsAndReplaceOneOfThem [
	| myBoard napolitana margarita testPlayers mozzarella hawaiana positions|
	
	napolitana:= Player withName: 'napolitana'.	
	margarita:= Player withName: 'margarita'.
	mozzarella:= Player withName: 'mozzarella'.
	hawaiana := Player withName: 'hawaiana'.
	
	myBoard := Board withSize: 40.
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.

	myBoard createPositionsFor: testPlayers.
	positions:=myBoard positions.
	myBoard replacePosition: (positions at: 1) with: (Position of: hawaiana at: 0 whithNumberOfLaps: 0 location: 0).
	
	self assert: ((myBoard positions) at: 1) player equals: hawaiana.
	self assert: ((myBoard positions) at: 2) player equals: margarita.
	
	




]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test005_CreateAPosition [
	|myPosition aPlayer anAbsoluteLocation laps |
	aPlayer:= Player withName: 'Alejandra'.
	anAbsoluteLocation := 20.
	laps :=6.
	myPosition := Position of: aPlayer at: anAbsoluteLocation whithNumberOfLaps: laps.
	self assert: (myPosition location) equals: 2.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test006_AMoonWalkBoxJumpsAPlayerBoxesBack [
	
	| game myBoard myDie positions testPlayers mozzarella myBoxes |
	
	mozzarella:= Player withName: 'mozzarella'.
	myBoxes := OrderedCollection with: (LoadedMoonWalkBox new) with: (LoadedMoonWalkBox new) with: (BoxNoEffect new) with: (BoxNoEffect new) with: (LoadedMoonWalkBox new) with: (BoxNoEffect new).
	myBoard := Board withBoxes: myBoxes.

	testPlayers:= OrderedCollection with: mozzarella.
	
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1 3 4 5 6)).
	
	
	game:= Game withBoard: myBoard andPlayers: testPlayers andDie: myDie andLaps: 1.
	game play.
	positions := game ranking.
	
	self assert: (game isFinished).
	self assert: (((positions at:1) player) equals: mozzarella).
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test007_CreateAGameMultiPlayer [
	
	| game myBoard myDie napolitana ranking margarita testPlayers mozzarella myBoxes |
	
	napolitana:= Player withName: 'napolitana'.	
	margarita:= Player withName: 'margarita'.
	mozzarella:= Player withName: 'mozzarella'.
	
	myBoxes := OrderedCollection with: (BoxNoEffect new) with: (BoxNoEffect new) with: (BoxWormHole new) with: (BoxAtomicBomb new) with: (LoadedMoonWalkBox new) with: (BoxSpeedup new).
	
	myBoard := Board withBoxes: myBoxes.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	myDie := OrderedCollection with: (LoadedDice withTosses: #(4 4 4 2 2 2 2 2 2 6 6 6 2 2 2)).
	
	game:= Game withBoard: myBoard andPlayers: testPlayers andDie: myDie andLaps: 1.
	
	game play.
	ranking := game ranking.
	
	self assert: (game isFinished).
	self assert: ((ranking at:1) player equals: napolitana).
	self assert: ((ranking at:2) player equals: mozzarella).
	self assert: ((ranking at:3) player equals: margarita).
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test008_ANoEffectBoxHasNoEffects [
	
	| game myBoard myDie positions testPlayers mozzarella myBoxes myPositions |
	
	mozzarella:= Player withName: 'mozzarella'.
	myBoxes := OrderedCollection with: (BoxNoEffect new) with: (BoxNoEffect  new) with: (BoxNoEffect new) with: (BoxNoEffect new) with: (BoxNoEffect new).
	myBoard := Board withBoxes: myBoxes.

	testPlayers:= OrderedCollection with: mozzarella.
	
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	
	game:= Game withBoard: myBoard andPlayers: testPlayers andDie: myDie andLaps: 1.
	
	game play.
	positions := game ranking.
	
	self assert: (positions anySatisfy: [ :position | (position location) = (myBoard sizeOfBoard)]).
	self assert: (game isFinished).
	self assert: ((positions at:1) player equals: mozzarella).
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test009_ASpeedupBoxJumpsYouFourBoxesForward [
	
	| game myBoard myDie napolitana positions testPlayers mozzarella myBoxes |
	
	napolitana:= Player withName: 'napolitana'.	
	mozzarella:= Player withName: 'mozzarella'.
	
	myBoxes := OrderedCollection with: (BoxSpeedup  new) with: (BoxSpeedup new) with: (BoxSpeedup new) with: (BoxSpeedup new) with: (BoxSpeedup new) with: (BoxSpeedup new).
	
	myBoard := Board withBoxes: myBoxes.
	
	testPlayers:= OrderedCollection with: napolitana with: mozzarella.
	
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	
	game:= Game withBoard: myBoard andPlayers: testPlayers andDie: myDie andLaps: 1.
	
	game play.
	positions := game ranking.
	
	"self assert: (testPlayers anySatisfy: [ :player | (player location) = (myBoard sizeOfBoard)])."
	self assert: (game isFinished).
	self assert: ((positions at:1) player equals: napolitana).
	self assert: ((positions at:2) player equals: mozzarella).
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test010_AnAtomicBombBoxSendsEveryoneBackTo1 [
	
	| game myBoard myDie positions testPlayers mozzarella myBoxes |
	
	mozzarella:= Player withName: 'mozzarella'.
	myBoxes := OrderedCollection with: (BoxNoEffect new) with: (BoxAtomicBomb new) with: (BoxNoEffect new) with: (BoxNoEffect new) with: (BoxNoEffect new).
	myBoard := Board withBoxes: myBoxes.

	testPlayers:= OrderedCollection with: mozzarella.
	
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2 3 3 4 5 6)).
	
	game:= Game withBoard: myBoard andPlayers: testPlayers andDie: myDie andLaps: 1.
	
	game play.
	positions := game ranking.
	
	self assert: (positions anySatisfy: [ :position | (position location) = (myBoard sizeOfBoard)]).
	self assert: (game isFinished).
	self assert: ((positions at:1) player equals: mozzarella).
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test011_CreateAGameSinglePlayer [
	
	| myBoard game myDie laQueHablaRaro positions |
	
	laQueHablaRaro:= Player withName: 'laQueHablaRaro'.
	
	myDie := OrderedCollection with: (Dice withSides: 5).
	
	myBoard := Board withSize: 5.
	
	game:= Game withBoard: myBoard andPlayers: (OrderedCollection with: laQueHablaRaro) andDie: myDie andLaps: 1.
	
	game play.
	positions := game ranking.
	self assert: (game isFinished).
	self assert: ((positions at:1) player equals: laQueHablaRaro).
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test012_CreateARandomMultiPlayerGame [
	
	| game myBoard myDie napolitana margarita testPlayers mozzarella |
	
	napolitana:= Player withName: 'napolitana'.	
	margarita:= Player withName: 'margarita'.
	mozzarella:= Player withName: 'mozzarella'.
	
	
	myBoard := Board withSize: 40.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	myDie := OrderedCollection with: (Dice withSides: 5) with: (Dice withSides: 4).
	
	game:= Game withBoard: myBoard andPlayers: testPlayers andDie: myDie andLaps: 1.
	
	game play.
	
	self assert: (game isFinished).
	
]
