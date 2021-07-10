Class {
	#name : #'CementerioDePizzas_Game_Tests',
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CementerioDePizzas_Game_Tests >> should: block raise: kindOfError withMessage: errorMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testACardGeneratorGivesACollectionOfCardsWithProbability [
	
	| cards cantidadDeOverloads cantidadDeSpeedUps cantidadDeAccelerationCard cantidadDeCancellationCard cantidadDeRedoCard cantidadDeRepeatCart |
	cards := DeckGenerator with: 5000.
	cantidadDeOverloads := cards count: [ :card | card isMemberOf: OverloadCard  ].
	cantidadDeCancellationCard := cards count: [ :card | card isMemberOf: CancellationCard ].
	cantidadDeSpeedUps := cards count: [ :card | card isMemberOf: SpeedUpCard ].
	cantidadDeRepeatCart := cards count: [ :card | card isMemberOf: RepeatCard ].
	cantidadDeAccelerationCard := cards count: [ :card | card isMemberOf: AccelerationCard ].
	cantidadDeRedoCard := cards count: [ :card | card isMemberOf: RedoCard ].
	
	self assert: (cantidadDeOverloads between: 700 and: 900).	
	self assert: (cantidadDeCancellationCard between: 700 and: 900).
	self assert: (cantidadDeRepeatCart between: 700 and: 900).
	self assert: (cantidadDeAccelerationCard between: 700 and: 900).
	self assert: (cantidadDeRedoCard between: 700 and: 900).
	self assert: (cantidadDeSpeedUps between: 700 and: 900).
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testACardGeneratorShouldntBeAbleToGiveZeroCards [
	
	| block |
	block:=[DeckGenerator with: 0.].

	self should: block raise: Error withMessage: 'Un deck no puede tener menos de 1 carta.'
	
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testADiceShouldHaveAtLeastOneSide [
	| block |
	
	block:= [Die withSides: 0.].
	self should: block raise: Error withMessage: 'Un dado no puede tener menos de 3 cara(s).'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testAGameShouldHaveAtLeastOneLap [

	| myDie myPlayers block cards myBoxes|
	
	myDie := OrderedCollection with: (Die withSides: 3).
	myBoxes:= BoxGenerator give: 10.
	myPlayers:= (OrderedCollection with: #hawaiana).
	cards := Deck withCards: (DeckGenerator with: 2).
	block:=[PizzaGame withBoxes: myBoxes players: myPlayers dice: myDie laps: 0 andDeck: cards].
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 vuelta.'.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testCreateAGameMultiPlayer [
	| game myDie napolitana ranking margarita testPlayers mozzarella myBoxes cards deck |
	napolitana := #napolitana.
	margarita := #margarita.
	mozzarella := #mozzarella.
	myBoxes := OrderedCollection
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
	myDie := OrderedCollection
		with: (LoadedDice withTosses: #(4 4 4 2 2 2 2 2 2 6 6 6 2 2 2)).
	cards := DeckGenerator with: 100.
	deck := Deck withCards: cards. 
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	game play.
	ranking := game ranking.
	self assert: game isFinished.
	self assert: game firstPlace player identicalTo: napolitana.
	self assert: (ranking at: 1) player identicalTo: napolitana.
	self assert: (ranking at: 2) player identicalTo: mozzarella.
	self assert: (ranking at: 3) player identicalTo: margarita
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testCreateAGameSinglePlayer [
	
	| game myDie positions napolitana myBoxes testPlayers cards deck |
	
	napolitana:= #napolitana.
	
	myDie := OrderedCollection with: (Die withSides: 5).
	myBoxes:= BoxGenerator give: 5.
	
	testPlayers:= OrderedCollection with: napolitana.
	
	cards := DeckGenerator with: 100.
	deck := Deck withCards: cards. 
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	
	game play.
	positions := game ranking.
	self assert: (game isFinished).
	self assert: (positions at:1) player identicalTo: napolitana.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testCreateARandomMultiPlayerGame [
	
	| game myDie napolitana margarita testPlayers mozzarella myBoxes cards deck |
	
	napolitana:= #napolitana.	
	margarita:= #margarita.
	mozzarella:= #mozzarella.
	
	myBoxes:= BoxGenerator give: 40.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	myDie := OrderedCollection with: (Die withSides: 5) with: (Die withSides: 4).
	cards := DeckGenerator with: 100.
	deck := Deck withCards: cards. 
	game:= PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	
	game play.
	
	self assert: (game isFinished).
	
]
