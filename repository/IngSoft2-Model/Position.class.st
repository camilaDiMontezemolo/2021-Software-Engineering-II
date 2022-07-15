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

{ #category : #validations }
Position >> > otherPosition [
	^absoluteLocation > (otherPosition absoluteLocation). 
	 
	
]

{ #category : #'instance variables' }
Position >> absoluteLocation [
	^absoluteLocation.
]

{ #category : #initialize }
Position >> initializeWith: aPlayer at: anAbsoluteLocation on: aBoard [
	player := aPlayer.
	absoluteLocation := anAbsoluteLocation.
	board:= aBoard.
]

{ #category : #'instance variables' }
Position >> lap [
	^board lapsOfPosition: absoluteLocation.
]

{ #category : #'instance variables' }
Position >> location [
	^board locationOfPosition: absoluteLocation.
]

{ #category : #'instance variables' }
Position >> player [
	^player.
]

{ #category : #validations }
Position >> samePlayerAs: anotherPosition [
	^player = (anotherPosition player)
]
