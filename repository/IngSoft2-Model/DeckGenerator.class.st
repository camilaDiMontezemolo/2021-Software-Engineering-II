Class {
	#name : #DeckGenerator,
	#superclass : #Object,
	#classVars : [
		'amountOfCardsToGive',
		'myCards',
		'temporalHand'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
DeckGenerator class >> forPlayer: testPlayers give: aNumberOfCards [
	self validatePlayers: testPlayers andNumberOfCards: aNumberOfCards.
	^ self new initializeWithPlayers: testPlayers and: aNumberOfCards
]

{ #category : #'as yet unclassified' }
DeckGenerator class >> validatePlayers: testPlayers andNumberOfCards: aNumberOfCards [
	testPlayers size < 1
		ifTrue: [ Error signal: 'Un deck no puede tener menos de 1 jugadores.' ].
	aNumberOfCards < 1
		ifTrue: [ Error signal: 'Un deck no puede tener menos de 1 carta.' ]
]

{ #category : #'as yet unclassified' }
DeckGenerator >> distributeCardsFor: onePlayer [
	|randomCards emptyCard |
	emptyCard := EmptyCard new.
	randomCards:=OrderedCollection 
		with: (AccelerationCard of: onePlayer on: '') 
		with: (CancellationCard of: onePlayer on: emptyCard) 
		with: (OverloadCard of: onePlayer on: '') 
		with: (RedoCard of: onePlayer on: '') 
		with: (RepeatCard of: onePlayer on: '') with:(SpeedUpCard of: onePlayer on: '').
	
	randomCards := randomCards shuffled.
	temporalHand add: (randomCards first).

]

{ #category : #'as yet unclassified' }
DeckGenerator >> initializeWithPlayers: testPlayers and: aNumberOfCards [
	myCards := OrderedCollection new.
	temporalHand:= OrderedCollection new.
	
	testPlayers do:
		[ :onePlayer | [temporalHand size < aNumberOfCards]
			whileTrue: [self distributeCardsFor: onePlayer].
		myCards addAll: temporalHand.
		temporalHand removeAll.].
	^ myCards
]
