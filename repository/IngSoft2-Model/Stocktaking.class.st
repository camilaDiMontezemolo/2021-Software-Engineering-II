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

{ #category : #'as yet unclassified' }
Stocktaking >> addToCardsAffectingPlayer: card [
	cardsAffectingPlayer add: card.
]

{ #category : #adding }
Stocktaking >> addToHand: card [
	hand add: card.
]

{ #category : #'as yet unclassified' }
Stocktaking >> cardsAffecting [
	^cardsAffectingPlayer.
]

{ #category : #'as yet unclassified' }
Stocktaking >> hand [
	^hand.
]

{ #category : #'as yet unclassified' }
Stocktaking >> initializeForPlayer: player [
	owner :=player.
	hand:= OrderedCollection new.
	cardsAffectingPlayer:= OrderedCollection new.
]

{ #category : #'as yet unclassified' }
Stocktaking >> owner [
	^owner.
]

{ #category : #'as yet unclassified' }
Stocktaking >> removeCardAffectingPlayer: card [
	cardsAffectingPlayer remove: card.
]

{ #category : #adding }
Stocktaking >> removeOfHand: card [
	hand remove: card.
]

{ #category : #adding }
Stocktaking >> verifyBelongsToPlayerHand: card [
	^(hand includes: card).
]
