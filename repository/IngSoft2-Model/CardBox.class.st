Class {
	#name : #CardBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardBox >> affect: positions triggeredOn: aPosition with: board [ 
	| playerWhoGetsTheCard |
	playerWhoGetsTheCard := aPosition player.
	board cardFor: playerWhoGetsTheCard.
	

]
