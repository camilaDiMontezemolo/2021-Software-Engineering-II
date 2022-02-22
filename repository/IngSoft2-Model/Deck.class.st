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
	^ self new initializeWithCards: aCollectionOfCards.
	
]

{ #category : #cards }
Deck >> drawACard [
	| card |
	card := cards first.
	cards removeFirst.
	^card.
]

{ #category : #initialize }
Deck >> initializeWithCards: aCollectionOfCards [
	cards:= aCollectionOfCards.

]

{ #category : #cards }
Deck >> numberOfCards [
	^(cards size).
]

{ #category : #cards }
Deck >> refill: collectionOfCards [
	cards := collectionOfCards collect: [:card | cards add: card. ].
]
