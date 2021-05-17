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
	| affectedPositions |
	affectedPositions :=(positions  select: [:position| (position equals: aPosition) not]).
	affectedPositions  do: [ :position | position setLocation: (position location - n) ].
]

{ #category : #'as yet unclassified' }
BoxMoonWalk >> initialize [
	n:= 5 atRandom.
]
