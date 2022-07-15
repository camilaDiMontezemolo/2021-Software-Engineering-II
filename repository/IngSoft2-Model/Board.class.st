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
		'game'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Board class >> withBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame [
	^self new initializeWithBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame.
]

{ #category : #'apply effects' }
Board >> applyEffectFor: aPosition [
	| box |
	box := self boxFor: aPosition.
	box affect: positions triggeredOn: aPosition with: self.
	lastBoxUsed:=box.
]

{ #category : #'apply effects' }
Board >> applyLastTypeOfBoxFor: aPlayer [ 
	| positionOfPlayer |
	positionOfPlayer := self positionOfPlayer: aPlayer.
	lastBoxUsed affect: positions triggeredOn: positionOfPlayer with: self. 
]

{ #category : #positioning }
Board >> boxFor: aPosition [
	^ boxes at:
			((aPosition absoluteLocation) - (size*((aPosition absoluteLocation)//size)))+1.
]

{ #category : #positioning }
Board >> calculateNewLocationFor: position [
	|newLaps|
	newLaps := (position absoluteLocation)//size.
	(newLaps ==0)
		ifTrue:[^0.]
		ifFalse:[^(size*newLaps)+1.].
]

{ #category : #'apply effects' }
Board >> cardFor: playerWhoGetsTheCard [
	game cardFor: playerWhoGetsTheCard.
]

{ #category : #positioning }
Board >> change: aPosition by: distance [
	| newAbsolute newPosition|
   newAbsolute:= (aPosition absoluteLocation) +distance.
	newPosition:= self generatePositionFor: aPosition at: newAbsolute.
	self replacePosition: aPosition with: newPosition.
   ^newPosition.
		
	
		
]

{ #category : #positioning }
Board >> changePositionOf: aPlayer by: distance playing: game [
	|newPosition playerPosition|
	playerPosition:= (positions select: [:position | position player= aPlayer ]) first.
	newPosition := self change: playerPosition by: distance.
	(game isFinished)
			ifFalse: [self applyEffectFor: newPosition].
]

{ #category : #positioning }
Board >> createPositions [
	positions:= players collect: [ :player | Position of: player at: 0 on: self].
]

{ #category : #positioning }
Board >> generatePositionFor: aPosition at: absoluteLocation [
	^Position of: (aPosition player) at: absoluteLocation on: self.
]

{ #category : #initialize }
Board >> initializeWithBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame [
	boxes := OrderedCollection new.
	boxes := aCollectionOfBoxes.
	boxes addFirst: NoEffectBox new.
	size :=(boxes size)-1 .
	lastBoxUsed := NoEffectBox new.
	players:= somePlayers.
	game:=aGame.
]

{ #category : #positioning }
Board >> lapsOfPosition: absoluteLocation [.
	^absoluteLocation//size.
]

{ #category : #positioning }
Board >> locationOfPosition: absoluteLocation [.
	^absoluteLocation -((absoluteLocation//size)*size).
]

{ #category : #positioning }
Board >> move: aPosition by: aDistance [
	self replacePosition: aPosition 
					with: (self generatePositionFor: aPosition at: (aPosition absoluteLocation)+aDistance).
					
]

{ #category : #positioning }
Board >> moveAllPlayersToFirstBoxSlot [
	positions do: 
	[:position |self replacePosition: position with:
		( self generatePositionFor: position at: 
			(self calculateNewLocationFor: position))].
]

{ #category : #checking }
Board >> playerSurpassed: someLaps [
	^(self positions) anySatisfy: [ :position | ((position absoluteLocation)//size) >= someLaps].
]

{ #category : #positioning }
Board >> positionOfPlayer: aPlayer [
	^(positions select: [: position| (position player)=aPlayer]) first.
]

{ #category : #positioning }
Board >> positions [
	^positions.
]

{ #category : #positioning }
Board >> replacePosition: position with: newPosition [
	positions at:(positions indexOf: position) put: newPosition.
]
