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
Game >> change: aPosition [
	myBoard change: aPosition rolling: myDie.
	(self isFinished)
			ifTrue: [ aPosition changeLocation: (myBoard sizeOfBoard) ]
			ifFalse: [myBoard applyEffectFor: aPosition and: myPositions.].
	(self isFinished)
			ifTrue: [ aPosition changeLocation: (myBoard sizeOfBoard) ]
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
	myPositions := myPlayers collect: [ :player | (Position of: player)].
	myDie:=someDie.
	myLaps:=someLaps.
]

{ #category : #'as yet unclassified' }
Game >> isFinished [
	^myPositions  anySatisfy: [ :position | (position lap) >= myLaps].
]

{ #category : #'as yet unclassified' }
Game >> play [
	[self isFinished] whileFalse:[ 
	myPositions do: [ :position |
		(self isFinished) 
		ifFalse: [
			 self change: position.
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
	myPositions sort: [:a :c | 
		(a lap = (c lap))
			ifTrue: [ (a location) > (c location)]
			ifFalse:[ (a lap) > (c lap)].
		].
	^myPositions.
]
