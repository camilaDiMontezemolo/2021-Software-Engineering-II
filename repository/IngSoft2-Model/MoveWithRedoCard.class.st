Class {
	#name : #MoveWithRedoCard,
	#superclass : #Move,
	#instVars : [
		'affectedPlayer',
		'active'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoveWithRedoCard class >> of: player on: anotherPlayer [
	^self new initializeWithPlayer: player andAffectedPlayer: anotherPlayer.
]

{ #category : #initialization }
MoveWithRedoCard >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [ 
	owner :=player.
	affectedPlayer :=anotherPlayer.
	active := (affectedPlayer isNotNil).
	instant := true.
]
