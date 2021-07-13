Class {
	#name : #'Cards_Tests',
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
Cards_Tests >> should: block raise: kindOfError withMessage: errorMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : #tests }
Cards_Tests >> testACardCanNotBeUsedOutsideYourTurn [
	
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
Cards_Tests >> testAPlayerOutsideOfTheGameCanNotUseAnInstantCard [
	
	| myBoxes testPlayers myDie game cards deck napolitanaHand margaritaHand usedCards block |

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

	block:= [game player: #ravioles wantsToApplyCard: (napolitanaHand at: 1) to: (usedCards first).].
	self should: block raise: Error withMessage: 'Esta persona no es un jugador del juego.'.
]

{ #category : #tests }
Cards_Tests >> testAccelerationCardMustBeUsedAgainstAllPlayers [
	
	| myBoxes testPlayers myDie game cards deck napolitanaHand block |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
	with: AccelerationCard new
	with: OverloadCard new
	with: OverloadCard new
	with: OverloadCard new
	with: OverloadCard new
	with: OverloadCard new.
	
	deck := Deck withCards: cards. 	
	testPlayers := OrderedCollection with:#napolitana with: #margarita with: #hawaiana.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	napolitanaHand := game playerHand: #napolitana.
	block := [game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #hawaiana.].
	self should: block raise: Error withMessage: 'La acceleration card debe tener a todos los otros jugadores como target.'. 
	
	
]

{ #category : #tests }
Cards_Tests >> testUseACancelationCardOnASpeedupCard [
	
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
Cards_Tests >> testUseACancelationCardOnAnAccelerationCard [
	
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
Cards_Tests >> testUseACancelationCardOnAnInactiveCardRaiseError [
	
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
Cards_Tests >> testUseACancelationCardOnAnInstantCardRaiseAnError [
	
	| myBoxes testPlayers myDie game cards block deck napolitanaCards margaritaCards |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
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
Cards_Tests >> testUseACancelationCardOnAnOverloadCard [
	
	| myBoxes testPlayers myDie game cards deck margaritaHand napolitanaHand usedCards |

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
Cards_Tests >> testUseARedoCard [
	
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
Cards_Tests >> testUseARedoCardOverCancelation [
	
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
Cards_Tests >> testUseARepeatCard [
	
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
Cards_Tests >> testUseARepeatCardWhenNoDieWasRolledYet [
	
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
Cards_Tests >> testUseASpeedUpCard [
	
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
Cards_Tests >> testUseASpeedUpCardOnTwoRounds [
	
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
Cards_Tests >> testUseAnAccelerationCard [
	
	| myBoxes testPlayers myDie game cards deck napolitanaHand |
	
	myBoxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
	with: AccelerationCard new
	with: OverloadCard new
	with: OverloadCard new
	with: OverloadCard new.
	
	deck := Deck withCards: cards. 	
	testPlayers := OrderedCollection with:#napolitana with: #margarita.
	myDie := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoxes: myBoxes players: testPlayers dice: myDie laps: 1 andDeck: deck.
	napolitanaHand := game playerHand: #napolitana.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: testPlayers.
	game playTurnForAllPlayers.
	self assert: ((game ranking) first) absoluteLocation equals: 2.
	self assert: ((game ranking) second) absoluteLocation equals: 2.
	
	game playTurnForAllPlayers.
	self assert: ((game ranking) first) absoluteLocation equals: 4.
	self assert: ((game ranking) second) absoluteLocation equals: 4.
	 
	
	
]

{ #category : #tests }
Cards_Tests >> testUseAnOverloadCard [
	
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
Cards_Tests >> testUseAnOverloadCardAndEndUpWithNegativeNumbers [
	
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
