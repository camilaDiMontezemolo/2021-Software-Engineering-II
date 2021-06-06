Class {
	#name : #BoxMoonWalk,
	#superclass : #Object,
	#instVars : [
		'n'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
BoxMoonWalk >> affect: positions triggeredOn: aPosition with: sizeOfBoard [
	| affectedPositions newLocations|
	affectedPositions :=(positions  reject: [:position| position equals: aPosition]).
	newLocations:= Dictionary new.
	affectedPositions do: 
	[:position |newLocations add: position ->(((position absoluteLocation)-n))].
	^newLocations.

]

{ #category : #'as yet unclassified' }
BoxMoonWalk >> initialize [
	n:= 5 atRandom.
]
