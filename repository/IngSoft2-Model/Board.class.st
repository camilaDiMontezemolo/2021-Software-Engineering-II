Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'size',
		'boxes',
		'positions',
		'laps',
		'players',
		'game',
		'imprisioned',
		'lastEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Board class >> withBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame [
	^self new initializeWithBoxes: aCollectionOfBoxes andSomePlayers: somePlayers forAGame: aGame.
]

{ #category : #effects }
Board >> addSpeedUpToBoxOf: player using: card [

	| position box|
	position := self positionOfPlayer: player.
	box := self boxFor: position.
	box addEffect: SpeedupEffect new using: card.
]

{ #category : #effects }
Board >> addToImprisioned: player [
	imprisioned add: player.
]

{ #category : #effects }
Board >> affectPositionOf: player using: card [

	| position |
	position := self positionOfPlayer: player.
	self addEfectTo: position
]

{ #category : #effects }
Board >> applyEffectFor: aPosition withPreviuosAdvance: distance [

	| box |
	box := self boxFor: aPosition.
	box affect: positions triggeredOn: (aPosition player) on: self withPreviousAdvance: distance.
	lastEffect := box.
]

{ #category : #effects }
Board >> applyLastTypeOfBoxFor: aPlayer [

	| positionOfPlayer |
	positionOfPlayer := self positionOfPlayer: aPlayer.
	lastEffect affect: positions triggeredOn: aPlayer  on: self withPreviousAdvance: 0.
]

{ #category : #effects }
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

{ #category : #gameCollaborations }
Board >> cardFor: playerWhoGetsTheCard [
	game cardFor: playerWhoGetsTheCard.
]

{ #category : #positions }
Board >> change: aPosition by: distance [

	| newAbsolute newPosition |
	newAbsolute := aPosition absoluteLocation + distance.
	newPosition := self verifyImprisonmentOn: aPosition withDistance: newAbsolute.
	^newPosition.
]

{ #category : #positions }
Board >> changePositionOf: aPlayer by: distance [

	| newPosition playerPosition |
	playerPosition := self positionOfPlayer: aPlayer.
	newPosition := self change: playerPosition by: distance.
	game isFinished ifFalse: [ 
		self applyEffectFor: newPosition withPreviuosAdvance: distance ]
]

{ #category : #positions }
Board >> createPositions [
	positions:= players collect: [ :player | (Position of: player at: 0 on: self)].
]

{ #category : #positions }
Board >> generateBoxesWithEffects: effects [
	|boardboxes |
	boardboxes := OrderedCollection new.
	boardboxes := effects collect: [:effect | boardboxes add:(Box createWith: effect)].
	boardboxes addFirst: (Box createWith: (NoEffect new)).
	^boardboxes.
]

{ #category : #positions }
Board >> generatePositionFor: aPosition at: absoluteLocation [
	^(Position of: (aPosition player) at: absoluteLocation on: self).
]

{ #category : #initialize }
Board >> initializeWithBoxes: collectionOfEffects andSomePlayers: somePlayers forAGame: aGame [
	boxes := OrderedCollection new.
	boxes := (self generateBoxesWithEffects: collectionOfEffects).
	size := ( (boxes size)-1 ).
	lastEffect := (NoEffect new).
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
	imprisioned remove: player.
	"self change: playerPosition by: 1."

	


]

{ #category : #positions }
Board >> locationOfPosition: absoluteLocation [.
	^absoluteLocation -((absoluteLocation//size)*size).
]

{ #category : #gameCollaborations }
Board >> maximunToss [
	^(game maximunToss)
]

{ #category : #effects }
Board >> moveAllPlayersToFirstBoxSlot [
	positions do: 
	[:position |self replacePosition: position with:
		( self generatePositionFor: position at: 
			(self calculateNewLocationFor: position))].
]

{ #category : #gameCollaborations }
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

{ #category : #effects }
Board >> removeEffect: target [
	| affectedBoxes |
	affectedBoxes := boxes select: [ :box | box cardsAffecting includes: target].
	affectedBoxes do: [ :box | box removeCard: target ].
]

{ #category : #effects }
Board >> removeFromImprisioned: player [
	imprisioned remove: player.
]

{ #category : #positions }
Board >> replacePosition: position with: newPosition [
	positions at:(positions indexOf: position) put: newPosition.
]

{ #category : #positions }
Board >> verifyImprisonmentOn: aPosition withDistance: newAbsolute [

	| newPosition |
	(imprisioned includes: aPosition player)
		ifTrue: [ newPosition := aPosition ]
		ifFalse: [ 
			newPosition := self generatePositionFor: aPosition at: newAbsolute.
			self replacePosition: aPosition with: newPosition ].
	^ newPosition
]
