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

	|  block someBoxes testPlayers cards|

	someBoxes:= BoxGenerator give: 20.
	testPlayers:=(OrderedCollection with: #hawaiana).
	cards := CardGenerator forPlayer: testPlayers give: 2.
	block:=[PizzaGame
		withBoxes: someBoxes
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
		withBoxes: myBoxes
		players: OrderedCollection new
		dice: myDie
		laps: 1
		andCards: cards.
		].
	
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 jugador.'.
		
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testACardBoxGivesCards [
	| game myDie ranking testPlayers myBoxes cards cardBox |
	cardBox := CardBoxLoaded
		loadedWith: (OrderedCollection with: (SpeedUpCard of: #napolitana on: '')).
		
	myBoxes := OrderedCollection
		with: cardBox
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new.
	
	testPlayers := OrderedCollection with: #napolitana.
	
	cards := OrderedCollection
		with: (RepeatCard of: #napolitana on: '')
		with: (AccelerationCard of: #napolitana on: '').
		
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	
	game := PizzaGame
		withBoxes: myBoxes
		players: testPlayers
		dice: myDie
		laps: 1
		andCards: cards.
		
	game playTurnForAllPlayers.
	game applyCard: (cards at: 3) to: #napolitana.
	game playTurnForAllPlayers.
	ranking := game ranking.
	
	self assert: (ranking at: 1) absoluteLocation equals: 3
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testACardCanNotBeUsedOutsideYourTurn [
	
	| myBoxes testPlayers myDie game cards block|
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (AccelerationCard of:#napolitana on:'').
		
	testPlayers := OrderedCollection with:#margarita with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame 	withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game playTurnForAllPlayers.
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
	| block |
	
	block:= [Dice withSides: 0.].
	self should: block raise: Error withMessage: 'Un dado no puede tener menos de 3 cara(s).'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testAGameShouldHaveAtLeastOneLap [

	| myDie myPlayers block cards myBoxes|
	
	myDie := OrderedCollection with: (Dice withSides: 3).
	myBoxes:= BoxGenerator give: 10.
	myPlayers:= (OrderedCollection with: #hawaiana).
	cards := CardGenerator forPlayer: myPlayers give: 2.
	block:=[PizzaGame withBoxes: myBoxes players: myPlayers dice: myDie laps: 0 andCards: cards].
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 vuelta.'.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testAMoonWalkBoxJumpsAPlayerBoxesBack [
	
	| myBoxes testPlayers myDie game cards|
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: (MoonWalkBox loadedWith: 1) 
		with: NoEffectBox with: NoEffectBox.
	testPlayers := OrderedCollection with: #napolitana with: #hawaiana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game playTurnForAllPlayers.

	self assert: (game ranking second) absoluteLocation equals: 1.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testANoEffectBoxHasNoEffects [
	
	| myBoxes  testPlayers myDie game positions cards|
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new.
	testPlayers := OrderedCollection with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game playTurnForAllPlayers.
	positions := game ranking.

	self assert: (positions at:1)absoluteLocation equals: 2.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testASpeedupBoxJumpsYouFourBoxes [
	
	| game myDie ranking testPlayers myBoxes cards|
	myBoxes := OrderedCollection
		with: SpeedupBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new.

	testPlayers := OrderedCollection with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game playTurnForAllPlayers.
	ranking := game ranking.
	self assert: (ranking at: 1) absoluteLocation equals: 5.

]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testAnAtomicBombBoxSendsEveryoneBackToZero [
	
	| game myDie ranking testPlayers myBoxes cards|
	myBoxes := OrderedCollection
		with: NoEffectBox new
		with: NoEffectBox new
		with: AtomicBombBox new
		with: NoEffectBox new
		with: NoEffectBox new.
		
	testPlayers := OrderedCollection
		with: #napolitana
		with: #margarita
		with: #hawaiana.
	myDie := OrderedCollection
		with: (LoadedDice withTosses: #(4)).
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 2 andCards: cards.
	game playTurnForAllPlayers.
	game playTurnForAllPlayers.
	ranking := game ranking.
	self assert: (ranking first) absoluteLocation equals: 6.
	self assert: (ranking second) absoluteLocation equals: 4.
	self assert: (ranking third) absoluteLocation equals: 4.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testCreateAGameMultiPlayer [
	| game myDie napolitana ranking margarita testPlayers mozzarella myBoxes cards|
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

	testPlayers := OrderedCollection
		with: #napolitana
		with: #margarita
		with: #mozzarella.
	myDie := OrderedCollection
		with: (LoadedDice withTosses: #(4 4 4 2 2 2 2 2 2 6 6 6 2 2 2)).
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game play.
	ranking := game ranking.
	self assert: game isFinished.
	self assert: game firstPlace player identicalTo: napolitana.
	self assert: (ranking at: 1) player identicalTo: napolitana.
	self assert: (ranking at: 2) player identicalTo: mozzarella.
	self assert: (ranking at: 3) player identicalTo: margarita
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testCreateAGameSinglePlayer [
	
	| game myDie positions napolitana myBoxes testPlayers cards|
	
	napolitana:= #napolitana.
	
	myDie := OrderedCollection with: (Dice withSides: 5).
	myBoxes:= BoxGenerator give: 5.
	
	testPlayers:= OrderedCollection with: napolitana.
	
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	
	game play.
	positions := game ranking.
	self assert: (game isFinished).
	self assert: (positions at:1) player identicalTo: napolitana.
	
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
	
	| game myDie napolitana margarita testPlayers mozzarella myBoxes cards|
	
	napolitana:= #napolitana.	
	margarita:= #margarita.
	mozzarella:= #mozzarella.
	
	myBoxes:= BoxGenerator give: 40.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	myDie := OrderedCollection with: (Dice withSides: 5) with: (Dice withSides: 4).
	cards := CardGenerator forPlayer: testPlayers give: 2.
	game:= PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	
	game play.
	
	self assert: (game isFinished).
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnASpeedupCard [
	
	| myBoxes testPlayers myDie game cards emptyCard|
	
	emptyCard := EmptyCard new.

	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (CancellationCard of: #napolitana on:emptyCard)
		with: (SpeedUpCard of: #margarita on: '').
		
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game playNextTurn.
	game applyCard: cards second to: #margarita.
	game applyCard: cards first to: cards second. 
	game playNextTurn.
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	
	self assert: cards size equals: 0.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnAnAccelerationCard [
	
	| myBoxes testPlayers myDie game cards emptyCard|
	
	emptyCard := EmptyCard new.

	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (CancellationCard of: #napolitana on:emptyCard)
		with: (AccelerationCard of: #margarita on: '').
		
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game playNextTurn.
	game applyCard: cards second to: testPlayers.
	game applyCard: cards first to: cards second. 
	game playNextTurn.
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	
	self assert: cards size equals: 0.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnAnInactiveCardRaiseError [
	
	| myBoxes testPlayers myDie game cards emptyCard block |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
	emptyCard := EmptyCard new.
	cards := OrderedCollection
		with: (CancellationCard of: #napolitana on: emptyCard)
		with: (SpeedUpCard of: #margarita on: #'').
		
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game playNextTurn.
	 
	block:=[game applyCard: cards first to: cards second.].
	self should: block raise: Error withMessage: 'No se puede cancelar una carta inactiva.'

	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnAnInstantCardRaiseAnError [
	
	| myBoxes testPlayers myDie game cards emptyCard block |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
	emptyCard := EmptyCard new.
	cards := OrderedCollection
		with: (CancellationCard of: #napolitana on: emptyCard)
		with: (CancellationCard of: #margarita on: emptyCard).
		
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game playNextTurn.
	 
	block:=[game applyCard: cards first to: cards second.].
	self should: block raise: Error withMessage: 'No se puede cancelar una carta instantanea.'

	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnAnOverloadCard [
	
	| myBoxes testPlayers myDie game cards emptyCard|
	
	emptyCard := EmptyCard new.

	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (CancellationCard of: #napolitana on:emptyCard)
		with: (OverloadCard of: #margarita on: '').
		
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game playNextTurn.
	game applyCard: cards second to: #margarita.
	game applyCard: cards first to: cards second. 
	game playNextTurn.
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	
	self assert: cards size equals: 0.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseARedoCard [
	
	| myBoxes testPlayers myDie game cards|

    myBoxes := OrderedCollection 
        with: NoEffectBox new 
        with: NoEffectBox new
        with: NoEffectBox new 
        with: NoEffectBox new.

    cards := OrderedCollection
        with: (SpeedUpCard of: #margarita on:#margarita)
        with: (RedoCard of: #napolitana on: #napolitana).

    testPlayers := OrderedCollection with:#margarita with: #napolitana.
    myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
    game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
    game playTurnForAllPlayers.

    self assert: ((game ranking) second) absoluteLocation equals: 3.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseARedoCardOverCancelation [
	
	| myBoxes testPlayers myDie game cards cardOne cardTwo cardThree cardFour emptyCard |
	
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
		
	testPlayers := OrderedCollection with:#margarita with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 10 andCards: cards.
	game applyCard: (cardThree) to: (cardOne). 
	game applyCard: (cardFour) to: (cardTwo). 
	game playTurnForAllPlayers.
	
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseARepeatCard [
	
	| myBoxes testPlayers myDie game cards|
	
	myBoxes := OrderedCollection 
		with: SpeedupBox new
		with: NoEffectBox new 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (RepeatCard of: #napolitana on: '').
		
	testPlayers := OrderedCollection with:#margarita with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game playNextTurn.
	game applyCard: cards first to: #napolitana. 
	
	self assert: ((game ranking) first) absoluteLocation equals: 5.
	self assert: ((game ranking) second) absoluteLocation equals: 4.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseARepeatCardWhenNoDieWasRolledYet [
	
	| myBoxes testPlayers myDie game cards|
	
	myBoxes := OrderedCollection 
		with: SpeedupBox new
		with: NoEffectBox new 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (RepeatCard of: #napolitana on: '').
		
	testPlayers := OrderedCollection with:#margarita with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game applyCard: cards first to: #napolitana. 
	
	self assert: ((game ranking) first) absoluteLocation equals: 0.
	self assert: ((game ranking) second) absoluteLocation equals: 0.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseASpeedUpCard [
	
	| myBoxes testPlayers myDie game cards rankingOne |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (SpeedUpCard of: #napolitana on: '').
		
	testPlayers := OrderedCollection with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game applyCard: (cards at:1) to: #napolitana.
	game playTurnForAllPlayers.
	rankingOne:= game ranking.
	
	self assert: (rankingOne first) absoluteLocation equals: 3.
	self assert: cards size equals: 1.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseASpeedUpCardOnTwoRounds [
	
	| myBoxes testPlayers myDie game cards rankingTwo |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (SpeedUpCard of: #napolitana on: '').
		
	testPlayers := OrderedCollection with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game applyCard: (cards at:1) to: #napolitana.
	game playTurnForAllPlayers.
	game playTurnForAllPlayers.
	rankingTwo:= game ranking.
	
	self assert: (rankingTwo first) absoluteLocation equals: 6.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseAnAccelerationCard [
	
	| myBoxes testPlayers myDie game cards|
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (AccelerationCard of:#napolitana on:'').
		
	testPlayers := OrderedCollection with:#napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game applyCard:(cards at:1) to: testPlayers.
	game playTurnForAllPlayers.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	
	game playTurnForAllPlayers.
	self assert: ((game ranking) first) absoluteLocation equals: 4.
	self assert: ((game ranking) second) absoluteLocation equals: 4.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseAnOverloadCard [
	
	| myBoxes testPlayers myDie game cards|
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection with: (OverloadCard of: #napolitana on: '').
		
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game applyCard: cards first to: #margarita. 
	self assert: (cards first) owner equals: #napolitana.
	game playNextTurn.
	game playNextTurn.
	self assert: ((game ranking) second) absoluteLocation equals: 0.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseAnOverloadCardAndEndUpWithNegativeNumbers [
	
	| myBoxes testPlayers myDie game cards|
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (OverloadCard of: #napolitana on: '').
		
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andCards: cards.
	game applyCard: cards first to: #margarita. 
	game playNextTurn.
	game playNextTurn.
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
