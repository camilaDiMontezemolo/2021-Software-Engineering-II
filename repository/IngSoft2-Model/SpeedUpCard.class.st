Class {
	#name : #SpeedUpCard,
	#superclass : #Card,
	#instVars : [
		'owner',
		'affectedPlayer',
		'active'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedUpCard class >> of: player [
	^self new initializeWithPlayer: player.
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> affected [
	^affectedPlayer.
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> applyEffectFrom: aDeck [ 
	(active) 
	ifTrue:[aDeck lastCardUsed:self.
		^1.]
	ifFalse:[^0].
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> applyOver: aPlayer [ 
	affectedPlayer:= aPlayer.
]

{ #category : #initialize }
SpeedUpCard >> initializeWithPlayer: player [
	owner :=player.
	affectedPlayer :=player.
	active := true.
]

{ #category : #initialize }
SpeedUpCard >> owner [
	^owner.
]
