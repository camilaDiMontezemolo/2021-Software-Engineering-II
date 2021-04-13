Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'location'
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

{ #category : #initialization }
Player >> initialize [ 
	location:=0.
]

{ #category : #initialization }
Player >> initializeWithLocation: aLocation [
	location:=aLocation.
]

{ #category : #'as yet unclassified' }
Player >> location [
	^location.
]

{ #category : #'as yet unclassified' }
Player >> tosses: someDie [
	|distance|
	distance:=0.
	someDie do: [:dice | distance := distance + (dice spin)].
	location := location + distance.
]
