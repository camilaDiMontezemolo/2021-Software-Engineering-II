Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'lastCardUsed',
		'cardRegister',
		'myGame',
		'myDeck',
		'playerHands',
		'usedCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardManager class >> with: initialCards in: aGame [
	^self new initializeWithCards: initialCards in: aGame.
]

{ #category : #'as yet unclassified' }
CardManager >> addCardFromRedoCard: newCards [
	usedCards add: newCards.
	"dealtCards addAll: myNewCards."
]

{ #category : #'as yet unclassified' }
CardManager >> assign: aCard to: oneHand [ 
	"| newCard |
	newCard := self createNewCard: aCard.
	dealtCards add: newCard."
	oneHand add: aCard.

]

{ #category : #'as yet unclassified' }
CardManager >> assignCard: card to: affectedPlayer with: currentTurnPlayer [

	| newCard |
	newCard := self createNewCard: card withAffectedPlayer: affectedPlayer.
	newCard instant
		ifTrue: [ self replaceInstantCard: card withCard: newCard ]
		ifFalse: [ self compareOwnerOfCard: card withThePayerOfCurrentTurn: currentTurnPlayer 	generating: newCard ]
	
]

{ #category : #'as yet unclassified' }
CardManager >> check: card andRaiseErrorOf: target [
	card class = AccelerationCard
		ifTrue: [
			(target = myGame players)
				ifFalse: [ Error signal: 'La acceleration card debe tener a todos los otros jugadores como target.' ]. ]
]

{ #category : #'as yet unclassified' }
CardManager >> compareOwnerOfCard: card withThePayerOfCurrentTurn: currentTurnPlayer generating: newCard [
	card owner = currentTurnPlayer
		ifTrue: [ self replace: card with: newCard ]
		ifFalse: [ Error
				signal: 'Un jugador no puede tirar una carta fuera de su turno.' ]
]

{ #category : #'as yet unclassified' }
CardManager >> createHandsFor: thePlayersOfThisGame [
	| n |
	n:=0.
	thePlayersOfThisGame do:
		[ :onePlayer | playerHands add: (Stocktaking for: onePlayer). ].
]

{ #category : #'as yet unclassified' }
CardManager >> createNewCard: card withAffectedPlayer: target [
	self check: card andRaiseErrorOf: target.
	^ card class of: card owner on: target
	
]

{ #category : #'as yet unclassified' }
CardManager >> createNewCard: card withOwner: aPlayer [
	((card class) = CancellationCard)
	ifTrue:[^(card class of: aPlayer on: EmptyObject new).]
	ifFalse:[^(card class of: aPlayer on:'').]
]

{ #category : #'as yet unclassified' }
CardManager >> findCardsAffecting: player [
	^usedCards select: [:card| card usedOn: player].
]

{ #category : #'as yet unclassified' }
CardManager >> findCardsBelonging: player [
	^dealtCards select: [:card| card owner = player].
]

{ #category : #'as yet unclassified' }
CardManager >> findLastTypeOfBoxForPlayer: aPlayer [
	myGame findLastTypeOfBoxForPlayer: aPlayer.
]

{ #category : #'as yet unclassified' }
CardManager >> giveACardTo: oneHand [
	| newCard |
	newCard := myDeck drawACard.
	self assign: newCard to: oneHand.
]

{ #category : #'as yet unclassified' }
CardManager >> handOutInitialCardsFor: thePlayersOfThisGame [
	| n |
	self createHandsFor: thePlayersOfThisGame.
	n:=0.
	playerHands do:
		[ :oneHand | [n<2] whileTrue: [self giveACardTo: oneHand.
		n:= n+1.].
		n:=0.
	].
]

{ #category : #initialize }
CardManager >> initializeWithCards: initialDeck in: aGame [
	myDeck := initialDeck.
	myGame := aGame.
	playerHands := OrderedCollection new.
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
	playerCards := (self findCardsAffecting: player).
	playerCards do: [:card| finalDistance:= finalDistance +(card applyEffectFrom: self).].
	^finalDistance.
]

{ #category : #'as yet unclassified' }
CardManager >> redoTheLastCardUsedBy:owner for: affectedPlayer [
	^((lastCardUsed class) of: owner on: affectedPlayer).
]

{ #category : #'as yet unclassified' }
CardManager >> removeCard: aCard [
	usedCards remove: aCard ifAbsent: [ Error signal: 'No se puede cancelar una carta que no está en deck'].
]

{ #category : #'as yet unclassified' }
CardManager >> replace: card with: newCard [  
	usedCards add: newCard.
	dealtCards remove: card.
	

]

{ #category : #'as yet unclassified' }
CardManager >> replaceInstantCard: card withCard: newCard [
	self replace: card with: newCard.
	newCard applyEffectFrom: self.
	self removeCard: newCard.
	

]

{ #category : #'as yet unclassified' }
CardManager >> usedCards [
	^usedCards
]
