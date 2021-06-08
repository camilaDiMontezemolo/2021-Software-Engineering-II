Class {
	#name : #AtomicBombBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AtomicBombBox >> affect: positions triggeredOn: aPosition with: board [
	|newLocations|
	newLocations:= Dictionary new.
	positions do: 
	[:position |newLocations at: position put: (board calculateNewLocationFor: position)].
	^newLocations.
	"board changeLocation: aPosition with: (board generatePosition)"
]
