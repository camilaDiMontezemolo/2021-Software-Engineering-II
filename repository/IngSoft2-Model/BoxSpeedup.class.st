Class {
	#name : #BoxSpeedup,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
BoxSpeedup >> affect: positions triggeredOn: aPosition with: sizeOfBoard [ 
	(aPosition location + 4  < (sizeOfBoard))
	ifTrue: [
		aPosition changeLocation:(aPosition location + 4).
	]
	ifFalse: [ 
		aPosition changeLocation: (4 - (sizeOfBoard - aPosition location)).
		aPosition increaseLap.
	].
]
