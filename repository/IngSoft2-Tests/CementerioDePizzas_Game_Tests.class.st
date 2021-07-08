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
CementerioDePizzas_Game_Tests >> testABoardShouldHaveMoreThanCeroDie [

	|  block someBoxes testPlayers cards|

	someBoxes:= BoxGenerator give: 20.
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
CementerioDePizzas_Game_Tests >> testABoardShouldHaveMoreThanCeroPlayers [

	|  myDie block myBoxes cards|
	
	myDie := OrderedCollection with: (Die withSides: 3).
	myBoxes := OrderedCollection with: (BoxGenerator give: 10).
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
CementerioDePizzas_Game_Tests >> testABoardShouldHaveMoreThanZeroBoxes [

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
CementerioDePizzas_Game_Tests >> testACardBoxGivesCards [
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
	
	self assert: (ranking at: 1) absoluteLocation equals: 3.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testACardCanNotBeUsedOutsideYourTurn [
	
	| myBoxes testPlayers myDie game cards block napolitanaCards |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := Deck withCards: (OrderedCollection
	with: (AccelerationCard new)
	with: (AccelerationCard new)
	with: (AccelerationCard new)
	with: (AccelerationCard new)
	with: (AccelerationCard new)
	).
	
	testPlayers := OrderedCollection with:#margarita with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame 	withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: cards.
	game playTurnForAllPlayers.
	napolitanaCards := game playerHand: #napolitana.
	block:= [game player: #napolitana wantsToApplyCard: (napolitanaCards first) to: testPlayers.].
	self should: block raise: Error withMessage: 'Un jugador no puede tirar una carta fuera de su turno.'
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testACardGeneratorGivesACollectionOfCards [
	
	| cards |

	
	cards := DeckGenerator with: 5000.
	
	self assert: (cards size) equals: 5000.
	
	
	 
	
	
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
CementerioDePizzas_Game_Tests >> testAMoonWalkBoxJumpsAPlayerBoxesBack [
	
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
CementerioDePizzas_Game_Tests >> testANoEffectBoxHasNoEffects [
	
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
CementerioDePizzas_Game_Tests >> testASpeedupBoxJumpsYouFourBoxes [
	
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
CementerioDePizzas_Game_Tests >> testAnAtomicBombBoxSendsEveryoneBackToZero [
	
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

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnASpeedupCard [
	
	| myBoxes testPlayers myDie game cards deck napolitanaHand margaritaHand usedCards |

	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: (CancellationCard new)
		with: (SpeedUpCard new)
		with: (SpeedUpCard new)
		with: (OverloadCard new).
		
	deck := Deck withCards: cards. 
		
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	game playNextTurn.
	napolitanaHand := game playerHand: #napolitana.
	margaritaHand := game playerHand: #margarita.
	game player: #margarita wantsToApplyCard: (margaritaHand at: 1) to: #margarita.
	usedCards := game usedCards.
	game player: #napolitana wantsToApplyCard: (napolitanaHand at: 1) to: (usedCards first).
	game playNextTurn.
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	
	self assert: cards size equals: 0.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnAnAccelerationCard [
	
	| myBoxes testPlayers myDie game cards deck napolitanaHand margaritaHand usedCards |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: CancellationCard new
		with: OverloadCard new
		with: AccelerationCard new
		with: OverloadCard new.
	deck := Deck withCards: cards. 
		
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	game playNextTurn.
	margaritaHand := game playerHand: #margarita.
	game player: #margarita wantsToApplyCard: (margaritaHand first) to: testPlayers.
	usedCards := game usedCards.
	napolitanaHand := game playerHand: #napolitana.
	game applyCard: (napolitanaHand first) to: (usedCards first). 
	game playNextTurn.
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	
	self assert: cards size equals: 0.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnAnInactiveCardRaiseError [
	
	| myBoxes testPlayers myDie game cards block deck napolitanaHand margaritaHand |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
	cards := OrderedCollection
		with: CancellationCard new
		with: SpeedUpCard new
		with: SpeedUpCard new
		with: OverloadCard new.
	deck := Deck withCards: cards. 	
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	game playNextTurn.
	napolitanaHand := game playerHand: #napolitana.
	margaritaHand := game playerHand: #margarita.

	block:=[game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: (margaritaHand first).].
	self should: block raise: Error withMessage: 'No se puede cancelar una carta inactiva.'

	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnAnInstantCardRaiseAnError [
	
	| myBoxes testPlayers myDie game cards emptyCard block deck napolitanaCards margaritaCards |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
	emptyCard := EmptyCard new.
	cards := OrderedCollection
		with: CancellationCard new
		with: OverloadCard new
		with: CancellationCard new
		with: OverloadCard new.
	deck := Deck withCards: cards. 	
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	napolitanaCards := game playerHand: #napolitana.
	margaritaCards := game playerHand: #margarita.
	 
	block:=[game player: #napolitana wantsToApplyCard: (napolitanaCards first) to: (margaritaCards first).].
	self should: block raise: Error withMessage: 'No se puede cancelar una carta instantanea.'

	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseACancelationCardOnAnOverloadCard [
	
	| myBoxes testPlayers myDie game cards emptyCard deck margaritaHand napolitanaHand usedCards |
	
	emptyCard := EmptyCard new.

	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: CancellationCard new
		with: OverloadCard new
		with: OverloadCard new
		with: OverloadCard new.
	deck := Deck withCards: cards. 	
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	game playNextTurn.
	margaritaHand := game playerHand: #margarita.
	napolitanaHand := game playerHand: #napolitana.
	game applyCard: (margaritaHand first) to: #margarita.
	usedCards := game usedCards.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: (usedCards first). 
	game playNextTurn.
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	
	self assert: cards size equals: 0.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseARedoCard [
	
	| myBoxes testPlayers myDie game cards deck margaritaHand napolitanaHand |

    myBoxes := OrderedCollection 
        with: NoEffectBox new 
        with: NoEffectBox new
        with: NoEffectBox new 
        with: NoEffectBox new.

    cards := OrderedCollection
		with: SpeedUpCard new
		with: OverloadCard new
		with: RedoCard new
		with: OverloadCard new.
	deck := Deck withCards: cards. 
   testPlayers := OrderedCollection with:#margarita with: #napolitana.
   myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
   game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	margaritaHand := game playerHand: #margarita.
	napolitanaHand := game playerHand: #napolitana.
	game player: #margarita wantsToApplyCard: (margaritaHand first) to: #margarita.
   game playNextTurn.

	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #napolitana.
	game playNextTurn.
	
	self assert: ((game ranking) first) absoluteLocation equals: 3.
	self assert: ((game ranking) second) absoluteLocation equals: 3.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseARedoCardOverCancelation [
	
	| myBoxes testPlayers myDie game cards deck margaritaHand napolitanaHand usedCards |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
	
	cards := OrderedCollection
		with: SpeedUpCard new
		with: SpeedUpCard new
		with: CancellationCard new
		with: RedoCard new.
	deck := Deck withCards: cards. 
	testPlayers := OrderedCollection with:#margarita with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 10 andDeck: deck.
	margaritaHand := game playerHand: #margarita.
	napolitanaHand := game playerHand: #napolitana.
	game player: #margarita wantsToApplyCard: (margaritaHand first) to: #margarita.
	game player: #margarita wantsToApplyCard: (margaritaHand second) to: #margarita.
	usedCards := game usedCards.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: (usedCards second).
	game player: #napolitana wantsToApplyCard: (napolitanaHand second) to: (usedCards first).
	game playTurnForAllPlayers.
	
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseARepeatCard [
	
	| myBoxes testPlayers myDie game cards deck napolitanaHand |
	
	myBoxes := OrderedCollection 
		with: SpeedupBox new
		with: NoEffectBox new 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: OverloadCard new
		with: OverloadCard new
		with: RepeatCard new
		with: OverloadCard new.
	deck := Deck withCards: cards. 	
	testPlayers := OrderedCollection with:#margarita with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	game playNextTurn.
	napolitanaHand := game playerHand: #napolitana.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #napolitana.
	
	self assert: ((game ranking) first) absoluteLocation equals: 5.
	self assert: ((game ranking) second) absoluteLocation equals: 4.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseARepeatCardWhenNoDieWasRolledYet [
	
	| myBoxes testPlayers myDie game cards deck margaritaHand |
	
	myBoxes := OrderedCollection 
		with: SpeedupBox new
		with: NoEffectBox new 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: RepeatCard new
		with: OverloadCard new
		with: OverloadCard new
		with: OverloadCard new.
	deck := Deck withCards: cards. 
	testPlayers := OrderedCollection with:#margarita with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	margaritaHand := game playerHand: #margarita.
	game player: #margarita wantsToApplyCard: (margaritaHand first) to: #margarita.
	
	self assert: ((game ranking) first) absoluteLocation equals: 0.
	self assert: ((game ranking) second) absoluteLocation equals: 0.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseASpeedUpCard [
	
	| myBoxes testPlayers myDie game cards rankingOne deck napolitanaHand |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: SpeedUpCard new
		with: OverloadCard new.
	deck := Deck withCards: cards. 	
	testPlayers := OrderedCollection with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	napolitanaHand := game playerHand: #napolitana.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #napolitana.
	game playTurnForAllPlayers.
	rankingOne:= game ranking.
	
	self assert: (rankingOne first) absoluteLocation equals: 3.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseASpeedUpCardOnTwoRounds [
	
	| myBoxes testPlayers myDie game cards rankingTwo deck napolitanaHand |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: SpeedUpCard new
		with: OverloadCard new.
	deck := Deck withCards: cards. 
	testPlayers := OrderedCollection with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	napolitanaHand := game playerHand: #napolitana.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #napolitana.
	game playTurnForAllPlayers.
	game playTurnForAllPlayers.
	rankingTwo:= game ranking.
	
	self assert: (rankingTwo first) absoluteLocation equals: 6.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseAnAccelerationCard [
	
	| myBoxes testPlayers myDie game cards deck |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := Deck withCards: (OrderedCollection
	with: (AccelerationCard of:#napolitana on:'')
	).
	deck := Deck withCards: cards. 	
	testPlayers := OrderedCollection with:#napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	game applyCard:(cards at:1) to: testPlayers.
	game playTurnForAllPlayers.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	
	game playTurnForAllPlayers.
	self assert: ((game ranking) first) absoluteLocation equals: 4.
	self assert: ((game ranking) second) absoluteLocation equals: 4.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseAnOverloadCard [
	
	| myBoxes testPlayers myDie game cards deck margaritaHand |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection 
		with: OverloadCard new
		with: OverloadCard new
		with: OverloadCard new
		with: OverloadCard new.
	deck := Deck withCards: cards. 
	testPlayers := OrderedCollection with: #margarita with: #napolitana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	margaritaHand := game playerHand: #margarita.
	game player: #margarita wantsToApplyCard: (margaritaHand first) to: #napolitana.
	game playNextTurn.
	game playNextTurn.
	self assert: ((game ranking) second) absoluteLocation equals: 0.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	 
	
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> testUseAnOverloadCardAndEndUpWithNegativeNumbers [
	
	| myBoxes testPlayers myDie game cards deck napolitanaHand |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: OverloadCard new
		with: OverloadCard new
		with: OverloadCard new
		with: OverloadCard new.
	deck := Deck withCards: cards. 	
	testPlayers := OrderedCollection with: #napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	napolitanaHand := game playerHand: #napolitana.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #napolitana.
	game playNextTurn.
	game playNextTurn.
	self assert: ((game ranking) second) absoluteLocation equals: -1.
	self assert: ((game ranking) first) absoluteLocation equals: 1.
	 
	
	
]
