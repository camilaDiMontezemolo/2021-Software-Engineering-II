Class {
	#name : #RedoCard,
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
RedoCard class >> of: player on: anotherPlayer [
	^self new initializeWithPlayer: player andAffectedPlayer: anotherPlayer.
]

{ #category : #'as yet unclassified' }
RedoCard >> active [
	^active
]

{ #category : #'as yet unclassified' }
RedoCard >> affectedPlayer [
	^affectedPlayer
]

{ #category : #'as yet unclassified' }
RedoCard >> applyEffectFrom: aDeck [
	active
		ifTrue:
			[ ^ self redoPreviousCardEffect: aDeck ]
		ifFalse: [ ^ 0 ]
]

{ #category : #initialize }
RedoCard >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [ 
	owner :=player.
	affectedPlayer :=anotherPlayer.
	active := (affectedPlayer isNotNil).
	instant := true.
]

{ #category : #'as yet unclassified' }
RedoCard >> instant [
	^instant.
]

{ #category : #testing }
RedoCard >> isAssignedTo: onePlayer [
	owner :=onePlayer.
	active := (affectedPlayer isNotNil).
	instant := true.
]

{ #category : #'as yet unclassified' }
RedoCard >> owner [
	^owner.
]

{ #category : #'as yet unclassified' }
RedoCard >> redoPreviousCardEffect: aDeck [
	|newCard|
	newCard := aDeck redoTheLastCardUsed: affectedPlayer.
	aDeck addCards: (OrderedCollection with: newCard).
	^newCard applyEffectFrom: aDeck
]

{ #category : #'as yet unclassified' }
RedoCard >> usedOn: player [
	^(player = affectedPlayer)
]
