Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards',
		'lastCardUsed',
		'cardRegister',
		'myGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> with: initialCards in: aGame [
	^self new initializeWithCards: initialCards in: aGame.
]

{ #category : #'as yet unclassified' }
Deck >> addCards: myNewCards [
	cards addAll: myNewCards.
]

{ #category : #'as yet unclassified' }
Deck >> assignCard: card to: affectedPlayer with: currentTurnPlayer [
	| newCard |
	newCard := self
		createNewCard: card
		withAffectedPlayer: affectedPlayer.
	newCard instant
		ifTrue: [ self replaceInstantCard: card withCard: newCard ]
		ifFalse: [ self
				checkMplayerOf: card
				withCurrentTurn: currentTurnPlayer
				generating: newCard ]
]

{ #category : #'as yet unclassified' }
Deck >> checkMplayerOf: card withCurrentTurn: currentTurnPlayer generating: newCard [
	card owner = currentTurnPlayer
		ifTrue: [ self replace: card with: newCard ]
		ifFalse: [ Error
				signal: 'Un jugador no puede tirar una carta fuera de su turno.' ]
]

{ #category : #'as yet unclassified' }
Deck >> createNewCard: card withAffectedPlayer: aPlayer [ 
	^(card class of:card owner on:aPlayer).
]

{ #category : #'as yet unclassified' }
Deck >> findCardsAffecting: player [
	^cards select: [:card| card usedOn: player].
]

{ #category : #'as yet unclassified' }
Deck >> findLastTypeOfBoxForPlayer: aPlayer [
	myGame findLastTypeOfBoxForPlayer: aPlayer.
]

{ #category : #initialize }
Deck >> initializeWithCards: initialCards in: aGame [
	cards:= initialCards.
	myGame := aGame.
]

{ #category : #'as yet unclassified' }
Deck >> lastCardUsed: newCard [
	lastCardUsed:= newCard.
]

{ #category : #'as yet unclassified' }
Deck >> modifyDistanceOf: player [ 
	| playerCards finalDistance|
	finalDistance:=0.
	playerCards := (self findCardsAffecting: player).
	playerCards do: [:card| finalDistance:= finalDistance +(card applyEffectFrom: self).].
	^finalDistance.
]

{ #category : #'as yet unclassified' }
Deck >> redoTheLastCardUsed: aPlayer [ 
	^(lastCardUsed class) of: aPlayer on: aPlayer.
]

{ #category : #'as yet unclassified' }
Deck >> removeCard: aCard [
	cards remove: aCard ifAbsent: [ Error signal: 'No se puede cancelar una carta que no está en deck'].
]

{ #category : #'as yet unclassified' }
Deck >> replace: card with: newCard [  
	cards at: (cards indexOf: card) put: newCard.
]

{ #category : #'as yet unclassified' }
Deck >> replaceInstantCard: card withCard: newCard [
	self replace: card with: newCard.
	newCard applyEffectFrom: self.
	self removeCard: newCard
]
