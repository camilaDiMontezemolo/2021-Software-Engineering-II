Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'myPlayer',
		'location',
		'lap',
		'absoluteLocation',
		'myBoard'
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
	myPlayer := aPlayer.
	absoluteLocation := anAbsoluteLocation.
	myBoard:= aBoard.
]

{ #category : #'as yet unclassified' }
Position >> lap [
	^myBoard lapsOfPosition: absoluteLocation.
]

{ #category : #'as yet unclassified' }
Position >> location [
	^myBoard locationOfPosition: absoluteLocation.
]

{ #category : #'as yet unclassified' }
Position >> player [
	^myPlayer.
]

{ #category : #'as yet unclassified' }
Position >> samePlayerAs: anotherPosition [
	^(myPlayer = (anotherPosition player))
]
