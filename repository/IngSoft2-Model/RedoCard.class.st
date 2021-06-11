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
RedoCard >> affected [
	^affectedPlayer.
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
	active := (affectedPlayer isNotEmpty).
	instant := true.
]

{ #category : #initialize }
RedoCard >> instant [
	^instant.
]

{ #category : #initialize }
RedoCard >> owner [
	^owner.
]

{ #category : #'as yet unclassified' }
RedoCard >> redoPreviousCardEffect: aDeck [
	|newCard|
	newCard := aDeck redoTheLastCardUsed: affectedPlayer.
	aDeck replace: self with: newCard.
	^newCard applyEffectFrom: aDeck
]

{ #category : #'as yet unclassified' }
RedoCard >> usedOn: player [
	^(player = affectedPlayer)
]