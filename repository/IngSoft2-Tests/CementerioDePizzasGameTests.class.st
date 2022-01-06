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
	
	| cards numberOfOverloads numberOfSpeedUps numberOfAccelerationCard numberOfCancellationCard numberOfRedoCard numberOfRepeatCart |
	cards := DeckGenerator with: 5000.
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

| game dice positions napolitana boxes testPlayers cards deck |
	
	napolitana:= #napolitana.
	
	dice := OrderedCollection with: (Die withSides: 5).
	boxes:= BoxGenerator give: 5 andProbabilitiesForNoEffectBox: 0.38 andSpeed: 0.2 andWormm: 0.2 andMoon: 0.1 andAtomic: 0.02 andCardBox: 0.1.
	
	testPlayers:= OrderedCollection with: napolitana.
	
	cards := DeckGenerator with: 0.
	deck := Deck withCards: cards. 

	self should: [PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck] 
				raise: Error withMessage: 'Un juego no puede tener menos de 2 cartas por jugador.'
	
	
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testADiceShouldHaveAtLeastOneSide [
	
	self should: [Die withSides: 0.] raise: Error withMessage: 'Un dado no puede tener menos de 3 cara(s).'.
]

{ #category : #tests }
CementerioDePizzasGameTests >> testAGameShouldHaveAtLeastOneLap [

	| dice players cards boxes|
	
	dice := OrderedCollection with: (Die withSides: 3).
	boxes:= BoxGenerator give:10 andProbabilitiesForNoEffectBox: 0.38 andSpeed: 0.2 andWormm: 0.2 andMoon: 0.1 andAtomic: 0.02 andCardBox: 0.1.
	players:= (OrderedCollection with: #hawaiana).
	cards := Deck withCards: (DeckGenerator with: 2).
	self should: [PizzaGame withBoxes: boxes players: players dice: dice laps: 0 andDeck: cards] raise: Error withMessage: 'Un juego no puede tener menos de 1 vuelta.'.
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testCreateAGameMultiPlayer [
	| game dice napolitana ranking margarita testPlayers mozzarella boxes cards deck |
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
	dice := OrderedCollection
		with: (LoadedDice withTosses: #(4 4 4 2 2 2 2 2 2 6 6 6 2 2 2)).
	cards := DeckGenerator with: 100.
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
	
	| game dice positions napolitana boxes testPlayers cards deck |
	
	napolitana:= #napolitana.
	
	dice := OrderedCollection with: (Die withSides: 5).
	boxes:= BoxGenerator give: 5 andProbabilitiesForNoEffectBox: 0.38 andSpeed: 0.2 andWormm: 0.2 andMoon: 0.1 andAtomic: 0.02 andCardBox: 0.1.
	
	testPlayers:= OrderedCollection with: napolitana.
	
	cards := DeckGenerator with: 100.
	deck := Deck withCards: cards. 
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	
	game play.
	positions := game ranking.
	self assert: (game isFinished).
	self assert: (positions at:1) player identicalTo: napolitana.
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testCreateARandomMultiPlayerGame [
	
	| game dice napolitana margarita testPlayers mozzarella boxes cards deck |
	
	napolitana:= #napolitana.	
	margarita:= #margarita.
	mozzarella:= #mozzarella.
	
	boxes:= BoxGenerator give: 40 andProbabilitiesForNoEffectBox: 0.38 andSpeed: 0.2 andWormm: 0.2 andMoon: 0.1 andAtomic: 0.02 andCardBox: 0.1.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	dice := OrderedCollection with: (Die withSides: 5) with: (Die withSides: 4).
	cards := DeckGenerator with: 100.
	deck := Deck withCards: cards. 
	game:= PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	
	game play.
	
	self assert: (game isFinished).
	
]

{ #category : #tests }
CementerioDePizzasGameTests >> testYouShouldBeAbleToGetYourLapAndLocation [
	
	| boxes testPlayers myDie game cards deck |

    boxes := OrderedCollection 
        with: NoEffectBox new 
        with: NoEffectBox new
        with: NoEffectBox new 
        with: NoEffectBox new.

   cards := DeckGenerator with: 50.
	deck := Deck withCards: cards. 
   testPlayers := OrderedCollection with:#margarita with: #napolitana.
   myDie := OrderedCollection with: (LoadedDice withTosses: #(6)).
   game := PizzaGame withBoxes: boxes players: testPlayers dice: myDie laps: 2 andDeck: deck.
	game playNextTurn.
	
	self assert: ((game ranking) first) lap equals: 1.
	self assert: ((game ranking) second) location equals: 0.
	 
]
