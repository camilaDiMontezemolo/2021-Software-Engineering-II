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
CardManager >> addCardTo: oneStock [
	| newCard |
	newCard := myDeck drawACard.
	oneStock addToHand: newCard.
]

{ #category : #'as yet unclassified' }
CardManager >> affect: target with: card [

	| neededStocks validCard |
	validCard := self checkIfTheCardIsARedo: card.
	self lastCardUsed: card.
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
	(usedCards includes: aCard)
		ifFalse: [ (self useOfInstantCard: aCard >1)
				ifTrue:[Error signal: 'No se puede cancelar una carta instantanea']
				ifFalse:[Error signal: 'No se puede cancelar una carta inactiva' ]].
	neededStocks := playersStockTakings select: [:stock| (stock cardsAffecting) includes: aCard].
	neededStocks do:
		[ :oneStock | oneStock removeCardAffectingPlayer: aCard.].
]

{ #category : #'as yet unclassified' }
CardManager >> cardsAffecting: player [
	| neededList |
	neededList := (self stockOf: player).
	^(neededList cardsAffecting).
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
CardManager >> handOf: player [ 
	^(self stockOf: player) hand.
]

{ #category : #'as yet unclassified' }
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
	myDeck := initialDeck.
	myGame := aGame.
	playersStockTakings := OrderedCollection new.
	usedCards := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
CardManager >> lastCardUsed [
	^lastCardUsed.
]

{ #category : #'as yet unclassified' }
CardManager >> lastCardUsed: newCard [
	lastCardUsed:= newCard.
	
]

{ #category : #'as yet unclassified' }
CardManager >> lastTypeOfBoxForPlayer: aPlayer [
	myGame lastTypeOfBoxForPlayer: aPlayer.
]

{ #category : #'as yet unclassified' }
CardManager >> modifyDistanceOf: player [ 
	| playerCards finalDistance|
	finalDistance:=0.
	"playerCards := (self findCardsAffecting: player)."
	playerCards := (self cardsAffecting: player).
	playerCards do: [:card| finalDistance:= finalDistance +(card applyEffectFrom: self).].
	^finalDistance.
]

{ #category : #'as yet unclassified' }
CardManager >> stockOf: player [ 
	| neededStock |
	neededStock := (playersStockTakings select: [:stock| stock owner = player]) first.
	^neededStock.
]

{ #category : #'as yet unclassified' }
CardManager >> useOfInstantCard: card [
	^((playersStockTakings select: [:stock| (stock hand includes: card)]) size)
	
]

{ #category : #'as yet unclassified' }
CardManager >> usedCards [
	^usedCards
]
