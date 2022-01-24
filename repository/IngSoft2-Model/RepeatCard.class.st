Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
RepeatCard >> applyEffectFrom: aCardManager [
	active
		ifTrue:
			[aCardManager lastCardUsed: self. 
			aCardManager findLastTypeOfBoxForPlayer: affectedPlayer.]
		ifFalse: [ ^ 0 ]
]

{ #category : #initialize }
RepeatCard >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [ 
	owner :=player.
	affectedPlayer :=anotherPlayer.
	active := (affectedPlayer isNotEmpty).
	instant := true.
]
