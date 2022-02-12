Class {
	#name : #WormHoleBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
WormHoleBox >> affect: positions triggeredOn: aPosition with: board [
	board change: aPosition by:-4.
]
