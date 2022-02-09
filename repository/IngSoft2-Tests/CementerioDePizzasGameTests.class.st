Class {
	#name : #CementerioDePizzasGameTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
CementerioDePizzasGameTests >> testACardGeneratorShouldntBeAbleToGiveZeroCards [

| dice napolitana someBoxes testPlayers cards deck randomCards |
	
	napolitana:= #napolitana.
	
	dice := OrderedCollection with: (Die withSides: 5).
	someBoxes:= BoxGenerator give: 5.
	someBoxes add: 0.38 of: NoEffectBox.
	someBoxes add: 0.2 of: SpeedupBox.
	someBoxes add: 0.2 of: WormHoleBox.
	someBoxes add: 0.1 of: MoonWalkBox.
	someBoxes add: 0.02 of: AtomicBombBox.
	someBoxes add: 0.1 of: CardBox.
	
	testPlayers:= OrderedCollection with: napolitana.
	
	randomCards :=OrderedCollection 
		with: (AccelerationCard new) 
		with: (CancellationCard new) 
		with: (OverloadCard new) 
		with: (RedoCard new) 
		with: (RepeatCard new) 
		with:(SpeedUpCard new).
	cards := DeckGenerator with: 0 for: randomCards .
	deck := Deck withCards: cards. 

	self should: [PizzaGame withBoxes: (someBoxes boxes) players: testPlayers dice: dice laps: 1 andDeck: deck] 
				raise: Error withMessage: 'Un juego no puede tener menos de 2 cartas por jugador.'
	
	
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testADiceShouldHaveAtLeastOneSide [
	
	self should: [Die withSides: 0.] raise: Error withMessage: 'Un dado no puede tener menos de 3 cara(s).'.
]

{ #category : #tests }
CementerioDePizzasGameTests >> testAGameDoesntStartIfTheDeckGeneratorsPercentageIsntOne [

	| dice players cards someBoxes randomCards |
	
	dice := OrderedCollection with: (Die withSides: 3).
	someBoxes:= BoxGenerator give: 10.
	someBoxes add: 0.38 of: NoEffectBox.
	someBoxes add: 0.2 of: SpeedupBox.
	someBoxes add: 0.2 of: WormHoleBox.
	someBoxes add: 0.1 of: MoonWalkBox.
	someBoxes add: 0.02 of: AtomicBombBox.
	players:= (OrderedCollection with: #hawaiana).
	randomCards :=OrderedCollection 
		with: (AccelerationCard new) 
		with: (CancellationCard new) 
		with: (OverloadCard new) 
		with: (RedoCard new) 
		with: (RepeatCard new) 
		with:(SpeedUpCard new).

	cards := Deck withCards: (DeckGenerator with: 2 for: randomCards).
	self should: [PizzaGame withBoxes: someBoxes players: players dice: dice laps: 2 andDeck: cards] raise: Error withMessage: 'El tablero está incompleto.'.
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testAGameShouldHaveAtLeastOneLap [

	| dice players cards someBoxes randomCards |
	
	dice := OrderedCollection with: (Die withSides: 3).
	someBoxes:= BoxGenerator give: 10.
	someBoxes add: 0.38 of: NoEffectBox.
	someBoxes add: 0.2 of: SpeedupBox.
	someBoxes add: 0.2 of: WormHoleBox.
	someBoxes add: 0.1 of: MoonWalkBox.
	someBoxes add: 0.02 of: AtomicBombBox.
	someBoxes add: 0.1 of: CardBox.
	players:= (OrderedCollection with: #hawaiana).
	randomCards :=OrderedCollection 
		with: (AccelerationCard new) 
		with: (CancellationCard new) 
		with: (OverloadCard new) 
		with: (RedoCard new) 
		with: (RepeatCard new) 
		with:(SpeedUpCard new).

	cards := Deck withCards: (DeckGenerator with: 2 for: randomCards).
	self should: [PizzaGame withBoxes: someBoxes players: players dice: dice laps: 0 andDeck: cards] raise: Error withMessage: 'Un juego no puede tener menos de 1 vuelta.'.
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testCreateAGameMultiPlayer [
	| game dice napolitana ranking margarita testPlayers mozzarella boxes cards deck randomCards |
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
	randomCards :=OrderedCollection 
		with: (AccelerationCard new) 
		with: (CancellationCard new) 
		with: (OverloadCard new) 
		with: (RedoCard new) 
		with: (RepeatCard new) 
		with:(SpeedUpCard new).
	cards := DeckGenerator with: 100 for: randomCards .
	deck := Deck withCards: cards. 
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
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
	
	| game dice positions napolitana someBoxes testPlayers cards deck randomCards |
	
	napolitana:= #napolitana.
	
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(5))).
	someBoxes:= BoxGenerator give: 5.
	someBoxes add: 0.38 of: NoEffectBox.
	someBoxes add: 0.2 of: SpeedupBox.
	someBoxes add: 0.2 of: WormHoleBox.
	someBoxes add: 0.1 of: MoonWalkBox.
	someBoxes add: 0.02 of: AtomicBombBox.
	someBoxes add: 0.1 of: CardBox.
	
	testPlayers:= OrderedCollection with: napolitana.
	
	randomCards :=OrderedCollection 
		with: (AccelerationCard new) 
		with: (CancellationCard new) 
		with: (OverloadCard new) 
		with: (RedoCard new) 
		with: (RepeatCard new) 
		with:(SpeedUpCard new).
	cards := DeckGenerator with: 100 for: randomCards .
	deck := Deck withCards: cards. 
	game := PizzaGame withBoxes: (someBoxes boxes) players: testPlayers dice: dice laps: 1 andDeck: deck.
	
	game play.
	positions := game ranking.
	self assert: (game isFinished).
	self assert: (positions at:1) player identicalTo: napolitana.
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testCreateARandomMultiPlayerGame [
	
	| game dice napolitana margarita testPlayers mozzarella boxesGen cards deck randomCards |
	
	napolitana:= #napolitana.	
	margarita:= #margarita.
	mozzarella:= #mozzarella.
	
	boxesGen:= BoxGenerator give: 40.
	boxesGen add: 0.38 of: NoEffectBox.
	boxesGen add: 0.2 of: SpeedupBox.
	boxesGen add: 0.2 of: WormHoleBox.
	boxesGen add: 0.1 of: MoonWalkBox.
	boxesGen add: 0.02 of: AtomicBombBox.
	boxesGen add: 0.1 of: CardBox.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	dice := Beaker with: (OrderedCollection with: (Die withSides: 5) with: (Die withSides: 4)).
	randomCards :=OrderedCollection 
		with: (AccelerationCard new) 
		with: (CancellationCard new) 
		with: (OverloadCard new) 
		with: (RedoCard new) 
		with: (RepeatCard new) 
		with:(SpeedUpCard new).
	cards := DeckGenerator with: 100 for: randomCards .
	deck := Deck withCards: cards. 
	game:= PizzaGame withBoxes: boxesGen players: testPlayers dice: dice laps: 1 andDeck: deck.
	
	game play.
	
	self assert: (game isFinished).
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testYouShouldBeAbleToGetYourLapAndLocation [
	
	| boxes testPlayers dice game cards deck randomCards |

    boxes := OrderedCollection 
        with: NoEffectBox new 
        with: NoEffectBox new
        with: NoEffectBox new 
        with: NoEffectBox new.

   randomCards :=OrderedCollection 
		with: (AccelerationCard new) 
		with: (CancellationCard new) 
		with: (OverloadCard new) 
		with: (RedoCard new) 
		with: (RepeatCard new) 
		with:(SpeedUpCard new).
	cards := DeckGenerator with: 50 for: randomCards .
	deck := Deck withCards: cards. 
   testPlayers := OrderedCollection with:#margarita with: #napolitana.
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(6))).
   game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 2 andDeck: deck.
	game playNextTurn.
	
	self assert: ((game ranking) first) lap equals: 1.
	self assert: ((game ranking) second) location equals: 0.
	 
]
