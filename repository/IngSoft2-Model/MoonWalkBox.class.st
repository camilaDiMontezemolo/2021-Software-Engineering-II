Class {
	#name : #MoonWalkBox,
	#superclass : #Box,
	#instVars : [
		'n'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalkBox class >> loadedWith: aNumber [ 
^self new initializeLoaded: aNumber.
	
]

{ #category : #'as yet unclassified' }
MoonWalkBox >> affect: positions triggeredOn: aPosition with: sizeOfBoard [
	| affectedPositions newLocations|
	affectedPositions :=(positions  reject: [:position| position equals: aPosition]).
	newLocations:= Dictionary new.
	affectedPositions do: 
	[:position |newLocations add: position ->(((position absoluteLocation)-n))].
	^newLocations.

]

{ #category : #'as yet unclassified' }
MoonWalkBox >> initialize [
	n:= 5 atRandom.
]

{ #category : #'as yet unclassified' }
MoonWalkBox >> initializeLoaded: aNumber [.
	n:= aNumber.
]
