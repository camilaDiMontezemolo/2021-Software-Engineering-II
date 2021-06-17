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
CementerioDePizzas_Game_Tests >> testABoardShouldHaveMoreThanCeroDie [

	|  block someBoxes myBoard testPlayers cards|

	someBoxes:= BoxGenerator give: 20.
	myBoard:= Board withBoxes: someBoxes.
	testPlayers:=(OrderedCollection with: #hawaiana).
	cards := CardGenerator forPlayer: testPlayers give: 2.
	block:=[PizzaGame
		withBoard: myBoard
		players: testPlayers
		dice: OrderedCollection new
		laps: 1
		andCards: cards.
		].
		
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 dado.'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testABoardShouldHaveMoreThanCeroPlayers [

	|  myDie block myBoxes cards|
	
	myDie := OrderedCollection with: (Dice withSides: 3).
	myBoxes := OrderedCollection with: (BoxGenerator give: 10).
	cards := CardGenerator forPlayer: (OrderedCollection with: #Margarita) give: 2.

	block:= [ PizzaGame
		withBoard: (Board withBoxes: myBoxes)
		players: OrderedCollection new
		dice: myDie
		laps: 1
		andCards: cards.
		].
	
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 jugador.'.
		
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testACardBoxGivesCards [
	| game myBoard myDie ranking testPlayers myBoxes cards cardBox |
	cardBox := CardBoxLoaded
		loadedWith: (OrderedCollection with: (SpeedUpCard of: #napolitana on: '')).
		
	myBoxes := OrderedCollection
		with: cardBox
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new.
		
	myBoard := Board withBoxes: myBoxes.
	
	testPlayers := OrderedCollection with: #napolitana.
	
	cards := OrderedCollection
		with: (RepeatCard of: #napolitana on: '')
		with: (AccelerationCard of: #napolitana on: '').
		
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	
	game := PizzaGame
		withBoard: myBoard
		players: testPlayers
		dice: myDie
		laps: 1
		andCards: cards.
		
	game oneRound.
	game applyCard: (cards at: 3) to: #napolitana.
	game oneRound.
	ranking := game ranking.
	
	self assert: (ranking at: 1) absoluteLocation equals: 3
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testACardCanNotBeUsedOutsideYourTurn [
	
	| myBoxes myBoard testPlayers myDie game cards block|
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (AccelerationCard of:#napolitana on:'').
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with:#margarita with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game oneRound.
	block:=[game applyCard:(cards at:1) to: testPlayers.].
	self should: block raise: Error withMessage: 'Un jugador no puede tirar una carta fuera de su turno.'
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testACardGeneratorGivesACollectionOfCards [
	
	| testPlayers cards |
	
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	
	cards := CardGenerator forPlayer: testPlayers give: 2.
	
	self assert: (cards size) equals: 4.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testACardGeneratorShouldntBeAbleToGiveCardsToZeroPlayers [
	
	| testPlayers block |
	
	testPlayers := OrderedCollection new.
	block:=[CardGenerator forPlayer: testPlayers give: 2.].
	
	self should: block raise: Error withMessage: 'Un deck no puede tener menos de 1 jugadores.'
	
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testACardGeneratorShouldntBeAbleToGiveZeroCards [
	
	| testPlayers block |
	
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	block:=[CardGenerator forPlayer: testPlayers give: 0.].

	self should: block raise: Error withMessage: 'Un deck no puede tener menos de 1 carta.'
	
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testADiceShouldHaveAtLeastOneSide [
	| myDice block |
	myDice := Dice withSides: 6.
	self assert: (myDice sides) equals:6.
	
	block:= [Dice withSides: 0.].
	self should: block raise: Error withMessage: 'Un dado no puede tener menos de 3 cara(s).'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testAGameShouldHaveAtLeastOneLap [

	| myDie myPlayers  block myBoard cards myBoxes|
	
	myDie := OrderedCollection with: (Dice withSides: 3).
	myBoxes:= BoxGenerator give: 10.
	myBoard:= Board withBoxes: myBoxes.
	myPlayers:= (OrderedCollection with: #hawaiana).
	cards := CardGenerator forPlayer: myPlayers give: 2.
	block:=[PizzaGame withBoard:myBoard players: myPlayers dice: myDie laps: 0 andCards: cards].
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 vuelta.'.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testAMoonWalkBoxJumpsAPlayerBoxesBack [
	
	| myBoxes myBoard testPlayers myDie game cards|
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: (MoonWalkBox loadedWith: 1) 
		with: NoEffectBox with: NoEffectBox.
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana with: #hawaiana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game oneRound.

	self assert: (myBoard positions at:2)absoluteLocation equals: 1.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testANoEffectBoxHasNoEffects [
	
		| myBoxes myBoard testPlayers myDie game positions cards|
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new.
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game oneRound.
	positions := game ranking.

	self assert: (positions at:1)absoluteLocation equals: 2.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testASpeedupBoxJumpsYouFourBoxes [
	
	| game myBoard myDie ranking testPlayers myBoxes cards|
	myBoxes := OrderedCollection
		with: SpeedupBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new.
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game oneRound.
	ranking := game ranking.
	self assert: (ranking at: 1) absoluteLocation equals: 5.

]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testAnAtomicBombBoxSendsEveryoneBackToZero [
	
	| game myBoard myDie ranking testPlayers myBoxes cards|
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
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 2 andCards: cards.
	game oneRound.
	game oneRound.
	ranking := game ranking.
	self assert: (ranking first) absoluteLocation equals: 6.
	self assert: (ranking second) absoluteLocation equals: 4.
	self assert: (ranking third) absoluteLocation equals: 4.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testCreateAGameMultiPlayer [
	| game myBoard myDie napolitana ranking margarita testPlayers mozzarella myBoxes cards|
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
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game play.
	ranking := game ranking.
	self assert: game isFinished.
	self assert: game firstPlace player identicalTo: napolitana.
	self assert: (ranking at: 1) player identicalTo: napolitana.
	self assert: (ranking at: 2) player identicalTo: margarita.
	self assert: (ranking at: 3) player identicalTo: mozzarella
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testCreateAGameSinglePlayer [
	
	| myBoard game myDie positions napolitana myBoxes testPlayers cards|
	
	napolitana:= #napolitana.
	
	myDie := OrderedCollection with: (Dice withSides: 5).
	myBoxes:= BoxGenerator give: 5.
	myBoard:= Board withBoxes: myBoxes.
	testPlayers:= OrderedCollection with: napolitana.
	
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	
	game play.
	positions := game ranking.
	self assert: (game isFinished).
	self assert: (positions at:1) player identicalTo: napolitana.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testCreateAGameWithOnePlayerAnd10Boxes [

	| myBoard myDie myPlayers myBoxes cards|
	
	myDie := OrderedCollection with: (Dice withSides: 3).
	
	myPlayers:= (OrderedCollection with: #hawaiana).
	
	myBoxes:= BoxGenerator give: 10.
	myBoard:= Board withBoxes: myBoxes.
	
	cards := CardGenerator forPlayer: myPlayers give: 2.
	PizzaGame withBoard:myBoard players: myPlayers dice: myDie laps: 1 andCards: cards.
	
	self assert: (myBoard sizeOfBoard) equals: 10.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testCreateAPosition [
	|myPosition anAbsoluteLocation |
	anAbsoluteLocation := 20.
	myPosition := Position of: #napolitana at: anAbsoluteLocation.
	self assert: (myPosition absoluteLocation) equals:20.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testCreateARandomMultiPlayerGame [
	
	| game myBoard myDie napolitana margarita testPlayers mozzarella myBoxes cards|
	
	napolitana:= #napolitana.	
	margarita:= #margarita.
	mozzarella:= #mozzarella.
	
	myBoxes:= BoxGenerator give: 40.
	myBoard:= Board withBoxes: myBoxes.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	myDie := OrderedCollection with: (Dice withSides: 5) with: (Dice withSides: 4).
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game:= PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	
	game play.
	
	self assert: (game isFinished).
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnASpeedupCard [
	
	| myBoxes myBoard testPlayers myDie game cards emptyCard|
	
	emptyCard := EmptyCard new.

	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (CancellationCard of: #napolitana on:emptyCard)
		with: (SpeedUpCard of: #margarita on: '').
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game runOneTurn.
	game applyCard: cards second to: #margarita.
	game applyCard: cards first to: cards second. 
	game runOneTurn.
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	
	self assert: cards size equals: 0.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnAnAccelerationCard [
	
	| myBoxes myBoard testPlayers myDie game cards emptyCard|
	
	emptyCard := EmptyCard new.

	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (CancellationCard of: #napolitana on:emptyCard)
		with: (AccelerationCard of: #margarita on: '').
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game runOneTurn.
	game applyCard: cards second to: testPlayers.
	game applyCard: cards first to: cards second. 
	game runOneTurn.
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	
	self assert: cards size equals: 0.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnAnInactiveCardRaiseError [
	
	| myBoxes myBoard testPlayers myDie game cards emptyCard block |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
	emptyCard := EmptyCard new.
	cards := OrderedCollection
		with: (CancellationCard of: #napolitana on: emptyCard)
		with: (SpeedUpCard of: #margarita on: #'').
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game runOneTurn.
	 
	block:=[game applyCard: cards first to: cards second.].
	self should: block raise: Error withMessage: 'No se puede cancelar una carta inactiva.'

	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnAnInstantCardRaiseAnError [
	
	| myBoxes myBoard testPlayers myDie game cards emptyCard block |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
	emptyCard := EmptyCard new.
	cards := OrderedCollection
		with: (CancellationCard of: #napolitana on: emptyCard)
		with: (CancellationCard of: #margarita on: emptyCard).
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game runOneTurn.
	 
	block:=[game applyCard: cards first to: cards second.].
	self should: block raise: Error withMessage: 'No se puede cancelar una carta instantanea.'

	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnAnOverloadCard [
	
	| myBoxes myBoard testPlayers myDie game cards emptyCard|
	
	emptyCard := EmptyCard new.

	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (CancellationCard of: #napolitana on:emptyCard)
		with: (OverloadCard of: #margarita on: '').
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game runOneTurn.
	game applyCard: cards second to: #margarita.
	game applyCard: cards first to: cards second. 
	game runOneTurn.
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	
	self assert: cards size equals: 0.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseARedoCard [
	
	| myBoxes myBoard testPlayers myDie game cards|

    myBoxes := OrderedCollection 
        with: NoEffectBox new 
        with: NoEffectBox new
        with: NoEffectBox new 
        with: NoEffectBox new.

    cards := OrderedCollection
        with: (SpeedUpCard of: #margarita on:#margarita)
        with: (RedoCard of: #napolitana on: #napolitana).

    myBoard := Board withBoxes: myBoxes.
    testPlayers := OrderedCollection with:#margarita with: #napolitana.
    myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
    game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
    game oneRound.

    self assert: ((game ranking) second) absoluteLocation equals: 3.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseARedoCardOverCancelation [
	
	| myBoxes myBoard testPlayers myDie game cards cardOne cardTwo cardThree cardFour emptyCard |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
	emptyCard := EmptyCard new.	
	cardOne :=SpeedUpCard of: #margarita on:#margarita.
	cardTwo := SpeedUpCard of: #margarita on:#margarita.
	cardThree := CancellationCard of:#napolitana on:emptyCard.
	cardFour := RedoCard of: #napolitana on: ''.
	
	cards := OrderedCollection
		with: cardOne
		with: cardTwo
		with: cardThree
		with: cardFour.
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with:#margarita with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 10 andCards: cards.
	game applyCard: (cardThree) to: (cardOne). 
	game applyCard: (cardFour) to: (cardTwo). 
	game oneRound.
	
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseARepeatCard [
	
	| myBoxes myBoard testPlayers myDie game cards|
	
	myBoxes := OrderedCollection 
		with: SpeedupBox new
		with: NoEffectBox new 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (RepeatCard of: #napolitana on: '').
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with:#margarita with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game runOneTurn.
	game applyCard: cards first to: #napolitana. 
	
	self assert: ((game ranking) first) absoluteLocation equals: 5.
	self assert: ((game ranking) second) absoluteLocation equals: 4.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseARepeatCardWhenNoDieWasRolledYet [
	
	| myBoxes myBoard testPlayers myDie game cards|
	
	myBoxes := OrderedCollection 
		with: SpeedupBox new
		with: NoEffectBox new 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (RepeatCard of: #napolitana on: '').
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with:#margarita with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game applyCard: cards first to: #napolitana. 
	
	self assert: ((game ranking) first) absoluteLocation equals: 0.
	self assert: ((game ranking) second) absoluteLocation equals: 0.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseASpeedUpCard [
	
	| myBoxes myBoard testPlayers myDie game cards rankingOne |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (SpeedUpCard of: #napolitana on: '').
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game applyCard: (cards at:1) to: #napolitana.
	game oneRound.
	rankingOne:= game ranking.
	
	self assert: (rankingOne first) absoluteLocation equals: 3.
	self assert: cards size equals: 1.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseASpeedUpCardOnTwoRounds [
	
	| myBoxes myBoard testPlayers myDie game cards rankingTwo |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (SpeedUpCard of: #napolitana on: '').
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game applyCard: (cards at:1) to: #napolitana.
	game oneRound.
	game oneRound.
	rankingTwo:= game ranking.
	
	self assert: (rankingTwo first) absoluteLocation equals: 6.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseAnAccelerationCard [
	
	| myBoxes myBoard testPlayers myDie game cards|
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (AccelerationCard of:#napolitana on:'').
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with:#napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game applyCard:(cards at:1) to: testPlayers.
	game oneRound.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	
	game oneRound.
	self assert: ((game ranking) first) absoluteLocation equals: 4.
	self assert: ((game ranking) second) absoluteLocation equals: 4.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseAnOverloadCard [
	
	| myBoxes myBoard testPlayers myDie game cards|
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection with: (OverloadCard of: #napolitana on: '').
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game applyCard: cards first to: #margarita. 
	self assert: (cards first) owner equals: #napolitana.
	game runOneTurn.
	game runOneTurn.
	self assert: ((game ranking) second) absoluteLocation equals: 0.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseAnOverloadCardAndEndUpWithNegativeNumbers [
	
	| myBoxes myBoard testPlayers myDie game cards|
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (OverloadCard of: #napolitana on: '').
		
	myBoard := Board withBoxes: myBoxes.
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoard: myBoard players: testPlayers dice: myDie laps: 1 andCards: cards.
	game applyCard: cards first to: #margarita. 
	game runOneTurn.
	game runOneTurn.
	self assert: ((game ranking) second) absoluteLocation equals: -1.
	self assert: ((game ranking) first) absoluteLocation equals: 1.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testaBoardShouldHaveMoreThanCeroBoxes [

	| block kindOfError errorMessage|
	
	
	block := [ Board withSize:0.].
	kindOfError := Error.
	errorMessage := 'Un tablero no puede tener menos de 1 casillero.'.
	
	self should: block raise: kindOfError withMessage: errorMessage.
]
