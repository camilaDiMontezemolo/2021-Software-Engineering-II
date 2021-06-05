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

{ #category : #'instance creation' }
Position class >> of: aPlayer [ 
	^self new initializeUsing: aPlayer.
]

{ #category : #instanceCreation }
Position class >> of: aPlayer at: anAbsoluteLocation [
	^self new initializeWith: aPlayer at: anAbsoluteLocation.
]

{ #category : #instanceCreation }
Position class >> of: aPlayer at: anAbsoluteLocation whithNumberOfLaps: laps [
	^self new initializeWith: aPlayer at: anAbsoluteLocation withLaps: laps.
]

{ #category : #instanceCreation }
Position class >> of: aPlayer at: anAbsoluteLocation whithNumberOfLaps: laps location: location [
	^self new initializeWith: aPlayer at: anAbsoluteLocation withLaps: laps andLocation: location.
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
Position >> changeLocation: newLocation [
	location:= newLocation.

]

{ #category : #initialize }
Position >> decreaseLap [
(lap > 0)
	ifTrue: [lap:= lap-1.]

]

{ #category : #initialize }
Position >> equals: anotherPosition [
	^((myPlayer name) = ((anotherPosition player)name))
]

{ #category : #initialize }
Position >> increaseLap [
	lap:= lap+1.
]

{ #category : #initialize }
Position >> initializeUsing: aPlayer [ 
	myPlayer := aPlayer.
	location:=0.
	lap:=0.
]

{ #category : #initialization }
Position >> initializeWith: aPlayer at: anAbsoluteLocation [
	myPlayer := aPlayer.
	absoluteLocation := anAbsoluteLocation.
	lap := 0.
	location:= 0.
]

{ #category : #initialization }
Position >> initializeWith: aPlayer at: anAbsoluteLocation withLaps: laps [
	myPlayer := aPlayer.
	absoluteLocation := anAbsoluteLocation.
	lap := laps.
	location:= absoluteLocation-(lap*(absoluteLocation//lap)).
]

{ #category : #initialization }
Position >> initializeWith: aPlayer at: anAbsoluteLocation withLaps: laps andLocation: loc [
	myPlayer := aPlayer.
	absoluteLocation := anAbsoluteLocation.
	lap := laps.
	location:= loc.
]

{ #category : #initialize }
Position >> lap [
	^lap.
]

{ #category : #initialize }
Position >> location [
	^location.
]

{ #category : #initialize }
Position >> player [
	^myPlayer.
]
