Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'mySize',
		'myPlayers',
		'myDie'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSize: aSize andPlayers: somePlayers andDie: someDie [.
	(aSize < 1) ifTrue: [ Error signal: 'Un tablero no puede tener menos de 1 casilla.' ].
	(somePlayers isEmpty ) ifTrue: [ Error signal: 'Un tablero no puede tener menos de 1 jugador.' ].
	(someDie isEmpty ) ifTrue: [ Error signal: 'Un tablero no puede tener menos de 1 dado.' 	].
	^self new initializeWithSize: aSize andPlayers: somePlayers andDie: someDie.
]

{ #category : #'as yet unclassified' }
Board >> die [
	^myDie.
]

{ #category : #initialize }
Board >> initialize [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
	mySize :=0.
	myPlayers := OrderedCollection new.
	myDie:= OrderedCollection new.
]

{ #category : #initialize }
Board >> initializeWithSize: aSize andPlayers: somePlayers andDie: someDie [
	mySize:=aSize.
	myPlayers:=somePlayers.
	myDie:=someDie.
]

{ #category : #'as yet unclassified' }
Board >> isFinished [
	^myPlayers anySatisfy: [ :player | (player location) >= mySize].
]

{ #category : #'as yet unclassified' }
Board >> play [
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
Board >> players [
	^myPlayers.
]

{ #category : #'as yet unclassified' }
Board >> runTurnFor: aPlayer [
	|distance|
	distance:=0.
	myDie do: [:dice | distance := distance + (dice spin)].
	
	((aPlayer location + distance) < mySize)
		ifTrue: [
		aPlayer setLocation:((aPlayer location) + distance).
		]
		ifFalse: [
			 aPlayer setLocation: mySize 
		].
]

{ #category : #'as yet unclassified' }
Board >> showPositions [
	myPlayers sort: [:a :c | (a location) > (c location)].
	^myPlayers.
]

{ #category : #'as yet unclassified' }
Board >> sizeOfBoard [
	^mySize.
]
