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
	| myDie myPlayers  block myBoard |
	
	myDie := OrderedCollection with: (Dice withSides: 3).
	
	myPlayers:= (OrderedCollection with: #hawaiana).
	
	block:=[PizzaGame withBoard:myBoard andPlayers: myPlayers andDie: myDie andLaps: 0].
	
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 vuelta.'.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test000_CreateAGameWithOnePlayerAnd10Boxes [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	| myBoard myDie myPlayers myGame myBoxes|
	
	myDie := OrderedCollection with: (Dice withSides: 3).
	
	myPlayers:= (OrderedCollection with: #hawaiana).
	
	myBoxes := OrderedCollection new.
	myBoxes:= BoxGenerator give: 10.
	myBoard:= Board withBoxes: myBoxes.
	
	myGame:= PizzaGame withBoard:myBoard andPlayers: myPlayers andDie: myDie andLaps: 1.
	
	self assert: (myBoard sizeOfBoard) equals: 10.
	
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

	|  myDie block boardWithoutDie someBoxes myBoard|
	myDie := OrderedCollection with: (Dice withSides: 3).
	someBoxes := OrderedCollection new.
	someBoxes:= BoxGenerator give: 20.
	myBoard:= Board withBoxes: someBoxes.
	block:=[boardWithoutDie := PizzaGame
		withBoard: myBoard
		andPlayers: (OrderedCollection with: #hawaiana)
		andDie: OrderedCollection new
		andLaps: 1
		].
		
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 dado.'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test001_aBoardShouldHaveMoreThanCeroPlayers [

	|  myDie block2 boardWithoutPlayers myBoxes|
	
	myDie := OrderedCollection with: (Dice withSides: 3).
	myBoxes := OrderedCollection with: (BoxGenerator give: 10).

	block2:= [
		boardWithoutPlayers :=PizzaGame
		withBoard: (Board withBoxes: myBoxes)
		andPlayers: OrderedCollection new
		andDie: myDie
		andLaps: 1.
		].
	
	self should: block2 raise: Error withMessage: 'Un juego no puede tener menos de 1 jugador.'.
		
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test004_aDiceShouldHaveAtLeastOneSide [
	| myDice block |
	myDice := Dice withSides: 6.
	self assert: (myDice sides) equals:6.
	
	block:= [Dice withSides: 0.].
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
	
	| myBoard game myDie positions napolitana myBoxes|
	
	napolitana:= #napolitana.
	
	myDie := OrderedCollection with: (Dice withSides: 5).
	myBoxes := OrderedCollection new.
	myBoxes:= BoxGenerator give: 5.
	myBoard:= Board withBoxes: myBoxes.
	
	game:= PizzaGame withBoard: myBoard andPlayers: (OrderedCollection with: napolitana) andDie: myDie andLaps: 1.
	
	game play.
	positions := game ranking.
	self assert: (game isFinished).
	self assert: (positions at:1) player identicalTo: napolitana.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test012_CreateARandomMultiPlayerGame [
	
	| game myBoard myDie napolitana margarita testPlayers mozzarella myBoxes|
	
	napolitana:= #napolitana.	
	margarita:= #margarita.
	mozzarella:= #mozzarella.
	
	myBoxes := OrderedCollection new.
	myBoxes:= BoxGenerator give: 40.
	myBoard:= Board withBoxes: myBoxes.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	myDie := OrderedCollection with: (Dice withSides: 5) with: (Dice withSides: 4).
	
	game:= PizzaGame withBoard: myBoard andPlayers: testPlayers andDie: myDie andLaps: 1.
	
	game play.
	
	self assert: (game isFinished).
	
]
