Class {
	#name : #BoxAtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
BoxAtomicBomb >> affect: positions triggeredOn: aPosition with: sizeOfBoard [
	|newLocations|
	newLocations:= Dictionary new.
	positions do: 
	[:position |newLocations at: position put:(sizeOfBoard*((position absoluteLocation)//sizeOfBoard))].
	^newLocations.
]
