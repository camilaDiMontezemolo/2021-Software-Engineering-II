Class {
	#name : #CancellationCard,
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
CancellationCard class >> of: player on: anotherPlayer [
	^self new initializeWithPlayer: player andAffectedPlayer: anotherPlayer.
]

{ #category : #'as yet unclassified' }
CancellationCard >> affected [
	^affectedPlayer.
]

{ #category : #'as yet unclassified' }
CancellationCard >> applyEffectFrom: aDeck [ 
	(active) 
	ifTrue:[aDeck lastCardUsed:self.
		aDeck removeCard: affectedPlayer.
		aDeck removeCard: self.]
	ifFalse:[^0].
]

{ #category : #initialize }
CancellationCard >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [ 
	owner :=player.
	affectedPlayer :=anotherPlayer.
	active := (affectedPlayer isNotNil).
	instant :=true.
]

{ #category : #initialize }
CancellationCard >> instant [
	^instant.
]

{ #category : #initialize }
CancellationCard >> owner [
	^owner.
]

{ #category : #'as yet unclassified' }
CancellationCard >> usedOn: player [
	^(player = affectedPlayer)
]
