Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#instVars : [
		'affectedPlayer',
		'active'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AccelerationCard class >> of: player on: affectedPlayer [
	^self new initializeWithPlayer: player andAffectedPlayer: affectedPlayer.
]

{ #category : #'as yet unclassified' }
AccelerationCard >> active [
	^active
]

{ #category : #'as yet unclassified' }
AccelerationCard >> applyEffectFrom: aDeck [ 
	(active) 
	ifTrue:[aDeck lastCardUsed: self.
		^1.]
	ifFalse:[^0].
]

{ #category : #initialize }
AccelerationCard >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [
	owner :=player.
	affectedPlayer :=anotherPlayer.
	active := (affectedPlayer isNotEmpty).
	instant:=false.
]

{ #category : #'as yet unclassified' }
AccelerationCard >> isAnEmptyObject [
	^false.
]

{ #category : #'as yet unclassified' }
AccelerationCard >> usedOn: player [ 
	^(affectedPlayer includes: player).
]
