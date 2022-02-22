Class {
	#name : #WormHoleBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'apply effects' }
WormHoleBox >> affect: positions triggeredOn: aPosition with: board [
	board move: aPosition by:-4.
]
