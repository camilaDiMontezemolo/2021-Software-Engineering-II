Class {
	#name : #SpeedupBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedupBox >> affect: positions triggeredOn: aPosition with: board [ 
	board replacePosition: aPosition 
					with: (board generatePositionFor: aPosition at:(aPosition absoluteLocation)+4).
]
