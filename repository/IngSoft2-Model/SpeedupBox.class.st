Class {
	#name : #SpeedupBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'apply effects' }
SpeedupBox >> affect: positions triggeredOn: aPosition with: board [ 
	board move: aPosition by: 4.

]
