Class {
	#name : #MoveWithSpeedUpCard,
	#superclass : #Move,
	#instVars : [
		'affectedPlayer',
		'active'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoveWithSpeedUpCard class >> of: player on: affectedPlayer [
	^self new initializeWithPlayer: player andAffectedPlayer: affectedPlayer.
]

{ #category : #initialization }
MoveWithSpeedUpCard >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [
	owner :=player.
	affectedPlayer :=anotherPlayer.
	active := (affectedPlayer isNotEmpty).
	instant := false.
]
