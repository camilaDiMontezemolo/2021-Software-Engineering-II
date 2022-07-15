Class {
	#name : #Stocktaking,
	#superclass : #Object,
	#instVars : [
		'owner',
		'hand',
		'cardsAffectingPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Stocktaking class >> for: player [
	^self new initializeForPlayer: player.
]

{ #category : #'adding/removing' }
Stocktaking >> addToCardsAffectingPlayer: card [
	cardsAffectingPlayer add: card.
]

{ #category : #'adding/removing' }
Stocktaking >> addToHand: card [
	hand add: card.
]

{ #category : #'instance variables' }
Stocktaking >> cardsAffecting [
	^cardsAffectingPlayer.
]

{ #category : #'instance variables' }
Stocktaking >> hand [
	^hand.
]

{ #category : #initialize }
Stocktaking >> initializeForPlayer: player [
	owner :=player.
	hand:= OrderedCollection new.
	cardsAffectingPlayer:= OrderedCollection new.
]

{ #category : #'instance variables' }
Stocktaking >> owner [
	^owner.
]

{ #category : #'adding/removing' }
Stocktaking >> removeCardAffectingPlayer: card [
	cardsAffectingPlayer remove: card.
]

{ #category : #'adding/removing' }
Stocktaking >> removeOfHand: card [
	hand remove: card.
]

{ #category : #validations }
Stocktaking >> verifyBelongsToPlayerHand: card [
	^hand includes: card.
]
