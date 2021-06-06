Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'myPlayers',
		'myDie',
		'myBoard',
		'myLaps',
		'myPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> withBoard: aBoard andPlayers: somePlayers andDie: someDie andLaps: someLaps [.
	(somePlayers isEmpty ) ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 jugador.' ].
	(someDie isEmpty ) ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 dado.' 	].
	(someLaps <1 ) ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 vuelta.' 	].
	^self new initializeWithBoard: aBoard andPlayers: somePlayers andDie: someDie andLaps: someLaps.
]

{ #category : #'as yet unclassified' }
Game >> die [
	^myDie.
]

{ #category : #initialize }
Game >> initialize [
	myPlayers := OrderedCollection new.
	myDie:= OrderedCollection new.
]

{ #category : #initialize }
Game >> initializeWithBoard: aBoard andPlayers: somePlayers andDie: someDie andLaps: someLaps [
	myBoard:=aBoard.
	myPlayers:=somePlayers.
	myPositions:= OrderedCollection new.
	myBoard createPositionsFor: myPlayers.
	myDie:=someDie.
	myLaps:=someLaps.
]

{ #category : #'as yet unclassified' }
Game >> isFinished [
	^(myBoard positions) anySatisfy: [ :position | ((position absoluteLocation)//(myBoard sizeOfBoard)) >= myLaps].
]

{ #category : #'as yet unclassified' }
Game >> play [
	[self isFinished] whileFalse:[ 
	(myBoard positions) do: [ :position |
		(self isFinished) 
		ifFalse: [
			 myBoard change: position using: myDie playing: self.
			].
		].
	].
]

{ #category : #'as yet unclassified' }
Game >> players [
	^myPlayers.
]

{ #category : #'as yet unclassified' }
Game >> ranking [
	(myBoard positions) sort: [:a :c | 
		a absoluteLocation > c absoluteLocation].
	^(myBoard positions).
]
