Class {
	#name : #DeckTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DeckTests >> should: block raise: kindOfError withMessage: errorMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : #tests }
DeckTests >> testACardBoxDoesntGiveCardsIfTheDeckIsEmptyAndNoCardsWereUsed [

	| game dice testPlayers boxes deck napolitanaHand margaritaHand |
		
	boxes := OrderedCollection
		with: CardEffect new
		with: NoEffect new
		with: NoEffect new
		with: NoEffect new
		with: NoEffect new.
	
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	deck := Deck withCards: (OrderedCollection with: (RepeatCard new) with: (AccelerationCard new) with: (SpeedUpCard new) with: (AccelerationCard new) with: (SpeedUpCard new)).
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses:#(1) andSides:3 )).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	napolitanaHand := game handOf: #napolitana.
	margaritaHand := game handOf: #margarita.
	game playTurnForAllPlayers.	
		
	self assert: (napolitanaHand size) equals: 3.
	self assert: (margaritaHand size) equals: 2.
]

{ #category : #tests }
DeckTests >> testACardBoxGivesACardIfTheDeckIsEmptyAndOneCardWasUsed [
	| game dice testPlayers boxes deck napolitanaHand margaritaHand |
		
	boxes := OrderedCollection
		with: NoEffect new
		with: CardEffect new
		with: NoEffect new
		with: NoEffect new
		with: NoEffect new
		with: NoEffect new.
	
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	deck := Deck withCards: (OrderedCollection with: (RepeatCard new) with: (AccelerationCard new) with: (SpeedUpCard new) with: (AccelerationCard new) with: (SpeedUpCard new)).
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(1) andSides: 4)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	napolitanaHand := game handOf: #napolitana.
	margaritaHand := game handOf: #margarita.
	game player: #napolitana wantsToApplyCard: (napolitanaHand at: 2) to: testPlayers.
	game playTurnForAllPlayers.	
		
	self assert: (napolitanaHand size) equals: 2.
	self assert: (margaritaHand size) equals: 3.
]

{ #category : #tests }
DeckTests >> testACardGeneratorGivesACollectionOfCardsWithProbability [

	| cards numberOfOverloads numberOfSpeedUps numberOfAccelerationCard numberOfCancellationCard numberOfRedoCard numberOfRepeatCart initialCards initialCardsPobabilities |
	initialCards := OrderedCollection
		                with: OverloadCard
		                with: CancellationCard
		                with: SpeedUpCard
		                with: RepeatCard
		                with: AccelerationCard
		                with: RedoCard.
	initialCardsPobabilities := OrderedCollection
		                            with: 0.167
		                            with: 0.167
		                            with: 0.167
		                            with: 0.167
		                            with: 0.167
		                            with: 0.165.

	cards := ProbabilityGenerator
		         give: 5000
		         for: initialCards
		         with: initialCardsPobabilities
		         usingFiller: SpeedUpCard.

	numberOfOverloads := cards proportionOf: OverloadCard.
	numberOfCancellationCard := cards proportionOf: CancellationCard.
	numberOfSpeedUps := cards proportionOf: SpeedUpCard.
	numberOfRepeatCart := cards proportionOf: RepeatCard.
	numberOfAccelerationCard := cards proportionOf: AccelerationCard.
	numberOfRedoCard := cards proportionOf: RedoCard.

	self assert: (numberOfOverloads between: 650 and: 950).
	self assert: (numberOfCancellationCard between: 650 and: 950).
	self assert: (numberOfRepeatCart between: 650 and: 950).
	self assert: (numberOfAccelerationCard between: 650 and: 950).
	self assert: (numberOfRedoCard between: 650 and: 950).
	self assert: (numberOfSpeedUps between: 650 and: 950).
	self assert: cards size equals: 5000
]

{ #category : #tests }
DeckTests >> testADecksPercentegeNeedsToBeCompleteToBeValid [

	self
		should: [ 
			ProbabilityGenerator 
				give: 5000
				for: (OrderedCollection
						 with: OverloadCard
						 with: CancellationCard
						 with: SpeedUpCard
						 with: RepeatCard
						 with: AccelerationCard
						 with: RedoCard)
				with: (OrderedCollection
						 with: 0.167
						 with: 0.167
						 with: 0.167
						 with: 0.167
						 with: 0.167
						 with: 0.16)
				usingFiller: SpeedPlusCard ]
		raise: Error
		withMessage: 'Las suma de probabilidades debe ser 1.'
]

{ #category : #tests }
DeckTests >> testDeckRefillsItself [

	| game dice ranking testPlayers boxes deck napolitanaHand cards usedCard|
	boxes := OrderedCollection
		         with: NoEffect new
		         with: CardEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new.
	cards := OrderedCollection
						with: SpeedUpCard new
			         with: AccelerationCard new.

	testPlayers := OrderedCollection with: #napolitana.
	deck := Deck withCards: cards.
	dice := Beaker with:
		        (OrderedCollection with:
			         (LoadedDie withTosses: #( 1 ) andSides: 3)).
	game := PizzaGame
		        withBoxes: boxes
		        players: testPlayers
		        dice: dice
		        laps: 1
		        andDeck: deck.
	napolitanaHand := game handOf: #napolitana.
	usedCard:= napolitanaHand first.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #napolitana.
	game playTurnForAllPlayers.
	napolitanaHand := game handOf: #napolitana.
	game handOf: #napolitana.
	ranking := game ranking.

	self assert: napolitanaHand second equals: usedCard.
]
