Class {
	#name : #PizzaGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'board',
		'laps',
		'positions',
		'dice',
		'cards',
		'currentTurn',
		'cardManager',
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PizzaGame class >> validateLaps: someLaps boxes: someBoxes players: somePlayers dice: someDice andDeck: aDeck [
	someDice size< 1
		ifTrue: [ Error signal: 'Un juego no puede tener menos de un dado' ].
	somePlayers isEmpty
		ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 jugador.' ].
	someLaps < 1
		ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 vuelta.' ].
	someBoxes size < 1
		ifTrue: [ Error signal: 'Un juego no puede tener menos de 1 casillero.' ].
	(aDeck numberOfCards < (2* (somePlayers size)))
		ifTrue: [ Error signal: 'Un juego no puede tener menos de 2 cartas por jugador.' ]. 
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

{ #category : #cardsManagment }
PizzaGame >> addCard: playerWhoGetsTheCard [
	| stock |
	stock := cardManager stockOf: playerWhoGetsTheCard.
	cardManager addCardTo: stock.
]

{ #category : #cardsManagment }
PizzaGame >> cardsAffecting: player [ 
	^(cardManager cardsAffecting: player).
]

{ #category : #turnsManagment }
PizzaGame >> changeTurn [
	(currentTurn == (players size)) ifTrue:[currentTurn:=0].
	currentTurn := currentTurn +1.
]

{ #category : #gameMethods }
PizzaGame >> firstPlace [
	^self ranking first.
]

{ #category : #cardsManagment }
PizzaGame >> handOf: player [
	^(cardManager handOf: player).
]

{ #category : #initialize }
PizzaGame >> initializeWithBoxes: someBoxes players: somePlayers dice: someDie laps: someLaps andDeck: aDeck [
	board:=Board withBoxes: someBoxes andSomePlayers: somePlayers forAGame: self.
	players:=somePlayers.
	positions:= OrderedCollection new.
	board createPositions.
	dice:=someDie.
	laps:=someLaps.
	currentTurn:=1.
	deck := aDeck.
	cardManager := CardManager with: deck in: self.
	cardManager handOutInitialCardsFor: somePlayers.
]

{ #category : #gameMethods }
PizzaGame >> isFinished [
	^board playerSurpassed: laps.
]

{ #category : #boardCollaborators }
PizzaGame >> lastTypeOfBoxForPlayer: aPlayer [
	board applyLastTypeOfBoxFor: aPlayer.
]

{ #category : #boardCollaborators }
PizzaGame >> liberatePlayer: aPlayer [
	board freePlayer: aPlayer.
]

{ #category : #gameMethods }
PizzaGame >> maximunToss [
	^(dice maxToss) 
	
]

{ #category : #turnsManagment }
PizzaGame >> play [
	[ self isFinished ] whileFalse:
		[ self playTurnForAllPlayers ]
]

{ #category : #turnsManagment }
PizzaGame >> playNextTurn [
	self isFinished
		ifTrue: [ ^ self ].
	self rollFor: (players at: currentTurn).
	self changeTurn.
]

{ #category : #turnsManagment }
PizzaGame >> playTurnForAllPlayers [
	players do: [:player | self playNextTurn ].
]

{ #category : #cardsManagment }
PizzaGame >> player: player wantsToApplyCard: card to: target [
	
	(players includes: player)
	ifTrue:[card triggerEffectOn:target  from: cardManager by: player.]
	ifFalse:[Error signal: 'Esta persona no es un jugador del juego.']
]

{ #category : #initialize }
PizzaGame >> players [
	^players.
]

{ #category : #gameMethods }
PizzaGame >> ranking [
	^(board positions) asSortedCollection: [:position1 :position2 | position1 > position2].
]

{ #category : #turnsManagment }
PizzaGame >> rollFor: aPlayer [
	| distance |
	distance := dice spin.
	distance:= distance + (cardManager modifyDistanceOf: aPlayer).
	board changePositionOf: aPlayer by: distance playing: self.
]

{ #category : #cardsManagment }
PizzaGame >> usedCards [
	^(cardManager usedCards)
]

{ #category : #turnsManagment }
PizzaGame >> validateTurnOf: player [
	((players at: currentTurn) = player)
	ifFalse:[ Error signal: 'Un jugador no puede tirar una carta fuera de su turno.']
]
