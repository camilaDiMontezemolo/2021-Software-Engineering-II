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
		with: CardBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new.
	
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	deck := Deck withCards: (OrderedCollection with: (RepeatCard new) with: (AccelerationCard new) with: (SpeedUpCard new) with: (AccelerationCard new) with: (SpeedUpCard new)).
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(1))).
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
		with: NoEffectBox new
		with: CardBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new.
	
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	deck := Deck withCards: (OrderedCollection with: (RepeatCard new) with: (AccelerationCard new) with: (SpeedUpCard new) with: (AccelerationCard new) with: (SpeedUpCard new)).
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(1))).
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
	
	| cards numberOfOverloads numberOfSpeedUps numberOfAccelerationCard numberOfCancellationCard numberOfRedoCard numberOfRepeatCart|
	cards := DeckGeneretor give: 5000 
	for: (OrderedCollection  with: OverloadCard  with: CancellationCard with: SpeedUpCard  with: RepeatCard with: AccelerationCard with: RedoCard) 
	with: (OrderedCollection with: 0.167 with: 0.167 with: 0.167 with: 0.167 with: 0.167  with: 0.165).
	
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
	self assert: cards  size equals: 5000 .
	
]

{ #category : #tests }
DeckTests >> testADecksPercentegeNeedsToBeCompleteToBeValid [

	self should: [ 
		DeckGeneretor 
		give: 5000 
		for: (OrderedCollection  with: OverloadCard  with: CancellationCard with: SpeedUpCard  with: RepeatCard with: AccelerationCard with: RedoCard) 
		with: (OrderedCollection with: 0.167 with: 0.167 with: 0.167 with: 0.167 with: 0.167  with: 0.16).] raise: Error withMessage: 'Las suma de probabilidades debe ser 1.'.
]
