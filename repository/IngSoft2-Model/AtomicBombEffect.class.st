Class {
	#name : #AtomicBombEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AtomicBombEffect >> affect: positions triggeredOn: aPosition on: board withPreviousAdvance: distance [
	board moveAllPlayersToFirstBoxSlot.
]
