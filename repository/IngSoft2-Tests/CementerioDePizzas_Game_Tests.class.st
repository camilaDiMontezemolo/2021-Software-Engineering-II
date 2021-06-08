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
	| myDie hawaiana myPlayers  block myBoard |
	
	myDie := OrderedCollection with: (Die withSides: 3).
	
	myPlayers:= (OrderedCollection with: #hawaiana).
	
	block:=[PizzaGame withBoard:myBoard andPlayers: myPlayers andDie: myDie andLaps: 0].
	
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 vuelta.'.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test000_CreateAGameWithOnePlayerAnd10Boxes [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	| myBoard myDie myPlayers myGame |
	
	myDie := OrderedCollection with: (Die withSides: 3).
	
	myPlayers:= (OrderedCollection with: #hawaiana).
	
	myBoard:= Board withSize: 10.
	
	myGame:= PizzaGame withBoard:myBoard andPlayers: myPlayers andDie: myDie andLaps: 1.
	
	self assert: (myBoard sizeOfBoard) equals: 10.

	self assert: (myGame players) = myPlayers.
	
	self assert: (myGame dice) equals: myDie.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test001_aBoardShouldHaveMoreThanCeroBoxes [

	| block kindOfError errorMessage|
	
	
	block := [ Board withSize:0.].
	kindOfError := Error.
	errorMessage := 'Un tablero no puede tener menos de 1 casillero.'.
	
	self should: block raise: kindOfError withMessage: errorMessage.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test001_aBoardShouldHaveMoreThanCeroDie [

	|  myDie block boardWithoutDie |

	
	myDie := OrderedCollection with: (Die withSides: 3).
		
	block:=[boardWithoutDie := PizzaGame
		withBoard: (Board withSize: 20)
		andPlayers: (OrderedCollection with: #hawaiana)
		andDie: OrderedCollection new
		andLaps: 1
		].
		
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 dado.'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test001_aBoardShouldHaveMoreThanCeroPlayers [

	|  myDie block2 boardWithoutPlayers |
	
	myDie := OrderedCollection with: (Die withSides: 3).

	block2:= [
		boardWithoutPlayers :=PizzaGame
		withBoard: (Board withSize: 1)
		andPlayers: OrderedCollection new
		andDie: myDie
		andLaps: 1.
		].
	
	self should: block2 raise: Error withMessage: 'Un juego no puede tener menos de 1 jugador.'.
		
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test004_aDiceShouldHaveAtLeastOneSide [
	| myDice block |
	myDice := Die withSides: 6.
	self assert: (myDice sides) equals:6.
	
	block:= [Die withSides: 0.].
	self should: block raise: Error withMessage: 'Un dado no puede tener menos de 3 cara(s).'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test005_CreateAPosition [
	|myPosition anAbsoluteLocation |
	anAbsoluteLocation := 20.
	myPosition := Position of: #napolitana at: anAbsoluteLocation.
	self assert: (myPosition absoluteLocation) equals:20.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test006_AMoonWalkBoxJumpsAPlayerBoxesBack [
	
	| myBoxes myBoard testPlayers myDie game positions|
	
	myBoxes := OrderedCollection with: NoEffectBox new with: (MoonWalkBox loadedWith: 1) with: NoEffectBox with: NoEffectBox.
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana with: #hawaiana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoard: myBoard andPlayers: testPlayers andDie: myDie andLaps: 1.
	game oneRound.
	positions := game ranking.

	self assert: (myBoard positions at:2)absoluteLocation equals: 1.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test007_CreateAGameMultiPlayer [
	| game myBoard myDie napolitana ranking margarita testPlayers mozzarella myBoxes |
	napolitana := #napolitana.
	margarita := #margarita.
	mozzarella := #mozzarella.
	myBoxes := OrderedCollection
		with: NoEffectBox new
		with: NoEffectBox new
		with: WormHoleBox new
		with: AtomicBombBox new
		with: (MoonWalkBox loadedWith: 1)
		with: SpeedupBox new.
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection
		with: #napolitana
		with: #margarita
		with: #mozzarella.
	myDie := OrderedCollection
		with: (LoadedDice withTosses: #(4 4 4 2 2 2 2 2 2 6 6 6 2 2 2)).
	game := PizzaGame
		withBoard: myBoard
		andPlayers: testPlayers
		andDie: myDie
		andLaps: 1.
	game play.
	ranking := game ranking.
	self assert: game isFinished.
	self assert: game firstPlace player identicalTo: napolitana.
	self assert: (ranking at: 1) player identicalTo: napolitana.
	self assert: (ranking at: 2) player identicalTo: margarita.
	self assert: (ranking at: 3) player identicalTo: mozzarella
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test008_ANoEffectBoxHasNoEffects [
	
		| myBoxes myBoard testPlayers myDie game positions |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new.
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoard: myBoard andPlayers: testPlayers andDie: myDie andLaps: 1.
	game oneRound.
	positions := game ranking.

	self assert: (positions at:1)absoluteLocation equals: 2.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test009_ASpeedupBoxJumpsYouFourBoxes [
	
	| game myBoard myDie ranking testPlayers myBoxes |
	myBoxes := OrderedCollection
		with: SpeedupBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new.
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection
		with: #napolitana.
	myDie := OrderedCollection
		with: (LoadedDice withTosses: #(1)).
	game := PizzaGame
		withBoard: myBoard
		andPlayers: testPlayers
		andDie: myDie
		andLaps: 1.
	game oneRound.
	ranking := game ranking.
	self assert: (ranking at: 1) absoluteLocation equals: 5.

]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test010_AnAtomicBombBoxSendsEveryoneBackToZero [
	
	| game myBoard myDie ranking testPlayers myBoxes |
	myBoxes := OrderedCollection
		with: NoEffectBox new
		with: NoEffectBox new
		with: AtomicBombBox new
		with: NoEffectBox new
		with: NoEffectBox new.
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection
		with: #napolitana
		with: #margarita
		with: #hawaiana.
	myDie := OrderedCollection
		with: (LoadedDice withTosses: #(4)).
	game := PizzaGame
		withBoard: myBoard
		andPlayers: testPlayers
		andDie: myDie
		andLaps: 2.
	game oneRound.
	game oneRound.
	ranking := game ranking.
	self assert: (ranking first) absoluteLocation equals: 6.
	self assert: (ranking second) absoluteLocation equals: 4.
	self assert: (ranking third) absoluteLocation equals: 4.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test011_CreateAGameSinglePlayer [
	
	| myBoard game myDie positions napolitana |
	
	napolitana:= #napolitana.
	
	myDie := OrderedCollection with: (Die withSides: 5).
	
	myBoard := Board withSize: 5.
	
	game:= PizzaGame withBoard: myBoard andPlayers: (OrderedCollection with: napolitana) andDie: myDie andLaps: 1.
	
	game play.
	positions := game ranking.
	self assert: (game isFinished).
	self assert: (positions at:1) player identicalTo: napolitana.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test012_CreateARandomMultiPlayerGame [
	
	| game myBoard myDie napolitana margarita testPlayers mozzarella |
	
	napolitana:= #napolitana.	
	margarita:= #margarita.
	mozzarella:= #mozzarella.
	
	
	myBoard := Board withSize: 40.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	myDie := OrderedCollection with: (Die withSides: 5) with: (Die withSides: 4).
	
	game:= PizzaGame withBoard: myBoard andPlayers: testPlayers andDie: myDie andLaps: 1.
	
	game play.
	
	self assert: (game isFinished).
	
]
