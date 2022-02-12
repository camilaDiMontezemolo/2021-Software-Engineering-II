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

{ #category : #initialize }
Deck >> refill: collectionOfCards [
	collectionOfCards do: [:card | cards add: card. ].
]
