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
		'deck',
		'currentTurn'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PizzaGame class >> withBoard: aBoard andPlayers: somePlayers andDie: someDie andLaps: someLaps [.
	(somePlayers isEmpty ) ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 jugador.' ].
	(someDie isEmpty ) ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 dado.' 	].
	(someLaps <1 ) ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 vuelta.' 	].
	^self new initializeWithBoard: aBoard andPlayers: somePlayers andDie: someDie andLaps: someLaps.
]

{ #category : #'as yet unclassified' }
PizzaGame class >> withBoard: aBoard players: players dice: dice laps: laps andCards: cards [
	(players isEmpty ) ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 jugador.' ].
	(dice isEmpty ) ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 dado.' 	].
	(laps <1 ) ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 vuelta.' 	].
	^self new initializeWithBoard: aBoard players: players dice:dice laps: laps andCards: cards.
]

{ #category : #'as yet unclassified' }
PizzaGame >> applyCard: card to: affectedPlayer [
	deck assignCard: card to: affectedPlayer.
]

{ #category : #'as yet unclassified' }
PizzaGame >> changeTurn [
	(currentTurn == (myPlayers size)) ifTrue:[currentTurn:=0].
	currentTurn := currentTurn +1.
]

{ #category : #'as yet unclassified' }
PizzaGame >> findLastTypeOfBoxForPlayer: aPlayer [
	myBoard applyLastTypeOfBoxFor: aPlayer.
]

{ #category : #'as yet unclassified' }
PizzaGame >> firstPlace [
	^self ranking at: 1.
]

{ #category : #initialize }
PizzaGame >> initializeWithBoard: aBoard andPlayers: somePlayers andDie: someDie andLaps: someLaps [
	myBoard:=aBoard.
	myPlayers:=somePlayers.
	myPositions:= OrderedCollection new.
	myBoard createPositionsFor: myPlayers.
	myDice:=someDie.
	myLaps:=someLaps.
	currentTurn:=1.
	deck:= Deck with: (OrderedCollection new) in: self.
]

{ #category : #initialize }
PizzaGame >> initializeWithBoard: aBoard players: somePlayers dice: someDie laps: someLaps andCards: initialCards [ 
	myBoard:=aBoard.
	myPlayers:=somePlayers.
	myPositions:= OrderedCollection new.
	myBoard createPositionsFor: myPlayers.
	myDice:=someDie.
	myLaps:=someLaps.
	currentTurn:=1.
	deck := Deck with: initialCards in: self.
]

{ #category : #'as yet unclassified' }
PizzaGame >> isFinished [
	^(myBoard positions) anySatisfy: [ :position | ((position absoluteLocation)//(myBoard sizeOfBoard)) >= myLaps].
]

{ #category : #'as yet unclassified' }
PizzaGame >> oneRound [
	myBoard positions do:
		[ :position | self runOneTurn ]
]

{ #category : #'as yet unclassified' }
PizzaGame >> play [
	[ self isFinished ] whileFalse:
		[ self oneRound ]
]

{ #category : #'as yet unclassified' }
PizzaGame >> ranking [
	(myBoard positions) sort: [:a :c | 
		a absoluteLocation > c absoluteLocation].
	^(myBoard positions).
]

{ #category : #'as yet unclassified' }
PizzaGame >> rollFor: aPosition [
	| distance |
	distance := 0.
	myDice do: [ :dice | distance := distance + dice spin ].
	distance:= distance + (deck modifyDistanceOf: (aPosition player)).
	myBoard change: aPosition using: distance playing: self.
]

{ #category : #'as yet unclassified' }
PizzaGame >> runOneTurn [
	^ self isFinished
		ifFalse: [ self rollFor:((myBoard positions) at:currentTurn).
					  self changeTurn.]
		ifTrue: [ ].
]