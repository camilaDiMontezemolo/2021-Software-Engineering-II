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
PizzaGame class >> validateBoxes: someBoxes [
	( (someBoxes class) = OrderedCollection) 
	ifFalse: [ 
		((someBoxes percentage) = 1)
		ifFalse:[ Error signal: 'El tablero está incompleto.' ]
		ifTrue: [ ^(someBoxes boxes) ]. ]
	ifTrue: [ ^someBoxes. ]

]

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
	| list |
	list := self validateBoxes: someBoxes.
	self
		validateLaps: someLaps
		boxes: list
		players: somePlayers
		dice: someDice
		andDeck: deck.
	^ self new
		initializeWithBoxes: list players: somePlayers dice: someDice laps: someLaps andDeck: deck
]

{ #category : #'as yet unclassified' }
PizzaGame >> cardFor: playerWhoGetsTheCard [
	| stock |
	stock := cardManager stockOf: playerWhoGetsTheCard.
	cardManager addCardTo: stock.
]

{ #category : #'as yet unclassified' }
PizzaGame >> cardsAffecting: player [ 
	^(cardManager cardsAffecting: player).
]

{ #category : #'as yet unclassified' }
PizzaGame >> changeTurn [
	(currentTurn == (players size)) ifTrue:[currentTurn:=0].
	currentTurn := currentTurn +1.
]

{ #category : #'as yet unclassified' }
PizzaGame >> check: card from: player [
	((card class) = RedoCard)
		ifFalse: [self sendCardErrorFor: player]
		ifTrue:[cardManager verify: card belongsTo: player.]
]

{ #category : #'as yet unclassified' }
PizzaGame >> firstPlace [
	^self ranking first.
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
PizzaGame >> isFinished [
	^board playerSurpassed: laps.
]

{ #category : #'as yet unclassified' }
PizzaGame >> lastTypeOfBoxForPlayer: aPlayer [
	board applyLastTypeOfBoxFor: aPlayer.
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
	self rollFor: (players at: currentTurn).
	self changeTurn.
]

{ #category : #'as yet unclassified' }
PizzaGame >> playTurnForAllPlayers [
	players do: [:player | self playNextTurn ].
]

{ #category : #'as yet unclassified' }
PizzaGame >> player: player wantsToApplyCard: card to: target [
 
	((players at: currentTurn) = player & (players includes: player))
		ifTrue:[ cardManager verify: card belongsTo: player.
					cardManager remove: card fromTheHandOf: player.
					cardManager affect: target with: card]
		ifFalse:[ self check: card from: player. ]

]

{ #category : #'as yet unclassified' }
PizzaGame >> player: player wantsToApplyCard: card toCard: target [
	
	(players includes: player)
	ifTrue:[
	cardManager verify: card belongsTo: player.
	cardManager remove: card fromTheHandOf: player.
	cardManager affectCard: target with: card]
	ifFalse:[ self sendCardErrorFor: player. ]
]

{ #category : #initialize }
PizzaGame >> players [
	^players.
]

{ #category : #'as yet unclassified' }
PizzaGame >> ranking [
	^(board positions) asSortedCollection: [:position1 :position2 | position1 > position2].
]

{ #category : #'as yet unclassified' }
PizzaGame >> rollFor: aPlayer [
	| distance |
	distance := dice spin.
	distance:= distance + (cardManager modifyDistanceOf: aPlayer).
	board changePositionOf: aPlayer by: distance playing: self.
]

{ #category : #'as yet unclassified' }
PizzaGame >> sendCardErrorFor: player [
	(players includes: player)
	ifTrue: [ Error signal: 'Un jugador no puede tirar una carta fuera de su turno.' ]
	ifFalse: [ Error signal: 'Esta persona no es un jugador del juego.' ].
	
]

{ #category : #'as yet unclassified' }
PizzaGame >> usedCards [
	^(cardManager usedCards)
]
