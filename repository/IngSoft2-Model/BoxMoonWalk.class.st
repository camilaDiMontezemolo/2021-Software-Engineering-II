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
	affectedPositions :=(positions  reject: [:position| position equals: aPosition]).
	
	affectedPositions  do: [ :position | 
	((position location - n)  > 0)
		ifTrue: [position changeLocation: (position location - n) .]
	
		ifFalse: [
			(position lap > 0)
				ifTrue: [position changeLocation: (sizeOfBoard - (position location - n)).
							position decreaseLap.]
				ifFalse: [ position changeLocation: 0 .].
				].
			]

]

{ #category : #'as yet unclassified' }
BoxMoonWalk >> initialize [
	n:= 5 atRandom.
]
