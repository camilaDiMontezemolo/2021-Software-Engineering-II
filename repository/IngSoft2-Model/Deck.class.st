Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards',
		'lastCardUsed',
		'cardRegister'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> with: initialCards [
	^self new initializeWithCards: initialCards.
]

{ #category : #'as yet unclassified' }
Deck >> findCardsOf: player [
	|playerCards|
	playerCards := OrderedCollection new.
	playerCards:= cards collect: [:card| ((card affected)==player)ifTrue: [playerCards add: card].].
	^playerCards.
]

{ #category : #initialize }
Deck >> initializeWithCards: initialCards [
	cards:= initialCards.
	cardRegister := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
Deck >> lastCardUsed [
	^lastCardUsed.
]

{ #category : #'as yet unclassified' }
Deck >> lastCardUsed: newCard [
	lastCardUsed:= newCard.
]

{ #category : #'as yet unclassified' }
Deck >> modifyDistanceOf: player [ 
	| playerCards finalDistance|
	finalDistance:=0.
	playerCards := (self findCardsOf: player).
	playerCards do: [:card| finalDistance:= finalDistance +(card applyEffectFrom: self).].
	^finalDistance.
]
