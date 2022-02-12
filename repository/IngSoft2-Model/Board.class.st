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
		'imprisioned'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Board class >> withBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame [
	^self new initializeWithBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame.
]

{ #category : #effects }
Board >> addToImprisioned: player [
	imprisioned add: player.
]

{ #category : #effects }
Board >> applyEffectFor: aPosition [
	| box |
	box := self boxFor: aPosition.
	box affect: positions triggeredOn: aPosition with: self.
	lastBoxUsed:=box.
]

{ #category : #effects }
Board >> applyLastTypeOfBoxFor: aPlayer [ 
	| positionOfPlayer |
	positionOfPlayer := self positionOfPlayer: aPlayer.
	lastBoxUsed affect: positions triggeredOn: positionOfPlayer with: self. 
]

{ #category : #'as yet unclassified' }
Board >> boxFor: aPosition [
	^ boxes at:
			((aPosition absoluteLocation) - (size*((aPosition absoluteLocation)//size)))+1.
]

{ #category : #positions }
Board >> calculateNewLocationFor: position [
	|newLaps|
	newLaps := ((position absoluteLocation)//(size)).
	
	(newLaps ==0)
	ifTrue:[^0.]
	ifFalse:[^(size*newLaps)+1.].
]

{ #category : #effects }
Board >> cardFor: playerWhoGetsTheCard [
	game cardFor: playerWhoGetsTheCard.
]

{ #category : #'as yet unclassified' }
Board >> change: aPosition by: distance [
	| newAbsolute newPosition|
	newAbsolute:= (aPosition absoluteLocation) +distance.
	(imprisioned includes: aPosition player)
	ifTrue:[newPosition := aPosition]
	ifFalse:[newPosition:= (self generatePositionFor: aPosition at: newAbsolute).
	self replacePosition: aPosition with: newPosition].
   ^newPosition.
		
	
		
]

{ #category : #positions }
Board >> changePositionOf: aPlayer by: distance [
	|newPosition playerPosition|
	playerPosition:= (positions select: [:position | position player= aPlayer ]) first.
	newPosition := self change: playerPosition by: distance.
	(game isFinished)
			ifFalse: [self applyEffectFor: newPosition].
]

{ #category : #positions }
Board >> createPositions [
	positions:= players collect: [ :player | (Position of: player at: 0 on: self)].
]

{ #category : #positions }
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
	imprisioned := Set new.
]

{ #category : #positions }
Board >> lapsOfPosition: absoluteLocation [.
	^absoluteLocation//size.
]

{ #category : #effects }
Board >> liberatePlayer: player [

	|playerPosition|
	playerPosition := self positionOfPlayer: player.
	self change: playerPosition by: 1.

	


]

{ #category : #positions }
Board >> locationOfPosition: absoluteLocation [.
	^absoluteLocation -((absoluteLocation//size)*size).
]

{ #category : #effects }
Board >> moveAllPlayersToFirstBoxSlot [
	positions do: 
	[:position |self replacePosition: position with:
		( self generatePositionFor: position at: 
			(self calculateNewLocationFor: position))].
]

{ #category : #'as yet unclassified' }
Board >> playerSurpassed: someLaps [
	^(self positions) anySatisfy: [ :position | ((position absoluteLocation)//size) >= someLaps].
]

{ #category : #positions }
Board >> positionOfPlayer: aPlayer [
	^(positions select: [: position| (position player)=aPlayer]) first.
]

{ #category : #positions }
Board >> positions [
	^positions.
]

{ #category : #positions }
Board >> replacePosition: position with: newPosition [
	positions at:(positions indexOf: position) put: newPosition.
]
