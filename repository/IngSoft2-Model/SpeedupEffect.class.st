Class {
	#name : #SpeedupEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #boxEffect }
SpeedupEffect >> affect: positions triggeredOn: aPosition on: board withPreviousAdvance: distance [ 
	board change: aPosition by:4.

]
