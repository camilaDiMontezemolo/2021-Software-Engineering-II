Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'location',
		'myName'
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
Player >> equals: aPlayer [ 
	^(location = (aPlayer location)) and: (myName = (aPlayer name)).
]

{ #category : #initialization }
Player >> initialize [ 
	location:=0.
	myName:=''.
]

{ #category : #initialization }
Player >> initializeWithName: aName [
	myName := aName.
	location:=0.
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
