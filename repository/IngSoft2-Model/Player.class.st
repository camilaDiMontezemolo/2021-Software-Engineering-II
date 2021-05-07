Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'location',
		'myName',
		'myLaps'
	],
	#classInstVars : [
		'location'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Player class >> withName: aName [
	(aName = '') ifTrue: [ Error signal: 'Todo jugador debe tener un nombre.' ].
	^self new initializeWithName: aName.
]

{ #category : #'as yet unclassified' }
Player >> decreaseLaps [
	myLaps:= myLaps-1.
]

{ #category : #'as yet unclassified' }
Player >> equals: aPlayer [ 
	^(location = (aPlayer location)) and: (myName = (aPlayer name)).
]

{ #category : #'as yet unclassified' }
Player >> increaseLaps [
	myLaps:= myLaps+1.
]

{ #category : #initialization }
Player >> initialize [ 
	location:=0.
	myLaps:=0.
	myName:=''.
]

{ #category : #initialization }
Player >> initializeWithName: aName [
	myName := aName.
	myLaps:=0.
	location:=0.
]

{ #category : #'as yet unclassified' }
Player >> laps [
	^myLaps.
]

{ #category : #'as yet unclassified' }
Player >> location [
	^location.
]

{ #category : #'as yet unclassified' }
Player >> name [
	^myName.
]

{ #category : #'as yet unclassified' }
Player >> setLocation: newLocation [
	location := newLocation.
]
