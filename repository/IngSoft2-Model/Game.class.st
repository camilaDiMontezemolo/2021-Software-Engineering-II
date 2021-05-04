Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'myPlayers',
		'myDie',
		'myBoard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> withBoard: aBoard andPlayers: somePlayers andDie: someDie [.
	(somePlayers isEmpty ) ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 jugador.' ].
	(someDie isEmpty ) ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 dado.' 	].
	^self new initializeWithBoard: aBoard andPlayers: somePlayers andDie: someDie.
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
Game >> initializeWithBoard: aBoard andPlayers: somePlayers andDie: someDie [
	myBoard:=aBoard.
	myPlayers:=somePlayers.
	myDie:=someDie.
]

{ #category : #'as yet unclassified' }
Game >> isFinished [
	^myPlayers anySatisfy: [ :player | (player location) >=  (myBoard sizeOfBoard)].
]

{ #category : #'as yet unclassified' }
Game >> play [
	myPlayers do: [ :player |
		(self isFinished) 
		ifFalse: [
			 self runTurnFor: player.
			].
		].
	(self isFinished )
	ifFalse: [^(self play)]
	ifTrue:[^(self showPositions)].
]

{ #category : #'as yet unclassified' }
Game >> players [
	^myPlayers.
]

{ #category : #'as yet unclassified' }
Game >> runTurnFor: aPlayer [
	|distance|
	distance:=0.
	myDie do: [:dice | distance := distance + (dice spin)].
	
	((aPlayer location + distance) < (myBoard sizeOfBoard))
		ifTrue: [
		aPlayer setLocation:((aPlayer location) + distance).
		]
		ifFalse: [
			 aPlayer setLocation: (myBoard sizeOfBoard).
		].
]

{ #category : #'as yet unclassified' }
Game >> showPositions [
	myPlayers sort: [:a :c | (a location) > (c location)].
	^myPlayers.
]
