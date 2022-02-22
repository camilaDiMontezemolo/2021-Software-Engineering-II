Class {
	#name : #CementerioDePizzasGameTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #creation }
CementerioDePizzasGameTests >> createEffectTestingDeck [
		| deck |
		deck := Deck withCards: (OrderedCollection with: (RepeatCard new) with: (AccelerationCard new) with: (AccelerationCard new) with: (SpeedUpCard new) with: (AccelerationCard new) with: (SpeedUpCard new) ).
	^deck.
]

{ #category : #creation }
CementerioDePizzasGameTests >> createStandardCardDistribution: number [

	| cards|
	cards := ProbabilityGenerator
		         give: number
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
				          with: 0.165)
		         usingFiller: SpeedUpCard.
	^cards.
]

{ #category : #creation }
CementerioDePizzasGameTests >> createStandardEffectDistributionFor: number [

	| boxes |
	boxes := ProbabilityGenerator
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
	^ boxes
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
CementerioDePizzasGameTests >> testABoardOnAGameShouldHaveMoreThanZeroEffects [

    |  dice deck |

   dice := OrderedCollection with: (Die withSides: 3).
	deck := Deck withCards: (OrderedCollection
			         with: RepeatCard new
			         with: AccelerationCard new
						with: SpeedUpCard new
			         with: SpeedUpCard new
						with: SpeedUpCard new
			         with: SpeedUpCard new).
	
    

    self should: [ PizzaGame withBoxes: OrderedCollection new players: (OrderedCollection with: #Margarita) dice: dice laps: 1 andDeck: deck.] raise: Error withMessage: 'Un juego no puede tener menos de 1 casillero.'.
		
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
	board := self createStandardEffectDistributionFor: 5.
	
	testPlayers:= OrderedCollection with: napolitana.
	deck := Deck withCards: (self createStandardCardDistribution: 0).
	self should: [PizzaGame withBoxes: board effects players: testPlayers dice: dice laps: 1 andDeck: deck] raise: Error withMessage: 'Un juego no puede tener menos de 2 cartas por jugador.'
]

{ #category : #tests }
CementerioDePizzasGameTests >> testAGameShouldHaveAtLeastOneLap [

	| dice players board deck |
	
	dice := OrderedCollection with: (Die withSides: 3).
	board := self createStandardEffectDistributionFor: 10.
	players:= (OrderedCollection with: #hawaiana).
	deck := self createStandardCardDistribution: 10.
	self should: [PizzaGame withBoxes: board players: players dice: dice laps: 0 andDeck: deck] raise: Error withMessage: 'Un juego no puede tener menos de 1 vuelta.'.
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testAGameShouldHaveMoreThanZeroDie [

	| someBoxes testPlayers |

	someBoxes := self createStandardEffectDistributionFor: 5000.
	testPlayers:=(OrderedCollection with: #hawaiana).
		
	self should: [PizzaGame withBoxes: someBoxes players: testPlayers dice: OrderedCollection new laps: 1 andDeck: self createEffectTestingDeck.] raise: Error withMessage: 'Un juego no puede tener menos de un dado'
]

{ #category : #tests }
CementerioDePizzasGameTests >> testAGameShouldHaveMoreThanZeroPlayers [

	|  dice someBoxes |
	
	dice := OrderedCollection with: (Die withSides: 3).
	someBoxes := self createStandardEffectDistributionFor: 5.
	self should: [ PizzaGame withBoxes: someBoxes players: OrderedCollection new dice: dice laps: 1 andDeck: self createEffectTestingDeck.] raise: Error withMessage: 'Un juego no puede tener menos de 1 jugador.'.
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testCreateAGameMultiPlayer [

	| game dice napolitana ranking margarita testPlayers mozzarella boxes deck |
	napolitana := #napolitana.
	margarita := #margarita.
	mozzarella := #mozzarella.
	boxes := OrderedCollection
		         with: NoEffect new
		         with: NoEffect new
		         with: WormHoleEffect new
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
	board := self createStandardEffectDistributionFor: 5.
	testPlayers:= OrderedCollection with: napolitana.
	deck := Deck withCards: ((self createStandardCardDistribution: 10) effects).
	game := PizzaGame withBoxes: board effects players: testPlayers dice: dice laps: 1 andDeck: deck.
	
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
	
	board := self createStandardEffectDistributionFor: 40.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	dice := Beaker with: (OrderedCollection with: (Die withSides: 5) with: (Die withSides: 4)).
	deck := Deck withCards: ((self createStandardCardDistribution: 10) effects).
	game:= PizzaGame withBoxes: board effects players: testPlayers dice: dice laps: 1 andDeck: deck.
	
	game play.
	
	self assert: (game isFinished).
]

{ #category : #tests }
CementerioDePizzasGameTests >> testYouShouldBeAbleToGetYourLapAndLocation [

	| boxes testPlayers dice game deck |
	boxes := OrderedCollection
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new
		         with: NoEffect new.

	deck := Deck withCards: (OrderedCollection
			         with: RepeatCard new
			         with: AccelerationCard new
			         with: SpeedUpCard new
						with: SpeedPlusCard new).
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
