Class {
	#name : #PizzaGame,
	#superclass : #Object,
	#instVars : [
		'myPlayers',
		'myBoard',
		'myLaps',
		'myPositions',
		'myDice',
		'myCards',
		'myDeck',
		'currentTurn'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
PizzaGame class >> validateLaps: someLaps boxes: someBoxes players: somePlayers andDice: someDice [
	somePlayers isEmpty
		ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 jugador.' ].
	someDice isEmpty
		ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 dado.' ].
	someLaps < 1
		ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 vuelta.' ].
	someBoxes size < 1
		ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 casillero.' ]
]

{ #category : #'as yet unclassified' }
PizzaGame class >> withBoxes: someBoxes players: somePlayers dice: someDice laps: someLaps andCards: initialCards [
	self
		validateLaps: someLaps
		boxes: someBoxes
		players: somePlayers
		andDice: someDice.
	^ self new
		initializeWithBoxes: someBoxes players: somePlayers dice: someDice laps: someLaps andCards: initialCards
]

{ #category : #'as yet unclassified' }
PizzaGame >> applyCard: card to: affectedPlayer [
	myDeck assignCard: card to: affectedPlayer with: (myPlayers at: currentTurn).
	
	
	
]

{ #category : #'as yet unclassified' }
PizzaGame >> board [
	^myBoard.
]

{ #category : #'as yet unclassified' }
PizzaGame >> changeTurn [
	(currentTurn == (myPlayers size)) ifTrue:[currentTurn:=0].
	currentTurn := currentTurn +1.
]

{ #category : #'as yet unclassified' }
PizzaGame >> collectCardsFromrBoxes [
	((myBoard cardsForGame) isEmpty)
	ifFalse: [ myDeck addCards: myBoard cardsForGame.].
	myBoard resetBoxCards.

]

{ #category : #'as yet unclassified' }
PizzaGame >> findLastTypeOfBoxForPlayer: aPlayer [
	myBoard applyLastTypeOfBoxFor: aPlayer.
]

{ #category : #'as yet unclassified' }
PizzaGame >> firstPlace [
	^self ranking first.
]

{ #category : #initialize }
PizzaGame >> initializeWithBoxes: someBoxes players: somePlayers dice: someDie laps: someLaps andCards: initialCards [
	myBoard:=Board withBoxes: someBoxes andSomePlayers: somePlayers forAGame: self.
	myPlayers:=somePlayers.
	myPositions:= OrderedCollection new.
	myBoard createPositions.
	myDice:=someDie.
	myLaps:=someLaps.
	currentTurn:=1.
	myDeck := Deck with: initialCards in: self.
]

{ #category : #'as yet unclassified' }
PizzaGame >> isFinished [
	^myBoard hasAnyPlayerSurpassed: myLaps.
]

{ #category : #'as yet unclassified' }
PizzaGame >> play [
	[ self isFinished ] whileFalse:
		[ self playTurnForAllPlayers ]
]

{ #category : #accessing }
PizzaGame >> playNextTurn [
	self isFinished
		ifTrue: [ ^ self ].
	self rollFor: (myPlayers at: currentTurn).
	self changeTurn.
	self collectCardsFromrBoxes.
]

{ #category : #'as yet unclassified' }
PizzaGame >> playTurnForAllPlayers [
	myPlayers do: [:player | self playNextTurn ].
]

{ #category : #'as yet unclassified' }
PizzaGame >> ranking [
	^(myBoard positions) asSortedCollection: [:position1 :position2 | position1 > position2].
]

{ #category : #'as yet unclassified' }
PizzaGame >> rollFor: aPlayer [
	| distance |
	distance := 0.
	myDice do: [ :dice | distance := distance + dice spin ].
	distance:= distance + (myDeck modifyDistanceOf: aPlayer).
	myBoard changePositionOf: aPlayer by: distance playing: self.
]
