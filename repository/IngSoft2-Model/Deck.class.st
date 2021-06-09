Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> with: initialCards [
	^self new initializeWithCards: initialCards.
]

{ #category : #'as yet unclassified' }
Deck >> assignCard:card to: player [
	card belongsTo: player.
	card applyEffectTo: player.
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
]

{ #category : #'as yet unclassified' }
Deck >> modifyDistanceOf: player [ 
	| playerCards finalDistance|
	finalDistance:=0.
	playerCards := (self findCardsOf: player).
	playerCards do: [:card| finalDistance:= finalDistance +(card applyEffect).].
	^finalDistance.
]
