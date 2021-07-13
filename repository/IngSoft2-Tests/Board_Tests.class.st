Class {
	#name : #'Board_Tests',
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
Board_Tests >> should: block raise: kindOfError withMessage: errorMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : #tests }
Board_Tests >> testABoardShouldHaveMoreThanCeroDie [

	|  block someBoxes testPlayers cards|

	someBoxes:= BoxGenerator give: 20 andProbabilitiesForNoEffectBox: 0.38 andSpeed: 0.2 andWormm: 0.2 andMoon: 0.1 andAtomic: 0.02 andCardBox: 0.1.
	testPlayers:=(OrderedCollection with: #hawaiana).
	cards := Deck withCards: (DeckGenerator with: 2).

	block:=[PizzaGame
		withBoxes: someBoxes
		players: testPlayers
		dice: OrderedCollection new
		laps: 1
		andDeck: cards.
		].
		
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 dado.'.
]

{ #category : #tests }
Board_Tests >> testABoardShouldHaveMoreThanCeroPlayers [

	|  myDie block myBoxes cards|
	
	myDie := OrderedCollection with: (Die withSides: 3).
	myBoxes := OrderedCollection with: (BoxGenerator give: 20 andProbabilitiesForNoEffectBox: 0.38 andSpeed: 0.2 andWormm: 0.2 andMoon: 0.1 andAtomic: 0.02 andCardBox: 0.1).
	cards := Deck withCards: (DeckGenerator with: 2).

	block:= [ PizzaGame
		withBoxes: myBoxes
		players: OrderedCollection new
		dice: myDie
		laps: 1
		andDeck: cards.
		].
	
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 jugador.'.
		
]

{ #category : #tests }
Board_Tests >> testABoardShouldHaveMoreThanZeroBoxes [

    |  myDie block cards|

    myDie := OrderedCollection with: (Die withSides: 3).
    cards := Deck withCards: (DeckGenerator with: 2).

    block:= [ PizzaGame
        withBoxes: OrderedCollection new
        players: (OrderedCollection with: #Margarita)
        dice: myDie
        laps: 1
        andDeck: cards.
        ].

    self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 casillero.'.
		
]

{ #category : #tests }
Board_Tests >> testABoxGeneratorGivesBoxesWithProbabilities [

	| someBoxes cantidadDeNoEffectBoxes cantidadDeSpeed cantidadDeWorm cantidadDeMoon cantidadDeAtomic cantidadCardBox |

	someBoxes:= BoxGenerator give: 5000 andProbabilitiesForNoEffectBox: 0.38 andSpeed: 0.2 andWormm: 0.2 andMoon: 0.1 andAtomic: 0.02 andCardBox: 0.1.
	
	cantidadDeNoEffectBoxes := someBoxes count: [ :card | card isMemberOf: NoEffectBox ].
	cantidadDeSpeed := someBoxes count: [ :card | card isMemberOf: SpeedupBox ].
	cantidadDeWorm := someBoxes count: [ :card | card isMemberOf: WormHoleBox ].
	cantidadDeMoon := someBoxes count: [ :card | card isMemberOf: MoonWalkBox ].
	cantidadDeAtomic := someBoxes count: [ :card | card isMemberOf: AtomicBombBox ].
	cantidadCardBox := someBoxes count: [ :card | card isMemberOf: CardBox ].

	self assert: (cantidadDeNoEffectBoxes between: 1800 and: 2000).	
	self assert: (cantidadDeSpeed between: 900 and: 1000).
	self assert: (cantidadDeWorm between: 900 and: 1000).	
	self assert: (cantidadDeMoon between: 400 and: 500).
	self assert: (cantidadDeAtomic between: 50 and: 150).	
	self assert: (cantidadCardBox between: 400 and: 500).
]

{ #category : #tests }
Board_Tests >> testABoxGeneratorShouldNotGiveBoxesIfProbabilitiesSumMoreThanOne [

	| block|

	block:=[ BoxGenerator give: 20 andProbabilitiesForNoEffectBox: 0.48 andSpeed: 0.2 andWormm: 0.2 andMoon: 0.1 andAtomic: 0.02 andCardBox: 0.1.	].
		
	self should: block raise: Error withMessage: 'Las suma de probabilidades debe ser mayor a 1.'.
]

{ #category : #tests }
Board_Tests >> testACardBoxGivesCards [
	| game myDie ranking testPlayers myBoxes deck napolitanaHand |
	"cardBox := CardBoxLoaded
		loadedWith: (OrderedCollection with: (SpeedUpCard of: #napolitana on: ''))."
		
	myBoxes := OrderedCollection
		with: CardBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new.
	
	testPlayers := OrderedCollection with: #napolitana.
	deck := Deck withCards: (OrderedCollection with: (RepeatCard new) with: (AccelerationCard new) with: (SpeedUpCard new)).
		
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
		
	game playTurnForAllPlayers.
	napolitanaHand := game playerHand: #napolitana.
	game player: #napolitana wantsToApplyCard: (napolitanaHand at: 3) to: #napolitana.
	game playTurnForAllPlayers.
	ranking := game ranking.
	
	self assert: (ranking first) absoluteLocation equals: 3.
]

{ #category : #tests }
Board_Tests >> testAMoonWalkBoxJumpsAPlayerBoxesBack [
	
	| myBoxes testPlayers myDie game cards deck |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: (MoonWalkBox loadedWith: 1) 
		with: NoEffectBox with: NoEffectBox.
	testPlayers := OrderedCollection with: #napolitana with: #hawaiana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	cards := DeckGenerator with: 100.
	deck := Deck withCards: cards. 
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	game playTurnForAllPlayers.

	self assert: (game ranking second) absoluteLocation equals: 1.
	
]

{ #category : #tests }
Board_Tests >> testANoEffectBoxHasNoEffects [
	
	| myBoxes  testPlayers myDie game positions cards deck |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new.
	testPlayers := OrderedCollection with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	cards := DeckGenerator with: 100.
	deck := Deck withCards: cards. 
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	game playTurnForAllPlayers.
	positions := game ranking.

	self assert: (positions at:1)absoluteLocation equals: 2.
	
]

{ #category : #tests }
Board_Tests >> testASpeedupBoxJumpsYouFourBoxes [
	
	| game myDie ranking testPlayers myBoxes cards deck |
	myBoxes := OrderedCollection
		with: SpeedupBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new
		with: NoEffectBox new.

	testPlayers := OrderedCollection with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	cards := DeckGenerator with: 100.
	deck := Deck withCards: cards. 
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	game playTurnForAllPlayers.
	ranking := game ranking.
	self assert: (ranking at: 1) absoluteLocation equals: 5.

]

{ #category : #tests }
Board_Tests >> testAnAtomicBombBoxSendsEveryoneBackToZero [
	
	| game myDie ranking testPlayers myBoxes cards deck |
	myBoxes := OrderedCollection
		with: NoEffectBox new
		with: NoEffectBox new
		with: AtomicBombBox new
		with: NoEffectBox new
		with: NoEffectBox new.
		
	testPlayers := OrderedCollection
		with: #napolitana
		with: #margarita
		with: #hawaiana.
	myDie := OrderedCollection
		with: (LoadedDice withTosses: #(4)).
	cards := DeckGenerator with: 100.
	deck := Deck withCards: cards. 
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 2 andDeck: deck.
	game playTurnForAllPlayers.
	game playTurnForAllPlayers.
	ranking := game ranking.
	self assert: (ranking first) absoluteLocation equals: 6.
	self assert: (ranking second) absoluteLocation equals: 4.
	self assert: (ranking third) absoluteLocation equals: 4.
	
]
