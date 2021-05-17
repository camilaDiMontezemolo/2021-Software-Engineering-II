Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'myPlayer',
		'location',
		'lap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Position class >> of: aPlayer [ 
	^self new initializeUsing: aPlayer.
]

{ #category : #initialize }
Position >> changeLap [
	lap:= lap+1.
]

{ #category : #initialize }
Position >> changeLocation: newLocation [
	location:= newLocation.

]

{ #category : #initialize }
Position >> equals: anotherPosition [
	^((myPlayer name) = ((anotherPosition player)name))
]

{ #category : #initialize }
Position >> initializeUsing: aPlayer [ 
	myPlayer := aPlayer.
	location:=0.
	lap:=0.
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
