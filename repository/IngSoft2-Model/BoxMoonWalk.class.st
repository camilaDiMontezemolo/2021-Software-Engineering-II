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
	
	
	((aPosition location - n)  > 0)
	ifTrue: [
		affectedPositions  do: [ :position | position changeLocation: (position location - n) ].
	]
	ifFalse: [affectedPositions  do: [ :position | 
			(aPosition lap > 0)
				ifTrue: [position changeLocation: (sizeOfBoard - (aPosition location - n)).
							aPosition decreaseLap.]
				ifFalse: [ position changeLocation: 0 .].
				].
	].
]

{ #category : #'as yet unclassified' }
BoxMoonWalk >> initialize [
	n:= 5 atRandom.
]
