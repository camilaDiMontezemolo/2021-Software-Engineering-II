Class {
	#name : #SpeedupEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedupEffect >> affect: positions triggeredOn: aPosition on: board withPreviousAdvance: distance [ 
	board change: aPosition by:4.

]
