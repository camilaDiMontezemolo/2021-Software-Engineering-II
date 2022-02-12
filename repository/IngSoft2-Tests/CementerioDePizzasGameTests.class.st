Class {
	#name : #CementerioDePizzasGameTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CementerioDePizzasGameTests >> createStandardBoardFor: number [
	| boxes |
	boxes := 	BoxGenerator give: number.
	boxes add: 0.38 of: NoEffectBox.
	boxes add: 0.2 of: SpeedupBox.
	boxes add: 0.2 of: WormHoleBox.
	boxes add: 0.1 of: MoonWalkBox.
	boxes add: 0.02 of: AtomicBombBox.
	boxes add: 0.1 of: CardBox.
	^boxes
]

{ #category : #tests }
CementerioDePizzasGameTests >> createStandardDeckFor: number [
	| cards deck |
	cards := DeckGeneretor with: number.
	
	cards add: 0.167 of: OverloadCard.
	cards add: 0.167 of: CancellationCard.
	cards add: 0.167 of: SpeedUpCard.
	cards add: 0.167 of: RepeatCard.
	cards add: 0.167 of: AccelerationCard.
	cards add: 0.165 of: RedoCard.
	
	deck := Deck withCards: cards.
	^deck.
]

{ #category : #tests }
CementerioDePizzasGameTests >> should: block raise: kindOfError withMessage: errorMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : #tests }
CementerioDePizzasGameTests >> testADiceShouldHaveAtLeastOneSide [
	
	self should: [Die withSides: 0.] raise: Error withMessage: 'Un dado no puede tener menos de 3 cara(s).'.
]

{ #category : #tests }
CementerioDePizzasGameTests >> testAGameDoesntStartIfTheBoardDoesNotMeetTheRequirementsOfTheGame [

	| dice players board deck |
	
	dice := OrderedCollection with: (Die withSides: 3).
	board := 	BoxGenerator give: 50.
	board add: 0.18 of: NoEffectBox.
	board add: 0.2 of: SpeedupBox.
	board add: 0.2 of: WormHoleBox.
	board add: 0.1 of: MoonWalkBox.
	board add: 0.02 of: AtomicBombBox.
	board add: 0.1 of: CardBox.
	players:= (OrderedCollection with: #hawaiana).

	
	deck := self createStandardDeckFor: 10.

	self should: [PizzaGame withBoxes: board players: players dice: dice laps: 2 andDeck: deck] raise: Error withMessage: 'El tablero no cumple con los requerimientos de este juego.'.
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testAGameNeedsAtLeastTwoCardsForEachPlayer [
	| dice napolitana board testPlayers deck |
	
	napolitana:= #napolitana.
	
	dice := OrderedCollection with: (Die withSides: 5).
	board := self createStandardBoardFor: 5.
	
	testPlayers:= OrderedCollection with: napolitana.
	deck := self createStandardDeckFor: 0.
	self should: [PizzaGame withBoxes: board players: testPlayers dice: dice laps: 1 andDeck: deck] raise: Error withMessage: 'Un juego no puede tener menos de 2 cartas por jugador.'
	
	
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testAGameShouldHaveAtLeastOneLap [

	| dice players board deck |
	
	dice := OrderedCollection with: (Die withSides: 3).
	board := self createStandardBoardFor: 10.
	players:= (OrderedCollection with: #hawaiana).
	deck := self createStandardDeckFor: 10.
	self should: [PizzaGame withBoxes: board players: players dice: dice laps: 0 andDeck: deck] raise: Error withMessage: 'Un juego no puede tener menos de 1 vuelta.'.
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testCreateAGameMultiPlayer [ 
	| game dice napolitana ranking margarita testPlayers mozzarella boxes deck |
	napolitana := #napolitana.
	margarita := #margarita.
	mozzarella := #mozzarella.
	boxes := OrderedCollection
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

	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(4 4 4 2 2 2 2 2 2 6 6 6 2 2 2))).
	deck := self createStandardDeckFor: 40.
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game play.
	ranking := game ranking.
	self assert: game isFinished.
	self assert: game firstPlace player identicalTo: napolitana.
	self assert: (ranking at: 1) player identicalTo: napolitana.
	self assert: (ranking at: 2) player identicalTo: mozzarella.
	self assert: (ranking at: 3) player identicalTo: margarita.
]

{ #category : #tests }
CementerioDePizzasGameTests >> testCreateAGameSinglePlayer [
	
	| game dice positions napolitana testPlayers deck board |
	
	napolitana:= #napolitana.
	
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(5))).
	board := self createStandardBoardFor: 5.
	testPlayers:= OrderedCollection with: napolitana.
	deck := self createStandardDeckFor: 10.
	game := PizzaGame withBoxes: board players: testPlayers dice: dice laps: 1 andDeck: deck.
	
	game play.
	positions := game ranking.
	self assert: (game isFinished).
	self assert: (positions at:1) player identicalTo: napolitana.
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testCreateARandomMultiPlayerGame [
	
	| game dice napolitana margarita testPlayers mozzarella deck board |
	
	napolitana:= #napolitana.	
	margarita:= #margarita.
	mozzarella:= #mozzarella.
	
	board := self createStandardBoardFor: 40.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	dice := Beaker with: (OrderedCollection with: (Die withSides: 5) with: (Die withSides: 4)).
	deck := self createStandardDeckFor: 10.
	game:= PizzaGame withBoxes: board players: testPlayers dice: dice laps: 1 andDeck: deck.
	
	game play.
	
	self assert: (game isFinished).
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testYouShouldBeAbleToGetYourLapAndLocation [
	
	| boxes testPlayers dice game deck |

    boxes := OrderedCollection 
        with: NoEffectBox new 
        with: NoEffectBox new
        with: NoEffectBox new 
        with: NoEffectBox new.
	
	deck := self createStandardDeckFor: 10.
   testPlayers := OrderedCollection with:#margarita with: #napolitana.
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(6))).
   game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 2 andDeck: deck.
	game playNextTurn.
	
	self assert: ((game ranking) first) lap equals: 1.
	self assert: ((game ranking) second) location equals: 0.
	 
]
