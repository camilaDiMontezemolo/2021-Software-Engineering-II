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

{ #category : #instanceCreation }
Position class >> of: aPlayer at: anAbsoluteLocation [
	^self new initializeWith: aPlayer at: anAbsoluteLocation.
]

{ #category : #instanceCreation }
Position class >> of: aPlayer at: anAbsoluteLocation on: aBoard [
	^self new initializeWith: aPlayer at: anAbsoluteLocation on: aBoard.
]

{ #category : #initialize }
Position >> > otherPosition [
	^(absoluteLocation > (otherPosition absoluteLocation)).
	
]

{ #category : #initialize }
Position >> absoluteLocation [
	^absoluteLocation.
]

{ #category : #initialization }
Position >> initializeWith: aPlayer at: anAbsoluteLocation [
	myPlayer := aPlayer.
	absoluteLocation := anAbsoluteLocation.
]

{ #category : #initialization }
Position >> initializeWith: aPlayer at: anAbsoluteLocation on: aBoard [
	myPlayer := aPlayer.
	absoluteLocation := anAbsoluteLocation.
	myBoard:= aBoard.
]

{ #category : #initialize }
Position >> isOfSamePlayerAs: anotherPosition [
	^(myPlayer = (anotherPosition player))
]

{ #category : #initialize }
Position >> lap [
	^(absoluteLocation//(myBoard sizeOfBoard)).
]

{ #category : #initialize }
Position >> location [
	^absoluteLocation -((absoluteLocation//(myBoard sizeOfBoard))*(myBoard sizeOfBoard)).
]

{ #category : #initialize }
Position >> player [
	^myPlayer.
]
