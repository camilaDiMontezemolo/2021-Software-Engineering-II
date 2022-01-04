Class {
	#name : #MoveWithAccelerationCard,
	#superclass : #Move,
	#instVars : [
		'affectedPlayer',
		'active'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoveWithAccelerationCard class >> of: player on: affectedPlayer [
	^self new initializeWithPlayer: player andAffectedPlayer: affectedPlayer.
]

{ #category : #initialization }
MoveWithAccelerationCard >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [
	owner :=player.
	affectedPlayer :=anotherPlayer.
	active := (affectedPlayer isNotEmpty).
	instant:=false.
]
