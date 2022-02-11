Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'size',
		'boxes',
		'positions',
		'laps',
		'lastBoxUsed',
		'players',
		'game',
		'lastPlayerDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Board class >> withBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame [
	^self new initializeWithBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame.
]

{ #category : #gameCollaborators }
Board >> addCard: playerWhoGetsTheCard [
	game addCard: playerWhoGetsTheCard.
]

{ #category : #boxesCollaborator }
Board >> applyEffectFor: aPosition [
	| box |
	box := self boxFor: aPosition.
	box affect: positions triggeredOn: aPosition with: self.
	lastBoxUsed:=box.
]

{ #category : #boxesCollaborator }
Board >> applyLastTypeOfBoxFor: aPlayer [ 
	| positionOfPlayer |
	positionOfPlayer := self positionOfPlayer: aPlayer.
	lastBoxUsed affect: positions triggeredOn: positionOfPlayer with: self. 
]

{ #category : #boxesCollaborator }
Board >> boxFor: aPosition [
	^ boxes at:
			((aPosition absoluteLocation) - (size*((aPosition absoluteLocation)//size)))+1.
]

{ #category : #location }
Board >> calculateNewLocationFor: position [
	|newLaps|
	newLaps := ((position absoluteLocation)//(size)).
	
	(newLaps ==0)
	ifTrue:[^0.]
	ifFalse:[^(size*newLaps)+1.].
]

{ #category : #positionMethods }
Board >> change: aPosition by: distance [
	| newAbsolute newPosition|
   newAbsolute:= (aPosition absoluteLocation) +distance.
	newPosition:= (self generatePositionFor: aPosition at: newAbsolute).
	self replacePosition: aPosition with: newPosition.
   ^newPosition.
		
	
		
]

{ #category : #positionMethods }
Board >> changePositionOf: aPlayer by: distance playing: pizzaGame [
	|newPosition playerPosition actualBox|
	playerPosition:= (positions select: [:position | position player= aPlayer ]) first.
	actualBox := self boxFor: playerPosition.
	newPosition := self change: playerPosition by: distance.
	lastPlayerDistance := distance.
	(pizzaGame isFinished)
			ifFalse: [self applyEffectFor: newPosition].
]

{ #category : #positionMethods }
Board >> createPositions [
	positions:= players collect: [ :player | (Position of: player at: 0 on: self)].
]

{ #category : #gameCollaborators }
Board >> freePlayer: aPlayer [
	 Error signal: 'prueba'.
]

{ #category : #positionMethods }
Board >> generatePositionFor: aPosition at: absoluteLocation [
	^(Position of: (aPosition player) at: absoluteLocation on: self).
]

{ #category : #initialize }
Board >> initializeWithBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame [
	boxes := OrderedCollection new.
	boxes := aCollectionOfBoxes.
	boxes addFirst: (NoEffectBox new).
	size := ( (boxes size)-1 ).
	lastBoxUsed := (NoEffectBox new).
	players:= somePlayers.
	game:=aGame.
]

{ #category : #location }
Board >> lapsOfPosition: absoluteLocation [.
	^absoluteLocation//size.
]

{ #category : #positionMethods }
Board >> lastPlayerDistance [
	^lastPlayerDistance
]

{ #category : #location }
Board >> locationOfPosition: absoluteLocation [.
	^absoluteLocation -((absoluteLocation//size)*size).
]

{ #category : #gameCollaborators }
Board >> maximunToss [
	^(game maximunToss)
]

{ #category : #positionMethods }
Board >> move: aPosition by: aDistance [
	self replacePosition: aPosition 
					with: (self generatePositionFor: aPosition at: (aPosition absoluteLocation)+aDistance).
					
]

{ #category : #boxesCollaborator }
Board >> moveAllPlayersToFirstBoxSlot [
	positions do: 
	[:position |self replacePosition: position with:
		( self generatePositionFor: position at: 
			(self calculateNewLocationFor: position))].
]

{ #category : #gameCollaborators }
Board >> playerSurpassed: someLaps [
	^(self positions) anySatisfy: [ :position | ((position absoluteLocation)//size) >= someLaps].
]

{ #category : #positionMethods }
Board >> positionOfPlayer: aPlayer [
	^(positions select: [: position| (position player)=aPlayer]) first.
]

{ #category : #positionMethods }
Board >> positions [
	^positions.
]

{ #category : #positionMethods }
Board >> replacePosition: position with: newPosition [
	positions at:(positions indexOf: position) put: newPosition.
]
