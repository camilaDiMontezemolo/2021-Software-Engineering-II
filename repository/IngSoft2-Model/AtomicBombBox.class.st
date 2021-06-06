Class {
	#name : #AtomicBombBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AtomicBombBox >> affect: positions triggeredOn: aPosition with: sizeOfBoard [
	|newLocations|
	newLocations:= Dictionary new.
	positions do: 
	[:position |newLocations at: position put:(sizeOfBoard*((position absoluteLocation)//sizeOfBoard))].
	^newLocations.
]
