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
Player >> tosses: arg [
	location := location + ((1 to: arg) atRandom).
]
