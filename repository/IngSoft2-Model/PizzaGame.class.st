Class {
	#name : #PizzaGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'board',
		'laps',
		'dice',
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
	self validateLaps: someLaps boxes: someBoxes players: somePlayers dice: someDice andDeck: deck.
	^ self new
		initializeWithBoxes: someBoxes players: somePlayers dice: someDice laps: someLaps andDeck: deck
]

{ #category : #BoardCollabs }
PizzaGame >> addEffect: effect ToBoxOf: player using: card [

	board addEffect: effect ToBoxOf: player using: card
]

{ #category : #cardsCollabs }
PizzaGame >> cardFor: playerWhoGetsTheCard [
	| stock |
	stock := cardManager stockOf: playerWhoGetsTheCard.
	cardManager addCardTo: stock.
]

{ #category : #cardsCollabs }
PizzaGame >> cardsAffecting: player [ 
	^(cardManager cardsAffecting: player).
]

{ #category : #turns }
PizzaGame >> changeTurn [
	(currentTurn == (players size)) ifTrue:[currentTurn:=0].
	currentTurn := currentTurn +1.
]

{ #category : #GameManagment }
PizzaGame >> firstPlace [
	^self ranking first.
]

{ #category : #cardsCollabs }
PizzaGame >> handOf: player [
	^(cardManager handOf: player).
]

{ #category : #initialize }
PizzaGame >> initializeWithBoxes: someBoxes players: somePlayers dice: someDie laps: someLaps andDeck: aDeck [
	board:=Board withBoxes: someBoxes andSomePlayers: somePlayers forAGame: self.
	board createPositions.
	players:=somePlayers.
	dice:=someDie.
	laps:=someLaps.
	currentTurn:=1.
	deck := aDeck.
	cardManager := CardManager with: deck in: self.
	cardManager handOutInitialCardsFor: somePlayers.
]

{ #category : #GameManagment }
PizzaGame >> isFinished [
	^board playerSurpassed: laps.
]

{ #category : #BoardCollabs }
PizzaGame >> lastTypeOfBoxForPlayer: aPlayer [
	board applyLastTypeOfBoxFor: aPlayer.
]

{ #category : #GameManagment }
PizzaGame >> liberatePlayer: player [
	
	board liberatePlayer: player.

]

{ #category : #cardsCollabs }
PizzaGame >> maximunToss [
	^(dice maxToss)
]

{ #category : #turns }
PizzaGame >> play [
	[ self isFinished ] whileFalse:
		[ self playTurnForAllPlayers ]
]

{ #category : #turns }
PizzaGame >> playNextTurn [
	self isFinished
		ifTrue: [ ^ self ].
	self rollFor: (players at: currentTurn).
	self changeTurn.
]

{ #category : #turns }
PizzaGame >> playTurnForAllPlayers [
	players do: [:player | self playNextTurn ].
]

{ #category : #cardsCollabs }
PizzaGame >> player: player wantsToApplyCard: card to: target [
	
	(players includes: player)
	ifTrue:[card triggerEffectOn:target  from: cardManager by: player.]
	ifFalse:[Error signal: 'Esta persona no es un jugador del juego.']
]

{ #category : #initialize }
PizzaGame >> players [
	^players.
]

{ #category : #GameManagment }
PizzaGame >> ranking [
	^(board positions) asSortedCollection: [:position1 :position2 | position1 > position2].
]

{ #category : #cardsCollabs }
PizzaGame >> removeEffect: target [.
	board removeEffect: target.
]

{ #category : #turns }
PizzaGame >> rollFor: aPlayer [
	| distance |
	distance := dice spin.
	distance:= distance + (cardManager modifyDistanceOf: aPlayer).
	board changePositionOf: aPlayer by: distance.
]

{ #category : #cardsCollabs }
PizzaGame >> sendCardErrorFor: player [
	(players includes: player)
	ifTrue: [ Error signal: 'Un jugador no puede tirar una carta fuera de su turno.' ]
	ifFalse: [ Error signal: 'Esta persona no es un jugador del juego.' ].
	
]

{ #category : #cardsCollabs }
PizzaGame >> usedCards [
	^(cardManager usedCards)
]

{ #category : #turns }
PizzaGame >> validateTurnOf: player [ 

	((players at: currentTurn) = player)
	ifFalse:[ Error signal: 'Un jugador no puede tirar una carta fuera de su turno.']
]
