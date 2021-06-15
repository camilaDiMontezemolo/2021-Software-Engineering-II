Class {
	#name : #CardBoxLoaded,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardBoxLoaded class >> loadedWith: someCards [ 
^self new initializeLoaded: someCards.
]

{ #category : #'as yet unclassified' }
CardBoxLoaded >> affect: positions triggeredOn: aPosition with: board [ 
	| playerWhoGetsTheCard newCards |
	playerWhoGetsTheCard := OrderedCollection with: (aPosition player).
	newCards:= OrderedCollection with: (SpeedUpCard of: #napolitana on: '').
	"newCards:= CardGenerator forPlayer: playerWhoGetsTheCard give: 1."
	board saveNewCards: newCards.

]

{ #category : #'as yet unclassified' }
CardBoxLoaded >> initializeLoaded: someCards [

]
