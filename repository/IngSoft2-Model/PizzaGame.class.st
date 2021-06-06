Class {
	#name : #PizzaGame,
	#superclass : #Object,
	#instVars : [
		'myPlayers',
		'myBoard',
		'myLaps',
		'myPositions',
		'myDice'
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
PizzaGame >> dice [
	^myDice.
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
]

{ #category : #'as yet unclassified' }
PizzaGame >> isFinished [
	^(myBoard positions) anySatisfy: [ :position | ((position absoluteLocation)//(myBoard sizeOfBoard)) >= myLaps].
]

{ #category : #'as yet unclassified' }
PizzaGame >> play [
	[self isFinished] whileFalse:[ 
	(myBoard positions) do: [ :position |
		(self isFinished) 
		ifFalse: [
			 self rollFor: position.
			].
		].
	].
]

{ #category : #'as yet unclassified' }
PizzaGame >> players [
	^myPlayers.
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
	myBoard change: aPosition using: distance playing: self.
]
