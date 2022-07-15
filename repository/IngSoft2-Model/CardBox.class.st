Class {
	#name : #CardBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'apply effects' }
CardBox >> affect: positions triggeredOn: aPosition with: board [ 
	| playerWhoGetsTheCard |
	playerWhoGetsTheCard := aPosition player.
	board cardFor: playerWhoGetsTheCard.
	

]
