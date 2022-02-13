Class {
	#name : #MoonWalkBox,
	#superclass : #Box,
	#instVars : [
		'n'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalkBox >> affect: positions triggeredOn: aPosition with: board [
	| affectedPositions|
	affectedPositions :=(positions reject: [:position| position samePlayerAs: aPosition]).
	affectedPositions do: [:position |board move: position by: n].
	
]

{ #category : #'as yet unclassified' }
MoonWalkBox >> initialize [
	n:= -1.
]
