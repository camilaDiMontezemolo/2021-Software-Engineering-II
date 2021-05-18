Class {
	#name : #BoxWormHole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
BoxWormHole >> affect: positions triggeredOn: aPosition with: sizeOfBoard [
	(aPosition location - 4  > 0)
	ifTrue: [
		aPosition changeLocation:(aPosition location - 4).
	]
	ifFalse: [ 
		(aPosition lap > 0)
		ifTrue: [aPosition changeLocation: (sizeOfBoard - (aPosition location - 4)).
		aPosition decreaseLap.]
		ifFalse: [ aPosition changeLocation: 0]
	].
]
