Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#instVars : [
		'owner',
		'affectedPlayer',
		'active',
		'instant'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RepeatCard class >> of: player on: anotherPlayer [
	^self new initializeWithPlayer: player andAffectedPlayer: anotherPlayer.
]

{ #category : #'as yet unclassified' }
RepeatCard >> affected [
	^affectedPlayer.
]

{ #category : #'as yet unclassified' }
RepeatCard >> applyEffectFrom: aDeck [
	active
		ifTrue:
			[ aDeck findLastTypeOfBoxForPlayer: affectedPlayer.]
		ifFalse: [ ^ 0 ]
]

{ #category : #initialize }
RepeatCard >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [ 
	owner :=player.
	affectedPlayer :=anotherPlayer.
	active := (affectedPlayer isNotEmpty).
	instant := true.
]

{ #category : #initialize }
RepeatCard >> instant [
	^instant.
]

{ #category : #initialize }
RepeatCard >> isAnEmptyCard [
	^false.
]

{ #category : #initialize }
RepeatCard >> owner [
	^owner.
]

{ #category : #'as yet unclassified' }
RepeatCard >> usedOn: player [
	^(player = affectedPlayer)
]
