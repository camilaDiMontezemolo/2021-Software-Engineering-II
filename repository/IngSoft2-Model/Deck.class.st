Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> validate: deck [
	( deck class = OrderedCollection)  
	ifFalse: [ (deck percentage = 1)
						ifFalse:[ Error signal: 'El maso está incompleto.' ]
						ifTrue: [ ^deck cards]].
	^deck
	
]

{ #category : #'instance creation' }
Deck class >> withCards: aCollectionOfCards [
	^ self new initializeWithCards: (self validate: aCollectionOfCards).
	
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
	collectionOfCards do: [:card | cards add: card. ].
]
