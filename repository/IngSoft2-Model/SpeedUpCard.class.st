Class {
	#name : #SpeedUpCard,
	#superclass : #Card,
	#instVars : [
		'affectedPlayer',
		'active'
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
SpeedUpCard >> isAnEmptyObject [
	^false.
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> usedOn: player [ 
	^(player = affectedPlayer).
]
