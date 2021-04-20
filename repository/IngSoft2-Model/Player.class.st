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
Player class >> withLocation: aLocation andName: aName [
	^self new initializeWithLocation: aLocation andName: aName.
]

{ #category : #'as yet unclassified' }
Player class >> withName: aName [
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
Player >> initializeWithLocation: aLocation andName: aName [
	"Necesario para contrarrestar el random en los test"
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
Player >> tosses: someDie [
	|distance|
	distance:=0.
	someDie do: [:dice | distance := distance + (dice spin)].
	location := location + distance.
]