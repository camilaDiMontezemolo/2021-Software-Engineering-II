Class {
	#name : #BoardTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #creation }
BoardTests >> createBoardTestingDeck [
		| deck |
		deck := Deck withCards: (OrderedCollection with: (RepeatCard new) with: (AccelerationCard new) with: (AccelerationCard new) with: (SpeedUpCard new) with: (AccelerationCard new) with: (SpeedUpCard new) ).
	^deck.
]

{ #category : #creation }
BoardTests >> createStandardBoardFor: number [
	| effects |
	
	effects := EffectGenerator give: number for: (OrderedCollection  with: NoEffect  with: SpeedupEffect with: WormHoleBox with: MoonWalkEffect  with: AtomicBombEffect with: CardEffect) with: (OrderedCollection with: 0.38 with: 0.2 with: 0.2  with: 0.1 with: 0.02  with: 0.1).
	^effects.
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

    |  dice cards randomCards |

    dice := OrderedCollection with: (Die withSides: 3).
    randomCards :=OrderedCollection 
		with: (AccelerationCard new) 
		with: (CancellationCard new) 
		with: (OverloadCard new) 
		with: (RedoCard new) 
		with: (RepeatCard new) 
		with:(SpeedUpCard new).
	cards := DeckGenerator with: 2 for: randomCards .

    self should: [ PizzaGame withBoxes: OrderedCollection new players: (OrderedCollection with: #Margarita) dice: dice laps: 1 andDeck: cards.] raise: Error withMessage: 'Un juego no puede tener menos de 1 casillero.'.
		
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
	
	numberOfNoEffectBoxes := board count: [ :card | card isMemberOf: NoEffect ].
	numberOfSpeed := board  count: [ :card | card isMemberOf: SpeedupEffect ].
	numberOfWorm := board count: [ :card | card isMemberOf: WormHoleBox ].
	numberOfMoon := board count: [ :card | card isMemberOf: MoonWalkEffect ].
	numberOfAtomic := board  count: [ :card | card isMemberOf: AtomicBombEffect ].
	cantidadCardBox := board count: [ :card | card isMemberOf: CardEffect ].

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
	self should: [ boxGen := EffectGenerator give: 5000 for: (OrderedCollection  with: NoEffect  with: SpeedupEffect with: WormHoleBox  with: MoonWalkEffect with: AtomicBombEffect with: CardEffect) with: (OrderedCollection with: 0.38 with: 0.2 with: 0.2  with: 0.1 with: 0.02  with: 0.5).	] raise: Error withMessage: 'Las suma de probabilidades debe ser 1.'.
]

{ #category : #tests }
BoardTests >> testACardBoxGivesCards [

	| game dice ranking testPlayers boxes deck napolitanaHand |
	boxes := OrderedCollection
		         with: CardEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new.

	testPlayers := OrderedCollection with: #napolitana.
	deck := Deck withCards: (OrderedCollection
			         with: RepeatCard new
			         with: AccelerationCard new
			         with: SpeedUpCard new).
	dice := Beaker with:
		        (OrderedCollection with:
			         (LoadedDie withTosses: #( 1 ) andSides: 3)).
	game := PizzaGame
		        withBoxes: boxes
		        players: testPlayers
		        dice: dice
		        laps: 1
		        andDeck: deck.
	game playTurnForAllPlayers.
	napolitanaHand := game handOf: #napolitana.

	game
		player: #napolitana
		wantsToApplyCard: (napolitanaHand at: 3)
		to: #napolitana.
	game playTurnForAllPlayers.
	ranking := game ranking.

	self assert: ranking first location equals: 3
]

{ #category : #tests }
BoardTests >> testAMoonWalkBoxJumpsAPlayerBoxesBack [

	| boxes testPlayers dice game cards deck randomCards |
	boxes := OrderedCollection
		         with: NoEffect new
		         with: (MoonWalkEffect loadedWith: 1)
		         with: NoEffect
		         with: NoEffect.
	testPlayers := OrderedCollection with: #napolitana with: #hawaiana.
	dice := Beaker with:
		        (OrderedCollection with:
			         (LoadedDie withTosses: #( 2 ) andSides: 3)).
	randomCards := OrderedCollection
		               with: AccelerationCard new
		               with: CancellationCard new
		               with: OverloadCard new
		               with: RedoCard new
		               with: RepeatCard new
		               with: SpeedUpCard new.
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
	game playTurnForAllPlayers.

	self assert: game ranking second location equals: 1
]

{ #category : #tests }
BoardTests >> testANoEffectBoxHasNoEffects [

	| boxes testPlayers dice game positions cards deck randomCards |
	boxes := OrderedCollection
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new.
	testPlayers := OrderedCollection with: #napolitana.
	dice := Beaker with:
		        (OrderedCollection with:
			         (LoadedDie withTosses: #( 2 ) andSides: 3)).
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
	game playTurnForAllPlayers.
	positions := game ranking.

	self assert: positions first location equals: 2
]

{ #category : #tests }
BoardTests >> testASpeedupBoxJumpsYouFourBoxes [

	| game dice ranking testPlayers boxes cards deck randomCards |
	boxes := OrderedCollection
		         with: SpeedupEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new.

	testPlayers := OrderedCollection with: #napolitana.
	dice := Beaker with:
		        (OrderedCollection with:
			         (LoadedDie withTosses: #( 1 ) andSides: 3)).
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
	game playTurnForAllPlayers.
	ranking := game ranking.
	self assert: ranking first location equals: 5
]

{ #category : #tests }
BoardTests >> testAnAtomicBombBoxSendsEveryoneBackToZero [

	| game dice ranking testPlayers boxes cards deck randomCards |
	boxes := OrderedCollection
		         with: NoEffect new
		         with: NoEffect new
		         with: AtomicBombEffect new
		         with: NoEffect new
		         with: NoEffect new.

	testPlayers := OrderedCollection
		               with: #napolitana
		               with: #margarita
		               with: #hawaiana.
	dice := Beaker with:
		        (OrderedCollection with:
			         (LoadedDie withTosses: #( 4 ) andSides: 4)).
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
		        laps: 2
		        andDeck: deck.
	game playTurnForAllPlayers.
	game playTurnForAllPlayers.
	ranking := game ranking.
	self assert: ranking first location equals: 1.
	self assert: ranking second location equals: 4.
	self assert: ranking third location equals: 4
]

{ #category : #tests }
BoardTests >> testJailBox [

	| board testPlayers dice game cards rankingOne deck napolitanaHand |
	board := OrderedCollection
		         with: JailEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new.

	cards := OrderedCollection
		         with: LibertyCard new
		         with: OverloadCard new
		         with: LibertyCard new
		         with: OverloadCard new.

	deck := Deck withCards: cards.
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	dice := Beaker with: (OrderedCollection with:
			         (LoadedDie withTosses: #( 1 2 ) andSides: 3)).
	game := PizzaGame
		        withBoxes: board
		        players: testPlayers
		        dice: dice
		        laps: 1
		        andDeck: deck.
	napolitanaHand := game handOf: #napolitana.
	game playTurnForAllPlayers.
	game playTurnForAllPlayers.
	rankingOne := game ranking.

	self assert: rankingOne second location equals: 1.
	self assert: rankingOne first location equals: 4
]

{ #category : #tests }
BoardTests >> testJailBoxSetsYouFreeAfterYouReachTheMaxToss [

	| board testPlayers dice game cards rankingOne deck napolitanaHand |
	board := OrderedCollection
		         with: JailEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new.

	cards := OrderedCollection
		         with: LibertyCard new
		         with: OverloadCard new
		         with: LibertyCard new
		         with: OverloadCard new.

	deck := Deck withCards: cards.
	testPlayers := OrderedCollection with: #napolitana.
	dice := Beaker with: (OrderedCollection with:
			         (LoadedDie withTosses: #( 1 1 1 3 ) andSides: 3)).
	game := PizzaGame
		        withBoxes: board
		        players: testPlayers
		        dice: dice
		        laps: 1
		        andDeck: deck.
	napolitanaHand := game handOf: #napolitana.
	game playTurnForAllPlayers.
	game playTurnForAllPlayers.
	game playTurnForAllPlayers.
	game playTurnForAllPlayers.
	rankingOne := game ranking.

	self assert: rankingOne first location equals: 4.
]
