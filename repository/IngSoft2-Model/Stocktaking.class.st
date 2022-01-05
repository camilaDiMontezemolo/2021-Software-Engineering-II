Class {
	#name : #Stocktaking,
	#superclass : #Object,
	#instVars : [
		'owner',
		'hand',
		'affectedByCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Stocktaking class >> for: player [
	^self new initializeForPlayer: player.
]

{ #category : #'as yet unclassified' }
Stocktaking >> AddToAffectedByCards: card [
]

{ #category : #adding }
Stocktaking >> addToHand: card [
]

{ #category : #'as yet unclassified' }
Stocktaking >> initializeForPlayer: player [
	owner :=player.
]
