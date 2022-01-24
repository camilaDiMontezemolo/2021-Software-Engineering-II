Class {
	#name : #StocktakingTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
StocktakingTests >> testEveryPlayerHasAHandWithCards [
	
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
		
	napolitanaHand := OrderedCollection
		with: RepeatCard new
		with: OverloadCard new.
		
		
	deck := Deck withCards: cards. 	
	testPlayers := OrderedCollection with:#margarita with: #napolitana.
	dice := OrderedCollection with: (LoadedDie withTosses: #(1)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game playNextTurn.
	
	
	"self assert: (game getHandOf: #margarita) equals: margaritaHand."
	self assert: (game getHandOf: #napolitana) equals: napolitanaHand.
]

{ #category : #tests }
StocktakingTests >> testUseACancelationCardOnASpeedupCard [
	
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
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(2))).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game playNextTurn.
	napolitanaHand := game getHandOf: #napolitana.
	margaritaHand := game getHandOf: #margarita.
	game player: #margarita wantsToApplyCard: (margaritaHand at: 1) to: #margarita.
	usedCards := game usedCards.
	game player: #napolitana wantsToApplyCard: (napolitanaHand at: 1) toCard: (usedCards first).
	game playNextTurn.
	self assert: ((game ranking) second) location equals: 2.
	self assert: ((game ranking) first) location equals: 2.
	
	self assert: cards size equals: 0.
]

{ #category : #tests }
StocktakingTests >> testUseASpeedUpCard [
	
	| board testPlayers dice game cards rankingOne deck napolitanaHand usedCards|
	
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
	dice := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #(2))).
	game := PizzaGame withBoxes: board players: testPlayers dice: dice laps: 1 andDeck: deck.
	napolitanaHand := game getHandOf: #napolitana.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #napolitana.
	game playTurnForAllPlayers.
	rankingOne:= game ranking.
	usedCards := game usedCards.
	
	
	self assert: (rankingOne first) location equals: 3.
	self assert: (usedCards first) equals: (napolitanaHand first).
	 
	
	
]

{ #category : #tests }
StocktakingTests >> testUseASpeedUpCardOnTwoRounds [
	
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
	dice := LoadedDie withTosses: #(2).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	napolitanaHand := game getHandOf: #napolitana.
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: #napolitana.
	game playTurnForAllPlayers.
	game playTurnForAllPlayers.
	rankingTwo:= game ranking.
	
	self assert: (rankingTwo first) location equals: 2.
	 
]

{ #category : #tests }
StocktakingTests >> testUseAnAccelerationCard [
	
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
	dice := LoadedDie withTosses: #(1).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	napolitanaHand := game getHandOf: #napolitana.
	
	game player: #napolitana wantsToApplyCard: (napolitanaHand first) to: testPlayers.
	game playTurnForAllPlayers.
	
	self assert: ((game ranking) first) location equals: 2.
	self assert: ((game ranking) second) location equals: 2.
	
	game playTurnForAllPlayers.
	self assert: ((game ranking) first) location equals: 4.
	self assert: ((game ranking) second) location equals: 4.
]

{ #category : #tests }
StocktakingTests >> testUseAnOverCard [
	
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
	dice := LoadedDie withTosses: #(2).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	
	margaritaHand := game getHandOf: #margarita.
	game player: #margarita wantsToApplyCard: (margaritaHand first) to: #napolitana.
	game playNextTurn.
	game playNextTurn.
	self assert: ((game ranking) second) location equals: 0.
	self assert: ((game ranking) first) location equals: 2.
	 
]

{ #category : #tests }
StocktakingTests >> testUseAnOverloadCardWithStock [
	
	| boxes testPlayers dice game cards deck margaritaHand cardsTested |
	
	boxes := OrderedCollection 
		with: NoEffectBox new 
		with: NoEffectBox new
		with: NoEffectBox new 
		with: NoEffectBox new.
		
	cardsTested:= OrderedCollection 
		with: OverloadCard new.
		
	cards := OrderedCollection 
		with: OverloadCard new
		with: OverloadCard new
		with: OverloadCard new
		with: OverloadCard new.
	
	deck := Deck withCards: cards. 
	testPlayers := OrderedCollection with: #margarita with: #napolitana.
	dice := OrderedCollection with: (LoadedDie withTosses: #(2)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	
	margaritaHand := game getHandOf: #margarita.
	
	game player: #margarita wantsToApplyCard: (margaritaHand first) to: #napolitana.
	game playNextTurn.
	game playNextTurn.
	self assert: (game getCardsAffecting: #napolitana) equals: cardsTested.
]
