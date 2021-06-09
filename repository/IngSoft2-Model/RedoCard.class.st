Class {
	#name : #RedoCard,
	#superclass : #Card,
	#instVars : [
		'owner',
		'affectedPlayer',
		'active'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedoCard class >> of: player [
	^self new initializeWithPlayer: player.
]

{ #category : #'as yet unclassified' }
RedoCard >> affected [
	^affectedPlayer.
]

{ #category : #'as yet unclassified' }
RedoCard >> applyEffectFrom: aDeck [ 
	(active) 
	ifTrue:[^(aDeck lastCardUsed applyEffectFrom: aDeck).]
	ifFalse:[^0].
]

{ #category : #'as yet unclassified' }
RedoCard >> applyOver: aPlayer [ 
	affectedPlayer:= aPlayer.
]

{ #category : #initialize }
RedoCard >> initializeWithPlayer: player [
	owner :=player.
	affectedPlayer :=player.
	active := true.
]

{ #category : #initialize }
RedoCard >> owner [
	^owner.
]
