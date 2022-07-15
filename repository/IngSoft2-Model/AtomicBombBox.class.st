Class {
	#name : #AtomicBombBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'apply effects' }
AtomicBombBox >> affect: positions triggeredOn: aPosition with: board [
	board moveAllPlayersToFirstBoxSlot.
]
