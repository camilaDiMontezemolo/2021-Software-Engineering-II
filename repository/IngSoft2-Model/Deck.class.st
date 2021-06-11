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
Deck >> assignCard: card to: affectedPlayer [
	| newCard |
	newCard:=self createNewCard: card withAffectedPlayer: affectedPlayer.
	self replace:card with: newCard.
	(newCard instant)ifTrue: [newCard applyEffectFrom: self.]
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
	cards remove: aCard.
]

{ #category : #'as yet unclassified' }
Deck >> replace: card with: newCard [  
	cards at: (cards indexOf: card) put: newCard.
]