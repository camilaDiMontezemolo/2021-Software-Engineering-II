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
	(aName isEmpty) ifTrue: [ Error signal: 'Todo jugador debe tener un nombre.' ].
	^self new initializeWithName: aName.
]

{ #category : #initialization }
Player >> equals: anotherPlayer [
	^(myName = anotherPlayer name).
]

{ #category : #initialization }
Player >> initializeWithName: aName [
	myName := aName.
]

{ #category : #'as yet unclassified' }
Player >> name [
	^myName.
]
