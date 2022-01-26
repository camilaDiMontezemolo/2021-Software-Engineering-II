Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'player',
		'location',
		'lap',
		'absoluteLocation',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Position class >> of: aPlayer at: anAbsoluteLocation on: aBoard [
	^self new initializeWith: aPlayer at: anAbsoluteLocation on: aBoard.
]

{ #category : #'as yet unclassified' }
Position >> > otherPosition [
	^(absoluteLocation > (otherPosition absoluteLocation)).
	
]

{ #category : #'as yet unclassified' }
Position >> absoluteLocation [
	^absoluteLocation.
]

{ #category : #initialize }
Position >> initializeWith: aPlayer at: anAbsoluteLocation on: aBoard [
	player := aPlayer.
	absoluteLocation := anAbsoluteLocation.
	board:= aBoard.
]

{ #category : #'as yet unclassified' }
Position >> lap [
	^board lapsOfPosition: absoluteLocation.
]

{ #category : #'as yet unclassified' }
Position >> location [
	^board locationOfPosition: absoluteLocation.
]

{ #category : #'as yet unclassified' }
Position >> player [
	^player.
]

{ #category : #'as yet unclassified' }
Position >> samePlayerAs: anotherPosition [
	^(player = (anotherPosition player))
]
