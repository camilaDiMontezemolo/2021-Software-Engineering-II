Class {
	#name : #MoveWithOverloadCard,
	#superclass : #Move,
	#instVars : [
		'affectedPlayer',
		'active'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoveWithOverloadCard class >> of: player on: anotherPlayer [
	^self new initializeWithPlayer: player andAffectedPlayer: anotherPlayer.
]

{ #category : #initialization }
MoveWithOverloadCard >> initializeWithPlayer: player andAffectedPlayer: anotherPlayer [
	owner :=player.
	affectedPlayer :=anotherPlayer.
	active := (affectedPlayer isNotEmpty).
	instant:= false.
]
