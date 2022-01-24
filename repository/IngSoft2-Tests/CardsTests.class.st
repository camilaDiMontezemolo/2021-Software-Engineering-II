Class {
	#name : #CardsTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardsTests >> should: block raise: kindOfError withMessage: errorMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : #tests }
CardsTests >> testACardCanNotBeUsedOutsideYourTurn [
	
	| boxes testPlayers myDie game cards napolitanaCards |
	
	boxes := OrderedCollection 
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
	myDie := OrderedCollection with: (LoadedDie withTosses: #(1)).
	game := PizzaGame 	withBoxes: boxes players: testPlayers dice: myDie laps: 1 andDeck: cards.
	game playTurnForAllPlayers.
	napolitanaCards := game playerHand: #napolitana.
	self should: [game player: #napolitana wantsToApplyCard: (napolitanaCards first) to: testPlayers.] raise: Error withMessage: 'Un jugador no puede tirar una carta fuera de su turno.'
]

{ #category : #tests }
CardsTests >> testAPlayerOutsideOfTheGameCanNotUseAnInstantCard [
	
	| boxes testPlayers dice game cards deck napolitanaHand margaritaHand usedCards |

	boxes := OrderedCollection 
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
	dice := OrderedCollection with: (LoadedDie withTosses: #(2)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game playNextTurn.
	napolitanaHand := game playerHand: #napolitana.
	margaritaHand := game playerHand: #margarita.
	game player: #margarita wantsToApplyCard: (margaritaHand at: 1) to: #margarita.
	usedCards := game usedCards.

	self should: [game player: #ravioles wantsToApplyCard: (napolitanaHand at: 1) to: (usedCards first).] raise: Error withMessage: 'Esta persona no es un jugador del juego.'.
]

{ #category : #tests }
CardsTests >> testAccelerationCardMustBeUsedAgainstAllPlayers [
	
	| boxes testPlayers dice game cards deck napolitanaHand |
	
	boxes := OrderedCollection 
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
	dice := OrderedCollection with: (LoadedDie withTosses: #(1)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	napolitanaHand := game playerHand: #napolitana.
	self should: [game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #hawaiana.] raise: Error withMessage: 'La acceleration card debe tener a todos los otros jugadores como target.'. 
	
	
]

{ #category : #tests }
CardsTests >> testUseACancelationCardOnASpeedupCard [
	
	| boxes testPlayers dice game cards deck napolitanaHand margaritaHand usedCards |

	boxes := OrderedCollection 
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
	dice := OrderedCollection with: (LoadedDie withTosses: #(2)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game playNextTurn.
	napolitanaHand := game playerHand: #napolitana.
	margaritaHand := game playerHand: #margarita.
	game player: #margarita wantsToApplyCard: (margaritaHand at: 1) to: #margarita.
	usedCards := game usedCards.
	game player: #napolitana wantsToApplyCard: (napolitanaHand at: 1) to: (usedCards first).
	game playNextTurn.
	self assert: ((game ranking) second) location equals: 2.
	self assert: ((game ranking) first) location equals: 2.
	
	self assert: cards size equals: 0.
	
]

{ #category : #tests }
CardsTests >> testUseACancelationCardOnAnAccelerationCard [
	
	| boxes testPlayers dice game cards deck napolitanaHand margaritaHand usedCards |
	
	boxes := OrderedCollection 
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
	dice := OrderedCollection with: (LoadedDie withTosses: #(2)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game playNextTurn.
	margaritaHand := game playerHand: #margarita.
	game player: #margarita wantsToApplyCard: (margaritaHand first) to: testPlayers.
	usedCards := game usedCards.
	napolitanaHand := game playerHand: #napolitana.
	game applyCard: (napolitanaHand first) toCard: (usedCards first). 
	game playNextTurn.
	self assert: ((game ranking) second) location equals: 2.
	self assert: ((game ranking) first) location equals: 2.
	
	self assert: cards size equals: 0.
	
]

{ #category : #tests }
CardsTests >> testUseACancelationCardOnAnInactiveCardRaiseError [
	
	| boxes testPlayers dice game cards deck napolitanaHand margaritaHand |
	
	boxes := OrderedCollection 
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
	dice := OrderedCollection with: (LoadedDie withTosses: #(2)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game playNextTurn.
	napolitanaHand := game playerHand: #napolitana.
	margaritaHand := game playerHand: #margarita.

	self should: [game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: (margaritaHand first).] raise: Error withMessage: 'No se puede cancelar una carta inactiva.'

	
]

{ #category : #tests }
CardsTests >> testUseACancelationCardOnAnInstantCardRaiseAnError [
	
	| boxes testPlayers dice game cards deck napolitanaCards margaritaCards |
	
	boxes := OrderedCollection 
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
	dice := OrderedCollection with: (LoadedDie withTosses: #(2)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	napolitanaCards := game playerHand: #napolitana.
	margaritaCards := game playerHand: #margarita.
	
	self should: [game player: #napolitana wantsToApplyCard: (napolitanaCards first) to: (margaritaCards first).] raise: Error withMessage: 'No se puede cancelar una carta instantanea.'

	
]

{ #category : #tests }
CardsTests >> testUseACancelationCardOnAnOverloadCard [
	
	| boxes testPlayers dice game cards deck margaritaHand napolitanaHand usedCards |

	boxes := OrderedCollection 
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
	dice := OrderedCollection with: (LoadedDie withTosses: #(2)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game playNextTurn.
	margaritaHand := game playerHand: #margarita.
	napolitanaHand := game playerHand: #napolitana.
	game applyCard: (margaritaHand first) toCard: #margarita.
	usedCards := game usedCards.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: (usedCards first). 
	game playNextTurn.
	self assert: ((game ranking) second) location equals: 2.
	self assert: ((game ranking) first) location equals: 2.
	
	self assert: cards size equals: 0.
	
]

{ #category : #tests }
CardsTests >> testUseARedoCard [
	
	| boxes testPlayers dice game cards deck margaritaHand napolitanaHand |

    boxes := OrderedCollection 
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
   dice := OrderedCollection with: (LoadedDie withTosses: #(2)).
   game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	margaritaHand := game playerHand: #margarita.
	napolitanaHand := game playerHand: #napolitana.
	game player: #margarita wantsToApplyCard: (margaritaHand first) to: #margarita.
   game playNextTurn.

	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #napolitana.
	game playNextTurn.
	
	self assert: ((game ranking) first) location equals: 3.
	self assert: ((game ranking) second) location equals: 3.
	 
	
	
]

{ #category : #tests }
CardsTests >> testUseARedoCardOverCancelation [
	
	| boxes testPlayers dice game cards deck margaritaHand napolitanaHand usedCards |
	
	boxes := OrderedCollection 
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
	dice := OrderedCollection with: (LoadedDie withTosses: #(2)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 10 andDeck: deck.
	margaritaHand := game playerHand: #margarita.
	napolitanaHand := game playerHand: #napolitana.
	game player: #margarita wantsToApplyCard: (margaritaHand first) to: #margarita.
	game player: #margarita wantsToApplyCard: (margaritaHand second) to: #margarita.
	usedCards := game usedCards.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: (usedCards second).
	game player: #napolitana wantsToApplyCard: (napolitanaHand second) to: (usedCards first).
	game playTurnForAllPlayers.
	
	self assert: ((game ranking) second) location equals: 2.
	self assert: ((game ranking) first) location equals: 2.
	 
	
	
]

{ #category : #tests }
CardsTests >> testUseARepeatCard [
	
	| boxes testPlayers dice game cards deck napolitanaHand |
	
	boxes := OrderedCollection 
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
	dice := OrderedCollection with: (LoadedDie withTosses: #(1)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game playNextTurn.
	napolitanaHand := game playerHand: #napolitana.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #napolitana.
	
	self assert: ((game ranking) first) location equals: 5.
	self assert: ((game ranking) second) location equals: 4.
	 
	
	
]

{ #category : #tests }
CardsTests >> testUseARepeatCardWhenNoDieWasRolledYet [
	
	| boxes testPlayers dice game cards deck margaritaHand |
	
	boxes := OrderedCollection 
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
	dice := OrderedCollection with: (LoadedDie withTosses: #(1)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	margaritaHand := game playerHand: #margarita.
	game player: #margarita wantsToApplyCard: (margaritaHand first) to: #margarita.
	
	self assert: ((game ranking) first) location equals: 0.
	self assert: ((game ranking) second) location equals: 0.
	 
	
	
]

{ #category : #tests }
CardsTests >> testUseASpeedUpCard [
	
	| board testPlayers dice game cards rankingOne deck napolitanaHand |
	
	board := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: SpeedUpCard new
		with: OverloadCard new.
	deck := Deck withCards: cards. 	
	testPlayers := OrderedCollection with: #napolitana.
	dice := OrderedCollection with: (LoadedDie withTosses: #(2)).
	game := PizzaGame withBoxes: board players: testPlayers dice: dice laps: 1 andDeck: deck.
	napolitanaHand := game playerHand: #napolitana.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #napolitana.
	game playTurnForAllPlayers.
	rankingOne:= game ranking.
	
	self assert: (rankingOne first) location equals: 3.
	 
	
	
]

{ #category : #tests }
CardsTests >> testUseASpeedUpCardOnTwoRounds [
	
	| boxes testPlayers dice game cards rankingTwo deck napolitanaHand |
	
	boxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cards := OrderedCollection
		with: SpeedUpCard new
		with: OverloadCard new.
	deck := Deck withCards: cards. 
	testPlayers := OrderedCollection with: #napolitana.
	dice := OrderedCollection with: (LoadedDie withTosses: #(2)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	napolitanaHand := game playerHand: #napolitana.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #napolitana.
	game playTurnForAllPlayers.
	game playTurnForAllPlayers.
	rankingTwo:= game ranking.
	
	self assert: (rankingTwo first) location equals: 2.
	 
	
	
]

{ #category : #tests }
CardsTests >> testUseAnAccelerationCard [
	
	| boxes testPlayers dice game cards deck napolitanaHand |
	
	boxes := OrderedCollection 
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
	dice := OrderedCollection with: (LoadedDie withTosses: #(1)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	napolitanaHand := game playerHand: #napolitana.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: testPlayers.
	game playTurnForAllPlayers.
	self assert: ((game ranking) first) location equals: 2.
	self assert: ((game ranking) second) location equals: 2.
	
	game playTurnForAllPlayers.
	self assert: ((game ranking) first) location equals: 4.
	self assert: ((game ranking) second) location equals: 4.
	 
	
	
]

{ #category : #tests }
CardsTests >> testUseAnOverloadCard [
	
	| boxes testPlayers dice game cards deck margaritaHand |
	
	boxes := OrderedCollection 
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
	dice := OrderedCollection with: (LoadedDie withTosses: #(2)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	margaritaHand := game playerHand: #margarita.
	game player: #margarita wantsToApplyCard: (margaritaHand first) to: #napolitana.
	game playNextTurn.
	game playNextTurn.
	self assert: ((game ranking) second) location equals: 0.
	self assert: ((game ranking) first) location equals: 2.
	 
	
	
]

{ #category : #tests }
CardsTests >> testUseAnOverloadCardAndEndUpWithNegativeNumbers [
	
	| boxes testPlayers dice game cards deck napolitanaHand |
	
	boxes := OrderedCollection 
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
	dice := OrderedCollection with: (LoadedDie withTosses: #(1)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	napolitanaHand := game playerHand: #napolitana.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #napolitana.
	game playNextTurn.
	game playNextTurn.
	self assert: ((game ranking) second) location equals: 3.
	self assert: ((game ranking) first) location equals: 1.
	self assert: ((game ranking) second) lap equals: -1.
	 
	
	
]