Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #boxEffect }
WormHoleEffect >> affect: positions triggeredOn: aPosition on: board withPreviousAdvance: distance [
	board change: aPosition by:-4.
]
