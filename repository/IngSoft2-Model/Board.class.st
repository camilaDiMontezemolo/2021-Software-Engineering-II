Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'mySize',
		'myBoxes',
		'positions',
		'mylaps',
		'lastBoxUsed',
		'myPlayers',
		'myGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Board class >> withBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame [
	^self new initializeWithBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame.
]

{ #category : #'as yet unclassified' }
Board >> applyEffectFor: aPosition [
	| box |
	box := self findBoxFor: aPosition.
	box affect: positions triggeredOn: aPosition with: self.
	lastBoxUsed:=box.
]

{ #category : #'as yet unclassified' }
Board >> applyLastTypeOfBoxFor: aPlayer [ 
	| positionOfPlayer |
	positionOfPlayer := self findPositionOfPlayer: aPlayer.
	lastBoxUsed affect: positions triggeredOn: positionOfPlayer with: self. 
]

{ #category : #'as yet unclassified' }
Board >> calculateNewLocationFor: position [
	|laps|
	laps:= ((position absoluteLocation)//(mySize)).
	
	(laps ==0)
	ifTrue:[^0.]
	ifFalse:[^(mySize*laps)+1.].
]

{ #category : #'as yet unclassified' }
Board >> change: aPosition by: distance [
	| newAbsolute newPosition|
   newAbsolute:= (aPosition absoluteLocation) +distance.
	newPosition:= (self generatePositionFor: aPosition at: newAbsolute).
	self replacePosition: aPosition with: newPosition.
   ^newPosition.
		
	
		
]

{ #category : #'as yet unclassified' }
Board >> changePositionOf: aPlayer by: distance playing: game [
	|newPosition playerPosition|
	playerPosition:= (positions select: [:position | position player= aPlayer ]) first.
	newPosition := self change: playerPosition by: distance.
	(game isFinished)
			ifFalse: [self applyEffectFor: newPosition].
]

{ #category : #'as yet unclassified' }
Board >> createPositions [
	positions:= myPlayers collect: [ :player | (Position of: player at: 0 on: self)].
]

{ #category : #'as yet unclassified' }
Board >> findBoxFor: aPosition [
	^ myBoxes at:
			((aPosition absoluteLocation) - (mySize*((aPosition absoluteLocation)//mySize)))+1.
]

{ #category : #'as yet unclassified' }
Board >> findPositionOfPlayer: aPlayer [
	^(positions select: [: position| (position player)=aPlayer]) first.
]

{ #category : #'as yet unclassified' }
Board >> generatePositionFor: aPosition at: absoluteLocation [
	^(Position of: (aPosition player) at: absoluteLocation on: self).
]

{ #category : #'as yet unclassified' }
Board >> getACardFor: playerWhoGetsTheCard [
	myGame getACardFor: playerWhoGetsTheCard.
]

{ #category : #'as yet unclassified' }
Board >> giveMeTheLapsOfThisPosition: absoluteLocation [.
	^absoluteLocation//mySize.
]

{ #category : #'as yet unclassified' }
Board >> giveMeTheLocationOfThisPosition: absoluteLocation [.
	^absoluteLocation -((absoluteLocation//mySize)*mySize).
]

{ #category : #'as yet unclassified' }
Board >> hasAnyPlayerSurpassed: someLaps [
	^(self positions) anySatisfy: [ :position | ((position absoluteLocation)//mySize) >= someLaps].
]

{ #category : #initialize }
Board >> initializeWithBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame [
	myBoxes := OrderedCollection new.
	myBoxes := aCollectionOfBoxes.
	myBoxes addFirst: (NoEffectBox new).
	mySize := ( (myBoxes size)-1 ).
	lastBoxUsed := (NoEffectBox new).
	myPlayers:= somePlayers.
	myGame:=aGame.
]

{ #category : #'as yet unclassified' }
Board >> move: aPosition by: aDistance [
	self replacePosition: aPosition 
					with: (self generatePositionFor: aPosition at: (aPosition absoluteLocation)+aDistance).
					
]

{ #category : #'as yet unclassified' }
Board >> moveAllPlayersToFirstBoxSlot [
	positions do: 
	[:position |self replacePosition: position with:
		( self generatePositionFor: position at: 
			(self calculateNewLocationFor: position))].
]

{ #category : #'as yet unclassified' }
Board >> positions [
	^positions.
]

{ #category : #'as yet unclassified' }
Board >> replacePosition: position with: newPosition [
	positions at:(positions indexOf: position) put: newPosition.
]
