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
	(aNumber <1 ) ifTrue: [ Error signal: 'Un moonwalk no te puede tirar menos de 1 para atras.' ].
	^self new initializeLoaded: aNumber.
	
]

{ #category : #'as yet unclassified' }
MoonWalkBox >> affect: positions triggeredOn: aPosition with: board [
	| affectedPositions|
	affectedPositions :=(positions reject: [:position| position isOfSamePlayerAs: aPosition]).
	affectedPositions do: [:position |board move: position by: n].
	
]

{ #category : #'as yet unclassified' }
MoonWalkBox >> initialize [
	n:= 5 atRandom.
]

{ #category : #'as yet unclassified' }
MoonWalkBox >> initializeLoaded: aNumber [.
	n:= 0-aNumber.
]
