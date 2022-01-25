Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'lastCardUsed',
		'cardRegister',
		'myGame',
		'myDeck',
		'usedCards',
		'playersStockTakings'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardManager class >> with: initialCards in: aGame [
	^self new initializeWithCards: initialCards in: aGame.
]

{ #category : #'as yet unclassified' }
CardManager >> affect: target with: card [

	| neededStocks validCard |
	validCard := self checkIfTheCardIsARedo: card.
	neededStocks := playersStockTakings select: [:stock| (target includes: (stock owner)) | (stock owner = target)].
	neededStocks do: [ :oneStock | oneStock AddToCardsAffectingPlayer: validCard. 
							self usedCards add: validCard].
	
]

{ #category : #'as yet unclassified' }
CardManager >> affectCard: target with: card [
	| validCard |
	validCard := self checkIfTheCardIsARedo: card.
	validCard triggerInstantaneousEffect: target from: self. 
	
	
]

{ #category : #'as yet unclassified' }
CardManager >> cancellateCard: aCard [
	| neededStocks|
	neededStocks := playersStockTakings select: [:stock| (stock getCardsAffecting) includes: aCard].
	neededStocks do:
		[ :oneStock | oneStock removeCardAffectingPlayer: aCard.].
	"usedCards remove: aCard ifAbsent: [ Error signal: 'No se puede cancelar una carta que no está en deck']."
]

{ #category : #'as yet unclassified' }
CardManager >> check: card andRaiseErrorOf: target [
	card class = AccelerationCard
		ifTrue: [
			(target = myGame players)
				ifFalse: [ Error signal: 'La acceleration card debe tener a todos los otros jugadores como target.' ]. ]
]

{ #category : #'as yet unclassified' }
CardManager >> checkIfTheCardIsARedo: card [
	((card class) = RedoCard)
	ifTrue: [ ^(card triggerRedoEffectFrom: self).  ]
	ifFalse: [ ^card. ].
	
]

{ #category : #'as yet unclassified' }
CardManager >> createHandsFor: thePlayersOfThisGame [
	| n |
	n:=0.
	thePlayersOfThisGame do:
		[ :onePlayer | playersStockTakings add: (Stocktaking for: onePlayer). ].
]

{ #category : #'as yet unclassified' }
CardManager >> findLastTypeOfBoxForPlayer: aPlayer [
	myGame findLastTypeOfBoxForPlayer: aPlayer.
]

{ #category : #'as yet unclassified' }
CardManager >> getCardsAffecting: player [
	| neededList |
	neededList := (self getStockOf: player).
	^(neededList getCardsAffecting).
]

{ #category : #'as yet unclassified' }
CardManager >> getHandOf: player [ 
	^(self getStockOf: player) getHand.
]

{ #category : #'as yet unclassified' }
CardManager >> getStockOf: player [ 
	| neededStock |
	neededStock := (playersStockTakings select: [:stock| stock owner = player]) first.
	^neededStock.
]

{ #category : #'as yet unclassified' }
CardManager >> giveACardTo: oneStock [
	| newCard |
	newCard := myDeck drawACard.
	oneStock addToHand: newCard.
]

{ #category : #'as yet unclassified' }
CardManager >> giveLastCardUsed [
	| card |
	card := (lastCardUsed class) new.
	^card.
]

{ #category : #'as yet unclassified' }
CardManager >> handOutInitialCardsFor: thePlayersOfThisGame [
	| n |
	self createHandsFor: thePlayersOfThisGame.
	n:=0.
	playersStockTakings do:
		[ :oneStock | [n<2] whileTrue: [self giveACardTo: oneStock.
		n:= n+1.].
		n:=0.
	].
]

{ #category : #initialize }
CardManager >> initializeWithCards: initialDeck in: aGame [
	myDeck := initialDeck.
	myGame := aGame.
	playersStockTakings := OrderedCollection new.
	usedCards := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
CardManager >> lastCardUsed: newCard [
	lastCardUsed:= newCard.
	
]

{ #category : #'as yet unclassified' }
CardManager >> modifyDistanceOf: player [ 
	| playerCards finalDistance|
	finalDistance:=0.
	"playerCards := (self findCardsAffecting: player)."
	playerCards := (self getCardsAffecting: player).
	playerCards do: [:card| finalDistance:= finalDistance +(card applyEffectFrom: self).].
	^finalDistance.
]

{ #category : #'as yet unclassified' }
CardManager >> usedCards [
	^usedCards
]
