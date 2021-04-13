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
	^self new initializeUsing: aLocation.
]

{ #category : #initialization }
Player >> initialize [ 
	location:=0.
]

{ #category : #initialization }
Player >> initializeUsing: aLocation [
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
	someDie do: [:dice | distance := distance + ((1 to: (dice sides)) atRandom)].
	location := location + distance.
]
