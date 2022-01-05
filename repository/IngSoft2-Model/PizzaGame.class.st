Class {
	#name : #PizzaGame,
	#superclass : #Object,
	#instVars : [
		'myPlayers',
		'myBoard',
		'myLaps',
		'myPositions',
		'myDice',
		'myCards',
		'currentTurn',
		'myCardManager',
		'myDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PizzaGame class >> validateLaps: someLaps boxes: someBoxes players: somePlayers dice: someDice andDeck: aDeck [
	somePlayers isEmpty
		ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 jugador.' ].
	someDice isEmpty
		ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 dado.' ].
	someLaps < 1
		ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 vuelta.' ].
	someBoxes size < 1
		ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 casillero.' ].
	(aDeck numberOfCards < 2)
		ifTrue: [ Error signal: 'Un juego no puede tener menos de 2 cartas.' ].
]

{ #category : #'instance creation' }
PizzaGame class >> withBoxes: someBoxes players: somePlayers dice: someDice laps: someLaps andDeck: deck [
	self
		validateLaps: someLaps
		boxes: someBoxes
		players: somePlayers
		dice: someDice
		andDeck: deck.
	^ self new
		initializeWithBoxes: someBoxes players: somePlayers dice: someDice laps: someLaps andDeck: deck
]

{ #category : #'as yet unclassified' }
PizzaGame >> applyCard: theIndexOfCard to: affectedPlayer [
	myCardManager assignCard: theIndexOfCard to: affectedPlayer with: (myPlayers at: currentTurn).

"applyCard: card to: affectedPlayer
	myCardManager assignCard: card to: affectedPlayer with: (myPlayers at: currentTurn)."
	
	
	
]

{ #category : #'as yet unclassified' }
PizzaGame >> board [
	^myBoard.
]

{ #category : #'as yet unclassified' }
PizzaGame >> changeTurn [
	(currentTurn == (myPlayers size)) ifTrue:[currentTurn:=0].
	currentTurn := currentTurn +1.
]

{ #category : #'as yet unclassified' }
PizzaGame >> findLastTypeOfBoxForPlayer: aPlayer [
	myBoard applyLastTypeOfBoxFor: aPlayer.
]

{ #category : #'as yet unclassified' }
PizzaGame >> firstPlace [
	^self ranking first.
]

{ #category : #'as yet unclassified' }
PizzaGame >> getACardFor: playerWhoGetsTheCard [
	myCardManager giveACardTo: playerWhoGetsTheCard.
]

{ #category : #initialize }
PizzaGame >> initializeWithBoxes: someBoxes players: somePlayers dice: someDie laps: someLaps andDeck: deck [
	myBoard:=Board withBoxes: someBoxes andSomePlayers: somePlayers forAGame: self.
	myPlayers:=somePlayers.
	myPositions:= OrderedCollection new.
	myBoard createPositions.
	myDice:=someDie.
	myLaps:=someLaps.
	currentTurn:=1.
	myDeck := deck.
	myCardManager := CardManager with: deck in: self.
	myCardManager handOutInitialCardsFor: somePlayers.
]

{ #category : #'as yet unclassified' }
PizzaGame >> isFinished [
	^myBoard hasAnyPlayerSurpassed: myLaps.
]

{ #category : #'as yet unclassified' }
PizzaGame >> play [
	[ self isFinished ] whileFalse:
		[ self playTurnForAllPlayers ]
]

{ #category : #accessing }
PizzaGame >> playNextTurn [
	self isFinished
		ifTrue: [ ^ self ].
	self rollFor: (myPlayers at: currentTurn).
	self changeTurn.
]

{ #category : #'as yet unclassified' }
PizzaGame >> playTurnForAllPlayers [
	myPlayers do: [:player | self playNextTurn ].
]

{ #category : #'as yet unclassified' }
PizzaGame >> player: player wantsToApplyCard: card to: target [
	(((myPlayers at: currentTurn) = player| (card instant)) & (myPlayers includes: player))
	ifTrue:[
	myCardManager assignCard: card to: target with: player.]
	ifFalse:[
		self sendCardErrorFor: player.
	]
	
]

{ #category : #'as yet unclassified' }
PizzaGame >> playerHand: player [ 
	^(myCardManager findCardsBelonging: player).
]

{ #category : #initialize }
PizzaGame >> players [
	^myPlayers.
]

{ #category : #'as yet unclassified' }
PizzaGame >> ranking [
	^(myBoard positions) asSortedCollection: [:position1 :position2 | position1 > position2].
]

{ #category : #'as yet unclassified' }
PizzaGame >> rollFor: aPlayer [
	| distance |
	distance := 0.
	myDice do: [ :dice | distance := distance + dice spin ].
	distance:= distance + (myCardManager modifyDistanceOf: aPlayer).
	myBoard changePositionOf: aPlayer by: distance playing: self.
]

{ #category : #'as yet unclassified' }
PizzaGame >> sendCardErrorFor: player [
	(myPlayers includes: player)
	ifTrue: [ Error signal: 'Un jugador no puede tirar una carta fuera de su turno.' ]
	ifFalse: [ Error signal: 'Esta persona no es un jugador del juego.' ].
	
]

{ #category : #'as yet unclassified' }
PizzaGame >> usedCards [
	^(myCardManager usedCards)
]
