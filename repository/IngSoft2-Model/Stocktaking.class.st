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

{ #category : #playerManagment }
Stocktaking >> addToCardsAffectingPlayer: card [
	cardsAffectingPlayer add: card.
]

{ #category : #stockManagment }
Stocktaking >> addToHand: card [
	hand add: card.
]

{ #category : #'accessing - attributes' }
Stocktaking >> cardsAffecting [
	^cardsAffectingPlayer.
]

{ #category : #'accessing - attributes' }
Stocktaking >> hand [
	^hand.
]

{ #category : #initialize }
Stocktaking >> initializeForPlayer: player [
	owner :=player.
	hand:= OrderedCollection new.
	cardsAffectingPlayer:= OrderedCollection new.
]

{ #category : #'accessing - attributes' }
Stocktaking >> owner [
	^owner.
]

{ #category : #playerManagment }
Stocktaking >> removeCardAffectingPlayer: card [
	cardsAffectingPlayer remove: card.
]

{ #category : #stockManagment }
Stocktaking >> removeOfHand: card [
	hand remove: card.
]

{ #category : #stockManagment }
Stocktaking >> verifyBelongsToPlayerHand: card [
	^(hand includes: card).
]
