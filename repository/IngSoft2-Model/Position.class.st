Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'player',
		'absoluteLocation',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Position class >> of: aPlayer at: anAbsoluteLocation on: aBoard [
	^self new initializeWith: aPlayer at: anAbsoluteLocation on: aBoard.
]

{ #category : #locationManagment }
Position >> > otherPosition [
	^(absoluteLocation > (otherPosition absoluteLocation)).
	
]

{ #category : #locationManagment }
Position >> absoluteLocation [
	^absoluteLocation.
]

{ #category : #initialize }
Position >> initializeWith: aPlayer at: anAbsoluteLocation on: aBoard [
	player := aPlayer.
	absoluteLocation := anAbsoluteLocation.
	board:= aBoard.
]

{ #category : #locationManagment }
Position >> lap [
	^board lapsOfPosition: absoluteLocation.
]

{ #category : #locationManagment }
Position >> location [
	^board locationOfPosition: absoluteLocation.
]

{ #category : #player }
Position >> player [
	^player.
]

{ #category : #player }
Position >> samePlayerAs: anotherPosition [
	^(player = (anotherPosition player))
]
