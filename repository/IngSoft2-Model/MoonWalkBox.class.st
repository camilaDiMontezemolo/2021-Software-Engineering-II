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
MoonWalkBox >> affect: positions triggeredOn: aPosition with: board [
	| affectedPositions|
	affectedPositions :=(positions  reject: [:position| position equals: aPosition]).
	affectedPositions do: 
	[:position |board replacePosition: position 
					with: (board generatePositionFor: position at:(position absoluteLocation)-n)].

]

{ #category : #'as yet unclassified' }
MoonWalkBox >> initialize [
	n:= 5 atRandom.
]

{ #category : #'as yet unclassified' }
MoonWalkBox >> initializeLoaded: aNumber [.
	n:= aNumber.
]
