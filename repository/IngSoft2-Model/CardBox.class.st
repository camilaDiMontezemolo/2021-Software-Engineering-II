Class {
	#name : #CardBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardBox class >> loadedWith: someCards [ 
^self new initializeLoaded: someCards.
]

{ #category : #'as yet unclassified' }
CardBox >> affect: positions triggeredOn: aPosition with: board [ 
	| playerWhoGetsTheCard newCards |
	playerWhoGetsTheCard := OrderedCollection with: (aPosition player).
	newCards:= CardGenerator forPlayer: playerWhoGetsTheCard give: 1.
	board newCardswereAdded: newCards.

]

{ #category : #'as yet unclassified' }
CardBox >> initializeLoaded: someCards [

]
