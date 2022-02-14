Class {
	#name : #CardEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardEffect >> affect: positions triggeredOn: aPosition on: board withPreviousAdvance: distance [ 
	| playerWhoGetsTheCard |
	playerWhoGetsTheCard := (aPosition player).
	board cardFor: playerWhoGetsTheCard.
	

]
