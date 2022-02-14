Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'n'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalkEffect class >> loadedWith: aNumber [ 
	(aNumber <1 ) ifTrue: [ Error signal: 'Un moonwalk no te puede tirar menos de 1 para atras.' ].
	^self new initializeLoaded: aNumber.
	
]

{ #category : #'as yet unclassified' }
MoonWalkEffect >> affect: positions triggeredOn: aPosition on: board withPreviousAdvance: distance [
	| affectedPositions|
	affectedPositions :=(positions reject: [:position| position samePlayerAs: aPosition]).
	affectedPositions do: [:position |board change: position by: n].
	
]

{ #category : #'as yet unclassified' }
MoonWalkEffect >> initialize [
	n:= 5 atRandom.
]

{ #category : #'as yet unclassified' }
MoonWalkEffect >> initializeLoaded: aNumber [.
	n:= 0-aNumber.
]
