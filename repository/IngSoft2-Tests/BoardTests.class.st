Class {
	#name : #BoardTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #creation }
BoardTests >> createStandardEffectDistributionFor: number [

	| effects |
	effects := ProbabilityGenerator
		           give: number
		           for: (OrderedCollection
				            with: NoEffect
				            with: SpeedupEffect
				            with: WormHoleEffect
				            with: MoonWalkEffect
				            with: AtomicBombEffect
				            with: CardEffect)
		           with: (OrderedCollection
				            with: 0.38
				            with: 0.2
				            with: 0.2
				            with: 0.1
				            with: 0.02
				            with: 0.1)
		           usingFiller: NoEffect.
	^ effects
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
BoardTests >> testABoxGeneratorGivesBoxesWithProbabilities [

	| numberOfNoEffectBoxes numberOfSpeed numberOfWorm numberOfMoon numberOfAtomic cantidadCardBox effects|
	
	effects := self createStandardEffectDistributionFor: 5000.
	
	numberOfNoEffectBoxes := effects proportionOf: NoEffect.
	numberOfSpeed := effects  proportionOf: SpeedupEffect.
	numberOfWorm := effects proportionOf: WormHoleEffect.
	numberOfMoon := effects proportionOf: MoonWalkEffect.
	numberOfAtomic := effects proportionOf: AtomicBombEffect.
	cantidadCardBox := effects proportionOf: CardEffect.

	self assert: (numberOfNoEffectBoxes between: 1800 and: 2000).	
	self assert: (numberOfSpeed between: 900 and: 1000).
	self assert: (numberOfWorm between: 900 and: 1000).	
	self assert: (numberOfMoon between: 400 and: 500).
	self assert: (numberOfAtomic between: 50 and: 150).	
	self assert: (cantidadCardBox between: 400 and: 500).
	self assert: effects size equals: 5000.
]

{ #category : #tests }
BoardTests >> testABoxGeneratorShouldNotGiveBoxesIfProbabilitiesSumMoreThanOne [

	| boxGen |
	self
		should: [ 
			boxGen := ProbabilityGenerator
				          give: 5000
				          for: (OrderedCollection
						           with: NoEffect
						           with: SpeedupEffect
						           with: WormHoleEffect
						           with: MoonWalkEffect
						           with: AtomicBombEffect
						           with: CardEffect)
				          with: (OrderedCollection
						           with: 0.38
						           with: 0.2
						           with: 0.2
						           with: 0.1
						           with: 0.02
						           with: 0.5)
				          usingFiller: NoEffect ]
		raise: Error
		withMessage: 'Las suma de probabilidades debe ser 1.'
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

	| boxes testPlayers dice game deck |
	boxes := OrderedCollection
		         with: NoEffect new
		         with: (MoonWalkEffect loadedWith: 1)
		         with: NoEffect
		         with: NoEffect.
	testPlayers := OrderedCollection with: #napolitana with: #hawaiana.
	dice := Beaker with:
		        (OrderedCollection with:
			         (LoadedDie withTosses: #( 2 ) andSides: 3)).
	
	deck := Deck withCards: (OrderedCollection
			         with: RepeatCard new
			         with: AccelerationCard new
						with: SpeedUpCard new
			         with: SpeedUpCard new).
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

	| boxes testPlayers dice game positions deck |
	boxes := OrderedCollection
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new.
	testPlayers := OrderedCollection with: #napolitana.
	dice := Beaker with:
		        (OrderedCollection with:
			         (LoadedDie withTosses: #( 2 ) andSides: 3)).

	deck := Deck withCards: (OrderedCollection
			         with: RepeatCard new
			         with: AccelerationCard new
						with: SpeedUpCard new
			         with: SpeedUpCard new).
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

	| game dice ranking testPlayers boxes deck |
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
	deck := Deck withCards: (OrderedCollection
			         with: RepeatCard new
			         with: AccelerationCard new
						with: SpeedUpCard new
			         with: SpeedUpCard new).
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

	| game dice ranking testPlayers boxes deck|
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

	deck := Deck withCards: (OrderedCollection
			         with: RepeatCard new
			         with: AccelerationCard new
						with: SpeedUpCard new
			         with: SpeedUpCard new
						with: SpeedUpCard new
			         with: SpeedUpCard new).
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

{ #category : #tests }
BoardTests >> testStayInJailBoxForTwoRounds [

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
