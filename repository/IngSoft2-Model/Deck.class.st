Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'amountOfCardsToGive',
		'myCards',
		'temporalHand',
		'theAlreadyDrawnCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Deck class >> forPlayer: testPlayers give: aNumberOfCards [
	self validatePlayers: testPlayers andNumberOfCards: aNumberOfCards.
	^ self new initializeWithPlayers: testPlayers and: aNumberOfCards
]

{ #category : #'as yet unclassified' }
Deck class >> validatePlayers: testPlayers andNumberOfCards: aNumberOfCards [
	testPlayers size < 1
		ifTrue: [ Error signal: 'Un deck no puede tener menos de 1 jugadores.' ].
	aNumberOfCards < 1
		ifTrue: [ Error signal: 'Un deck no puede tener menos de 1 carta.' ]
]

{ #category : #'as yet unclassified' }
Deck class >> withCards: aCollectionOfCards [
	^ self new initializeWithCards: aCollectionOfCards
	
"falta hacer el validate, eliminar los 2 de arriba"
]

{ #category : #'as yet unclassified' }
Deck >> cards [
	^myCards
]

{ #category : #'as yet unclassified' }
Deck >> drawACard [
	| card |
	myCards isEmpty ifTrue: [ Error signal: 'Ya no hay más cartas a repartir.' ].
	card := myCards first.
	myCards removeFirst.
	^card.
]

{ #category : #'as yet unclassified' }
Deck >> initializeWithCards: aCollectionOfCards [
	myCards:= aCollectionOfCards.

]
