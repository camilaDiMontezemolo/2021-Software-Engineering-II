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
Stocktaking >> AddToCardsAffectingPlayer: card [
	cardsAffectingPlayer add: card.
]

{ #category : #adding }
Stocktaking >> addToHand: card [
	hand add: card.
]

{ #category : #'as yet unclassified' }
Stocktaking >> getCardsAffecting [
	^cardsAffectingPlayer.
]

{ #category : #'as yet unclassified' }
Stocktaking >> getHand [
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
