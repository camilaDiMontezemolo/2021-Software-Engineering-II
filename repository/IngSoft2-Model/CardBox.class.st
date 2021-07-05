Class {
	#name : #CardBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardBox >> affect: positions triggeredOn: aPosition with: board [ 
	| playerWhoGetsTheCard |
	playerWhoGetsTheCard := (aPosition player).
	board getACardFor: playerWhoGetsTheCard.
	
	
	
	"cardManager handOutASingleCardFor: playerWhoGetsTheCard
	newCards:= DeckGenerator forPlayer: playerWhoGetsTheCard give: 1.
	board newCardsWereAdded: newCards."

]
