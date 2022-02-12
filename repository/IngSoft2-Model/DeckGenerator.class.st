Class {
	#name : #DeckGenerator,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DeckGenerator class >> with: aNumberOfCards for: collectionOfCards [
	^ self new initializeWithANumberOfCards: aNumberOfCards for:collectionOfCards.
]

{ #category : #cardsCreation }
DeckGenerator >> createCardFor: collectionOfTypes [
	|randomCards |
	randomCards := collectionOfTypes shuffled.
	cards add: (randomCards first).
]

{ #category : #initialization }
DeckGenerator >> initializeWithANumberOfCards: aNumberOfCards for: collectionOfTypes [
	| n |
	cards := OrderedCollection new.
	n:=0.
	[n< aNumberOfCards] whileTrue: [self createCardFor: collectionOfTypes.
	n:= n+1.].
	^cards.

]
