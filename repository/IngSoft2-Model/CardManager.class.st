Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'lastCardUsed',
		'cardRegister',
		'game',
		'deck',
		'usedCards',
		'playersStockTakings',
		'discardedCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardManager class >> with: initialCards in: aGame [
	^self new initializeWithCards: initialCards in: aGame.
]

{ #category : #stocking }
CardManager >> addCardTo: oneStock [
	| newCard |
	self checkStateOfDeck.
	(deck numberOfCards > 0)
	ifTrue: [newCard := deck drawACard.
				oneStock addToHand: newCard.]
]

{ #category : #'in game mechanics' }
CardManager >> affect: target with: card [
	| neededStocks validCard |
	validCard := self validate: target for: card.
	self lastCardUsed: card.
	usedCards add: validCard.
	neededStocks := playersStockTakings select: [:stock| (target includes: stock owner) | (stock owner = target)]. 
	neededStocks do: [ :oneStock | oneStock addToCardsAffectingPlayer: validCard. ].
]

{ #category : #'in game mechanics' }
CardManager >> affectCard: target with: card [
	| validCard |
	validCard := self checkIfTheCardIsARedo: card.
	validCard triggerInstantaneousEffect: target from: self.
	
	
]

{ #category : #effect }
CardManager >> cancellateCard: aCard [
	| neededStocks |
	self validateInstantaneousEffectFor: aCard.
	neededStocks := self findStocksWith: aCard.
	self delete: aCard from: neededStocks
]

{ #category : #stocking }
CardManager >> cardsAffecting: player [
	| neededList |
	neededList := self stockOf: player.
	^neededList cardsAffecting.
]

{ #category : #checking }
CardManager >> checkIfTheCardIsARedo: card [
	(card class = RedoCard)
	ifTrue: [ self usedCards add: card.
				^card triggerRedoEffectFrom: self.].
	^card.
	
]

{ #category : #checking }
CardManager >> checkStateOfDeck [
	(deck numberOfCards = 0)
	ifTrue: [	
			discardedCards shuffle.
			deck refill: discardedCards.
			discardedCards  removeAll: discardedCards.]
]

{ #category : #stocking }
CardManager >> createHandsFor: thePlayersOfThisGame [
	| n |
	n:=0.
	thePlayersOfThisGame do:
		[ :onePlayer | playersStockTakings add: (Stocktaking for: onePlayer). ].
]

{ #category : #stocking }
CardManager >> delete: aCard from: stocks [
	stocks
		do: [ :oneStock | oneStock removeCardAffectingPlayer: aCard ]
]

{ #category : #stocking }
CardManager >> findStocksWith: aCard [
	^ playersStockTakings
		select: [ :stock | stock cardsAffecting includes: aCard ]
]

{ #category : #stocking }
CardManager >> handOf: player [ 
	^(self stockOf: player) hand.
]

{ #category : #stocking }
CardManager >> handOutInitialCardsFor: thePlayersOfThisGame [
	| n |
	self createHandsFor: thePlayersOfThisGame.
	n:=0.
	playersStockTakings do:
		[ :oneStock | [n<2] whileTrue: [self addCardTo: oneStock.
		n:= n+1.].
		n:=0.
	].
]

{ #category : #initialize }
CardManager >> initializeWithCards: initialDeck in: aGame [
	deck := initialDeck.
	game := aGame.
	playersStockTakings := OrderedCollection new.
	usedCards := OrderedCollection new.
	discardedCards := OrderedCollection new.
]

{ #category : #'instance variables' }
CardManager >> lastCardUsed [
	^lastCardUsed.
]

{ #category : #effect }
CardManager >> lastCardUsed: newCard [
	discardedCards add: newCard.
	lastCardUsed:= newCard.
	
]

{ #category : #effect }
CardManager >> lastTypeOfBoxForPlayer: aPlayer [
	game lastTypeOfBoxForPlayer: aPlayer.
]

{ #category : #positioning }
CardManager >> modifyDistanceOf: player [ 
	| playerCards finalDistance|
	finalDistance:=0.
	playerCards := self cardsAffecting: player.
	playerCards do: [:card| finalDistance:= finalDistance +(card value).].
	^finalDistance.
]

{ #category : #stocking }
CardManager >> remove: card fromTheHandOf: player [
	| neededStock |
	neededStock := self stockOf: player.
	neededStock removeOfHand: card.
]

{ #category : #effect }
CardManager >> speedBoostCard: aCard [
	| neededStocks newCard |
	self validateInstantaneousEffectFor: aCard.
	neededStocks := self findStocksWith: aCard.
	self delete: aCard from: neededStocks.
	newCard := (aCard class) withValue: ((aCard value) * 2).
	usedCards remove: aCard.
	usedCards add: newCard.
	neededStocks do: [ :oneStock | oneStock addToCardsAffectingPlayer: newCard.].
]

{ #category : #stocking }
CardManager >> stockOf: player [ 
	| neededStock |
	neededStock := (playersStockTakings select: [:stock| stock owner = player]) first.
	^neededStock.
]

{ #category : #effect }
CardManager >> useOfInstantCard: card [
	^(playersStockTakings select: [:stock| (stock hand includes: card)]) size
	
]

{ #category : #'instance variables' }
CardManager >> usedCards [
	^usedCards
]

{ #category : #validations }
CardManager >> validate: target for: card [
	|validCard|
	validCard := self checkIfTheCardIsARedo: card.
	self validate: target forAcceleration: validCard.
	^validCard.
]

{ #category : #validations }
CardManager >> validate: target forAcceleration: card [
	((card class) = AccelerationCard)
	ifTrue: [ (game players = target) 
		ifFalse: [Error signal: 'La acceleration card debe tener a todos los otros jugadores como target.']].
]

{ #category : #validations }
CardManager >> validateInstantaneousEffectFor: target [
		(usedCards includes: target)
		ifFalse:[Error signal: 'No se puede aplicar el efecto a esa carta.' ].
	
]

{ #category : #validations }
CardManager >> verify: card belongsTo: player [
	| neededStock |
	neededStock := self stockOf: player.
	(neededStock verifyBelongsToPlayerHand: card) ifFalse: [ Error signal: 'Un jugador no puede tirar una que no es suya' ].
]
