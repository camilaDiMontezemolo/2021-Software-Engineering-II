Class {
	#name : #MoveWithRepeatCard,
	#superclass : #Move,
	#instVars : [
		'affectedPlayer',
		'active'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoveWithRepeatCard class >> of: player on: anotherPlayer [
	^self new initializeWithPlayer: player andAffectedPlayer: anotherPlayer.
]

{ #category : #initialization }
MoveWithRepeatCard >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [ 
	owner :=player.
	affectedPlayer :=anotherPlayer.
	active := (affectedPlayer isNotEmpty).
	instant := true.
]
