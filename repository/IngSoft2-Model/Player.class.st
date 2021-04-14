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
Player class >> withLocation: aLocation [ 
	^self new initializeWithLocation: aLocation.
]

{ #category : #'as yet unclassified' }
Player class >> withLocation: aLocation andName: aName [
	^self new initializeWithLocation: aLocation andName: aName.
]

{ #category : #'as yet unclassified' }
Player class >> withName: aName [
	^self new initializeWithName: aName.
]

{ #category : #initialization }
Player >> initialize [ 
	location:=0.
	myName:=''.
]

{ #category : #initialization }
Player >> initializeWithLocation: aLocation [
	location:=aLocation.
]

{ #category : #initialization }
Player >> initializeWithLocation: aLocation andName: aName [
	location:=aLocation.
	myName := aName.
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
Player >> tosses: someDie on: aBoard [
	|distance|
	
	(aBoard isFinished) ifFalse:[
	distance:=0.
	someDie do: [:dice | distance := distance + (dice spin)].
	location := location + distance.].
	
	(aBoard isFinished) ifTrue:[
		aBoard showPositions.
		]
	
]
