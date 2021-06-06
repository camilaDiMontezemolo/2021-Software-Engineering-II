Class {
	#name : #BoxSpeedup,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
BoxSpeedup >> affect: positions triggeredOn: aPosition with: sizeOfBoard [ 
	|newLocations|
	newLocations:= Dictionary new.
	newLocations at: aPosition put:((aPosition absoluteLocation)+4).
	^newLocations.
]
