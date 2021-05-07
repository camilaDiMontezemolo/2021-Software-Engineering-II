Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'myPlayers',
		'myDie',
		'myBoard',
		'myLaps'
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
Game >> applyEffectFor: aPlayer [
	| box |
	box := myBoard boxes at: aPlayer location.
	(box isKindOf: MultVictimBox)
		ifTrue: [ box affect: myPlayers and: myBoard ]
		ifFalse: [ box affect: aPlayer and: myBoard ]
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
	myDie:=someDie.
	myLaps:=someLaps.
]

{ #category : #'as yet unclassified' }
Game >> isFinished [
	| winner |
	(myPlayers anySatisfy: [ :player | (player laps) >= myLaps])
	ifTrue: [
		winner:= myPlayers select: [ :player | (player laps) >= myLaps].
		(winner at:1) setLocation: (myBoard sizeOfBoard).
	].
	^myPlayers anySatisfy: [ :player | (player laps) >= myLaps].
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
	| distance |
	distance := 0.
	myDie do: [ :dice | distance := distance + dice spin ].
	(aPlayer location + distance < myBoard sizeOfBoard)
		ifTrue: [ 
			aPlayer setLocation: aPlayer location + distance.]
		ifFalse: [
			aPlayer
			setLocation: distance - (myBoard sizeOfBoard - aPlayer location).
			aPlayer increaseLaps.].
	self applyEffectFor: aPlayer.
]

{ #category : #'as yet unclassified' }
Game >> showPositions [
	myPlayers sort: [:a :c | (a location) > (c location)].
	^myPlayers.
]
