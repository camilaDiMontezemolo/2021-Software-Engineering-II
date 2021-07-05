Class {
	#name : #SpeedUpCard,
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
SpeedUpCard class >> of: player on: affectedPlayer [
	^self new initializeWithPlayer: player andAffectedPlayer: affectedPlayer.
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> active [
	^active
]

{ #category : #initialize }
SpeedUpCard >> affectedPlayer [
	^affectedPlayer
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> applyEffectFrom: aDeck [ 
	(active) 
	ifTrue:[aDeck lastCardUsed:(self).
		^1.]
	ifFalse:[^0].
]

{ #category : #initialize }
SpeedUpCard >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [
	owner :=player.
	affectedPlayer :=anotherPlayer.
	active := (affectedPlayer isNotEmpty).
	instant := false.
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> instant [
	^instant.
]

{ #category : #initialize }
SpeedUpCard >> isAnEmptyCard [
	^false.
]

{ #category : #initialize }
SpeedUpCard >> isAssignedTo: onePlayer [
	owner := onePlayer.
	active := (affectedPlayer isNotEmpty).
	instant := false.
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> owner [
	^owner.
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> usedOn: player [ 
	^(player = affectedPlayer).
]
