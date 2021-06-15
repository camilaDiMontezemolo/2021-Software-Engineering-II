Class {
	#name : #CardGenerator,
	#superclass : #Object,
	#classVars : [
		'amountOfCardsToGive',
		'myCards',
		'temporalHand'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardGenerator class >> forPlayer: testPlayers give: aNumberOfCards [
	((testPlayers size) < 1 ) ifTrue: [ Error signal: 'Un deck no puede tener menos de 1 jugadores.' ].
	(aNumberOfCards < 1 ) ifTrue: [ Error signal: 'Un deck no puede tener menos de 1 carta.' ].
	^self new initializeWithPlayers: testPlayers and: aNumberOfCards.

]

{ #category : #'as yet unclassified' }
CardGenerator >> distributeCardsFor: onePlayer [
	|randomCards|
	randomCards:=OrderedCollection with: (AccelerationCard of: onePlayer on: '') with: (CancellationCard of: onePlayer on: '') with: (OverloadCard of: onePlayer on: '') with: (RedoCard of: onePlayer on: '') with: (RepeatCard of: onePlayer on: '') with:(SpeedUpCard of: onePlayer on: '').
	
	randomCards := randomCards shuffled.
	temporalHand add: (randomCards at: 1).

]

{ #category : #'as yet unclassified' }
CardGenerator >> initializeWithPlayers: testPlayers and: aNumberOfCards [
	myCards := OrderedCollection new.
	temporalHand:= OrderedCollection new.
	
	testPlayers do:
		[ :onePlayer | [temporalHand size < aNumberOfCards]
			whileTrue: [self distributeCardsFor: onePlayer].
		myCards addAll: temporalHand.
		temporalHand removeAll.].
	^ myCards
]
