Class {
	#name : #CardBoxLoaded,
	#superclass : #Box,
	#instVars : [
		'loadedCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardBoxLoaded class >> loadedWith: someCards [ 
^self new initializeLoaded: someCards.
]

{ #category : #'as yet unclassified' }
CardBoxLoaded >> affect: positions triggeredOn: aPosition with: board [ 
	| newCards |
	newCards:= loadedCards.
	board saveNewCards: newCards.

]

{ #category : #'as yet unclassified' }
CardBoxLoaded >> initializeLoaded: someCards [
	loadedCards := OrderedCollection new.
	loadedCards := someCards.

]

{ #category : #'as yet unclassified' }
CardBoxLoaded >> loadedCards [
	^loadedCards.
]
