Class {
	#name : #CementerioDePizzasGameTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #creation }
CementerioDePizzasGameTests >> createStandardBoardFor: number [
	| boxes |
	boxes := EffectGenerator give: number for: (OrderedCollection  with: NoEffect  with: SpeedupEffect with: WormHoleBox  with: MoonWalkEffect with: AtomicBombEffect with: CardEffect) with: (OrderedCollection with: 0.38 with: 0.2 with: 0.2  with: 0.1 with: 0.02  with: 0.1).
	^boxes
]

{ #category : #creation }
CementerioDePizzasGameTests >> createStandardDeckFor: number [
	| cards deck |
	cards := DeckGenerator give: number for: (OrderedCollection  with: OverloadCard  with: CancellationCard with: SpeedUpCard  with: RepeatCard with: AccelerationCard with: RedoCard) with: (OrderedCollection with: 0.167 with: 0.167 with: 0.167 with: 0.167 with: 0.167  with: 0.165).
	
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
CementerioDePizzasGameTests >> testACardGeneratorGivesACollectionOfCardsWithProbability [
	
	| cards numberOfOverloads numberOfSpeedUps numberOfAccelerationCard numberOfCancellationCard numberOfRedoCard numberOfRepeatCart randomCards|
	randomCards :=OrderedCollection 
		with: (AccelerationCard new) 
		with: (CancellationCard new) 
		with: (OverloadCard new) 
		with: (RedoCard new) 
		with: (RepeatCard new) 
		with:(SpeedUpCard new).
	cards := DeckGenerator with: 5000 for: randomCards .
	numberOfOverloads := cards count: [ :card | card isMemberOf: OverloadCard  ].
	numberOfCancellationCard := cards count: [ :card | card isMemberOf: CancellationCard ].
	numberOfSpeedUps := cards count: [ :card | card isMemberOf: SpeedUpCard ].
	numberOfRepeatCart := cards count: [ :card | card isMemberOf: RepeatCard ].
	numberOfAccelerationCard := cards count: [ :card | card isMemberOf: AccelerationCard ].
	numberOfRedoCard := cards count: [ :card | card isMemberOf: RedoCard ].
	
	self assert: (numberOfOverloads between: 650 and: 950).	
	self assert: (numberOfCancellationCard between: 650 and: 950).
	self assert: (numberOfRepeatCart between: 650 and: 950).
	self assert: (numberOfAccelerationCard between: 650 and: 950).
	self assert: (numberOfRedoCard between: 650 and: 950).
	self assert: (numberOfSpeedUps between: 650 and: 950).
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testADiceShouldHaveAtLeastOneSide [
	
	self should: [Die withSides: 0.] raise: Error withMessage: 'Un dado no puede tener menos de 3 cara(s).'.
]

{ #category : #tests }
CementerioDePizzasGameTests >> testAGameMustHaveAtLeastTwoCardsForEachPlayer [

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

	| game dice napolitana ranking margarita testPlayers mozzarella boxes cards deck randomCards |
	napolitana := #napolitana.
	margarita := #margarita.
	mozzarella := #mozzarella.
	boxes := OrderedCollection
		         with: NoEffect new
		         with: NoEffect new
		         with: WormHoleBox new
		         with: AtomicBombEffect new
		         with: (MoonWalkEffect loadedWith: 1)
		         with: SpeedupEffect new.

	testPlayers := OrderedCollection
		               with: #napolitana
		               with: #margarita
		               with: #mozzarella.

	dice := Beaker with: (OrderedCollection with: (LoadedDie
				          withTosses: #( 4 4 4 2 2 2 2 2 2 6 6 6 2 2 2 )
				          andSides: 7)).
	randomCards := OrderedCollection
		               with: AccelerationCard new
		               with: CancellationCard new
		               with: OverloadCard new
		               with: RedoCard new
		               with: RepeatCard new
		               with: SpeedUpCard new.
	cards := DeckGenerator with: 100 for: randomCards.
	deck := Deck withCards: cards.
	game := PizzaGame
		        withBoxes: boxes
		        players: testPlayers
		        dice: dice
		        laps: 1
		        andDeck: deck.
	game play.
	ranking := game ranking.
	self assert: game isFinished.
	self assert: game firstPlace player identicalTo: napolitana.
	self assert: (ranking at: 1) player identicalTo: napolitana.
	self assert: (ranking at: 2) player identicalTo: mozzarella.
	self assert: (ranking at: 3) player identicalTo: margarita
]

{ #category : #tests }
CementerioDePizzasGameTests >> testCreateAGameSinglePlayer [

	| game dice positions napolitana testPlayers deck board |
	
	napolitana:= #napolitana.
	
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(5) andSides:6)).
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

	| boxes testPlayers dice game cards deck randomCards |
	boxes := OrderedCollection
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new.

	randomCards := OrderedCollection
		               with: AccelerationCard new
		               with: CancellationCard new
		               with: OverloadCard new
		               with: RedoCard new
		               with: RepeatCard new
		               with: SpeedUpCard new.
	cards := DeckGenerator with: 50 for: randomCards.
	deck := Deck withCards: cards.
	testPlayers := OrderedCollection with: #margarita with: #napolitana.
	dice := Beaker with:
		        (OrderedCollection with:
			         (LoadedDie withTosses: #( 6 ) andSides: 7)).
	game := PizzaGame
		        withBoxes: boxes
		        players: testPlayers
		        dice: dice
		        laps: 2
		        andDeck: deck.
	game playNextTurn.

	self assert: game ranking first lap equals: 1.
	self assert: game ranking second location equals: 0
]
