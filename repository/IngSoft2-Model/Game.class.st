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
Game >> applyEffectFor: aPlayer [
	| box affectedPlayers |
	box := myBoard boxes at: (aPlayer location+1).
	(box isKindOf: MultVictimBox)
		ifTrue: [ 
			affectedPlayers:= myPlayers.
			(box isKindOf: MoonWalkBox) 
				ifTrue: [ 
					affectedPlayers:= 
						(myPlayers select: 
							[:player| 
								(player equals: aPlayer) not
							]
						)
				].
			box affect: affectedPlayers and: myBoard
			]
		ifFalse: [ box affect: aPlayer and: myBoard ].
]

{ #category : #'as yet unclassified' }
Game >> change: aPosition [
	| aPlayer |
	myBoard change: aPosition rolling: myDie.
	aPlayer:= aPosition player.	
	(self isFinished)
			ifTrue: [ aPosition changeLocation: (myBoard sizeOfBoard) ]
			ifFalse: [self applyEffectFor: aPlayer.].
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
	myPlayers do: [ :player | myPositions add: (Position of: player)].
	myDie:=someDie.
	myLaps:=someLaps.
]

{ #category : #'as yet unclassified' }
Game >> isFinished [
	^myPositions  anySatisfy: [ :position | (position lap) >= myLaps].
]

{ #category : #'as yet unclassified' }
Game >> play [
	myPositions do: [ :position |
		(self isFinished) 
		ifFalse: [
			 self change: position.
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
Game >> positions [
	^myPositions.
]

{ #category : #'as yet unclassified' }
Game >> showPositions [
	myPositions sort: [:a :c | 
		(a lap = (c lap))
			ifTrue: [ (a location) > (c location)]
			ifFalse:[ (a lap) > (c lap)].
		].
	^myPositions.
]
