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
	dice := OrderedCollection with: (LoadedDice withTosses: #(1)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	game playNextTurn.
	
	
	"self assert: (game getHandOf: #margarita) equals: margaritaHand."
	self assert: (game getHandOf: #napolitana) equals: napolitanaHand.
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
	dice := OrderedCollection with: (LoadedDice withTosses: #(2)).
	game := PizzaGame withBoxes: boxes players: testPlayers dice: dice laps: 1 andDeck: deck.
	
	margaritaHand := game getHandOf: #margarita.
	
	game player: #margarita wantsToApplyCard: (margaritaHand first) to: #napolitana.
	game playNextTurn.
	game playNextTurn.
	self assert: (game getCardsAffecting: #napolitana) equals: cardsTested.
]
