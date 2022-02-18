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

{ #category : #boxEffect }
MoonWalkEffect >> affect: positions triggeredOn: aPosition on: board withPreviousAdvance: distance [
	| affectedPositions|
	affectedPositions :=(positions reject: [:position| position samePlayerAs: aPosition]).
	affectedPositions do: [:position |board change: position by: n].
	
]

{ #category : #boxEffect }
MoonWalkEffect >> initialize [
	n:= 5 atRandom.
]

{ #category : #boxEffect }
MoonWalkEffect >> initializeLoaded: aNumber [.
	n:= 0-aNumber.
]
