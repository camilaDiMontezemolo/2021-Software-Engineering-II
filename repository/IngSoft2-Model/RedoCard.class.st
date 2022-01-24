Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedoCard class >> of: player on: anotherPlayer [
	^self new initializeWithPlayer: player andAffectedPlayer: anotherPlayer.
]

{ #category : #'as yet unclassified' }
RedoCard >> applyEffectFrom: cardManager [
	active
		ifTrue:
			[ ^ self redoPreviousCardEffect: cardManager ]
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
RedoCard >> redoPreviousCardEffect: cardManager [
	|newCard|
	newCard := cardManager redoTheLastCardUsedBy:owner for: affectedPlayer.
	(newCard instant)
	ifTrue:[^newCard applyEffectFrom: cardManager]
	ifFalse:[cardManager addCardFromRedoCard: newCard.]
]
