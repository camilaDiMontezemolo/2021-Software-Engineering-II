Class {
	#name : #BoardTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #creation }
BoardTests >> createBoardTestingDeck [
		| deck |
	deck := Deck 
	withCards: (OrderedCollection with: (RepeatCard new) with: (AccelerationCard new) with: (AccelerationCard new) with: (SpeedUpCard new) with: (AccelerationCard new) with: (SpeedUpCard new) ).
	^deck.

]

{ #category : #creation }
BoardTests >> createStandardBoardFor: number [
	| boxes |
	
	boxes := BoxGenerator give: number for: (OrderedCollection  with: NoEffectBox  with: SpeedupBox with: WormHoleBox  with: MoonWalkBox with: AtomicBombBox with: CardBox) with: (OrderedCollection with: 0.38 with: 0.2 with: 0.2  with: 0.1 with: 0.02  with: 0.1).
	^boxes.
]

{ #category : #asserting }
BoardTests >> should: block raise: kindOfError withMessage: errorMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : #tests }
BoardTests >> testABoardShouldHaveMoreThanZeroBoxes [

    |  dice deck |

   dice := OrderedCollection with: (Die withSides: 3).
	deck := self createBoardTestingDeck.
    self should: [ PizzaGame withBoxes: OrderedCollection new players: (OrderedCollection with: #Margarita) dice: dice laps: 1 andDeck: deck.] raise: Error withMessage: 'Un juego no puede tener menos de 1 casillero.'.
		
]

{ #category : #tests }
BoardTests >> testABoardShouldHaveMoreThanZeroDie [

	| someBoxes testPlayers |

	someBoxes := self createStandardBoardFor: 5000.
	testPlayers:=(OrderedCollection with: #hawaiana).
		
	self should: [PizzaGame withBoxes: someBoxes players: testPlayers dice: OrderedCollection new laps: 1 andDeck: self createBoardTestingDeck.] raise: Error withMessage: 'Un juego no puede tener menos de un dado'
]

{ #category : #tests }
BoardTests >> testABoardShouldHaveMoreThanZeroPlayers [

	|  dice someBoxes |
	
	dice := OrderedCollection with: (Die withSides: 3).
	someBoxes := self createStandardBoardFor: 5.
	self should: [ PizzaGame withBoxes: someBoxes players: OrderedCollection new dice: dice laps: 1 andDeck: self createBoardTestingDeck.] raise: Error withMessage: 'Un juego no puede tener menos de 1 jugador.'.
		
]

{ #category : #tests }
BoardTests >> testABoxGeneratorGivesBoxesWithProbabilities [

	| numberOfNoEffectBoxes numberOfSpeed numberOfWorm numberOfMoon numberOfAtomic cantidadCardBox board|
	
	board := self createStandardBoardFor: 5000.
	
	numberOfNoEffectBoxes := board count: [ :card | card isMemberOf: NoEffectBox ].
	numberOfSpeed := board  count: [ :card | card isMemberOf: SpeedupBox ].
	numberOfWorm := board count: [ :card | card isMemberOf: WormHoleBox ].
	numberOfMoon := board count: [ :card | card isMemberOf: MoonWalkBox ].
	numberOfAtomic := board  count: [ :card | card isMemberOf: AtomicBombBox ].
	cantidadCardBox := board count: [ :card | card isMemberOf: CardBox ].

	self assert: (numberOfNoEffectBoxes between: 1800 and: 2000).	
	self assert: (numberOfSpeed between: 900 and: 1000).
	self assert: (numberOfWorm between: 900 and: 1000).	
	self assert: (numberOfMoon between: 400 and: 500).
	self assert: (numberOfAtomic between: 50 and: 150).	
	self assert: (cantidadCardBox between: 400 and: 500).
	self assert: board size equals: 5000.
]

{ #category : #tests }
BoardTests >> testABoxGeneratorShouldNotGiveBoxesIfProbabilitiesSumMoreThanOne [
		
	| boxGen |
	self should: [ boxGen := BoxGenerator give: 5000 for: (OrderedCollection  with: NoEffectBox  with: SpeedupBox with: WormHoleBox  with: MoonWalkBox with: AtomicBombBox with: CardBox) with: (OrderedCollection with: 0.38 with: 0.2 with: 0.2  with: 0.1 with: 0.02  with: 0.5).	] raise: Error withMessage: 'Las suma de probabilidades debe ser 1.'.
]

{ #category : #tests }
BoardTests >> testACardBoxGivesCards [
	| game dice ranking testPlayers boxes deck napolitanaHand |
		
	boxes := OrderedCollection
		with: CardBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new.
	
	testPlayers := OrderedCollection with: #napolitana.
	deck := Deck withCards: (OrderedCollection with: (RepeatCard new) with: (AccelerationCard new) with: (SpeedUpCard new)).
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(1))).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game playTurnForAllPlayers.
	napolitanaHand := game handOf: #napolitana.
	
	game player: #napolitana wantsToApplyCard: (napolitanaHand at: 3) to: #napolitana.
	game playTurnForAllPlayers.
	ranking := game ranking.
	
	self assert: (ranking first) location equals: 3.
]

{ #category : #tests }
BoardTests >> testAMoonWalkBoxJumpsAPlayerBoxesBack [
	
	| boxes testPlayers dice game deck|
	
	boxes := OrderedCollection 
		with: NoEffectBox new 
		with: MoonWalkBox new 
		with: NoEffectBox new 
		with: NoEffectBox new.
	testPlayers := OrderedCollection with: #napolitana with: #hawaiana.
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(2))).
	deck := self createBoardTestingDeck.
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game playTurnForAllPlayers.

	self assert: (game ranking second) location equals: 1.
	
]

{ #category : #tests }
BoardTests >> testANoEffectBoxHasNoEffects [
	
	| boxes  testPlayers dice game positions deck |
	
	boxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new.
	testPlayers := OrderedCollection with: #napolitana.
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(2))).
	deck := self createBoardTestingDeck.
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game playTurnForAllPlayers.
	positions := game ranking.

	self assert: (positions first) location equals: 2.
	
]

{ #category : #tests }
BoardTests >> testASpeedupBoxJumpsYouFourBoxes [
	
	| game dice ranking testPlayers boxes deck|
	boxes := OrderedCollection
		with: SpeedupBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new.

	testPlayers := OrderedCollection with: #napolitana.
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(1))).
	deck := self createBoardTestingDeck.
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game playTurnForAllPlayers.
	ranking := game ranking.
	self assert: (ranking first) location equals: 5.

]

{ #category : #tests }
BoardTests >> testAnAtomicBombBoxSendsEveryoneBackToZero [
	
	| game dice ranking testPlayers boxes deck |
	boxes := OrderedCollection
		with: NoEffectBox new
		with: NoEffectBox new
		with: AtomicBombBox new
		with: NoEffectBox new
		with: NoEffectBox new.
		
	testPlayers := OrderedCollection
		with: #napolitana
		with: #margarita
		with: #hawaiana.
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(4))).
	deck := self createBoardTestingDeck.
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 2 andDeck: deck.
	game playTurnForAllPlayers.
	game playTurnForAllPlayers.
	ranking := game ranking.
	self assert: (ranking first) location equals: 1.
	self assert: (ranking second) location equals: 4.
	self assert: (ranking third) location equals: 4.
	
]
