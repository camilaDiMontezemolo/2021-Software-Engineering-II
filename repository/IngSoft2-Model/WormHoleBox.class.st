Class {
	#name : #WormHoleBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
WormHoleBox >> affect: positions triggeredOn: aPosition with: sizeOfBoard [
	|newLocations|
	newLocations:= Dictionary new.
	newLocations at: aPosition put:((aPosition absoluteLocation)-4).
	^newLocations.
]
