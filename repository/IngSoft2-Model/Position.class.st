Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'myPlayer',
		'location',
		'lap',
		'absoluteLocation'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Position class >> of: aPlayer at: anAbsoluteLocation [
	^self new initializeWith: aPlayer at: anAbsoluteLocation.
]

{ #category : #initialize }
Position >> == anotherPosition [
	^((myPlayer name) = ((anotherPosition player)name))
]

{ #category : #initialize }
Position >> absoluteLocation [
	^absoluteLocation.
]

{ #category : #initialize }
Position >> equals: anotherPosition [
	^(myPlayer = (anotherPosition player))
]

{ #category : #initialization }
Position >> initializeWith: aPlayer at: anAbsoluteLocation [
	myPlayer := aPlayer.
	absoluteLocation := anAbsoluteLocation.
]

{ #category : #initialize }
Position >> player [
	^myPlayer.
]
