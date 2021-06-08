Class {
	#name : #SpeedupBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedupBox >> affect: positions triggeredOn: aPosition with: board [ 
	|newLocations|
	newLocations:= Dictionary new.
	newLocations at: aPosition put:((aPosition absoluteLocation)+4).
	^newLocations.
]
