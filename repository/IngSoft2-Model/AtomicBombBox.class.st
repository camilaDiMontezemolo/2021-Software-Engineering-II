Class {
	#name : #AtomicBombBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AtomicBombBox >> affect: positions triggeredOn: aPosition with: board [
	board moveAllPlayersToFirstBoxSlot.
]
