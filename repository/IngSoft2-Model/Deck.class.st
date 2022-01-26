Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> withCards: aCollectionOfCards [
	^ self new initializeWithCards: aCollectionOfCards
	
]

{ #category : #'as yet unclassified' }
Deck >> drawACard [
	| card |
	"myCards isEmpty ifTrue: [ Error signal: 'Ya no hay más cartas a repartir.' ]."
	card := cards first.
	cards removeFirst.
	^card.
]

{ #category : #initialize }
Deck >> initializeWithCards: aCollectionOfCards [
	cards:= aCollectionOfCards.

]

{ #category : #initialize }
Deck >> numberOfCards [
	^(cards size).
]
