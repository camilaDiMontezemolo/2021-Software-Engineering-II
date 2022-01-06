Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#instVars : [
		'affectedPlayer',
		'active'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RepeatCard class >> of: player on: anotherPlayer [
	^self new initializeWithPlayer: player andAffectedPlayer: anotherPlayer.
]

{ #category : #'as yet unclassified' }
RepeatCard >> applyEffectFrom: aCardManager [
	active
		ifTrue:
			[aCardManager lastCardUsed: self. 
			aCardManager findLastTypeOfBoxForPlayer: affectedPlayer.]
		ifFalse: [ ^ 0 ]
]

{ #category : #initialize }
RepeatCard >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [ 
	owner :=player.
	affectedPlayer :=anotherPlayer.
	active := (affectedPlayer isNotEmpty).
	instant := true.
]
