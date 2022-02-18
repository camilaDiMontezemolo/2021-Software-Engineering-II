Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'lastCardUsed',
		'cardRegister',
		'game',
		'deck',
		'usedCards',
		'playersStockTakings',
		'discardedCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardManager class >> with: initialCards in: aGame [
	^self new initializeWithCards: initialCards in: aGame.
]

{ #category : #stocking }
CardManager >> add: card toHandOf: player [
	| neededStock |
	neededStock := self stockOf: player.
	neededStock addToHand: card.
]

{ #category : #stocking }
CardManager >> addCardTo: oneStock [

	self checkStateOfDeck.
	(deck numberOfCards > 0)
	ifTrue:[oneStock addToHand: (deck drawACard)]
]

{ #category : #cardsMethods }
CardManager >> addEffect: effect ToBoxOf: player using: card [

	game addEffect: effect ToBoxOf: player using: card.
	self usedCards add: card.
	self lastCardUsed: card
]

{ #category : #gameCollaborations }
CardManager >> affect: target with: card of: player [

	| neededStocks |
	neededStocks := playersStockTakings select: [:stock| (target includes: (stock owner)) | (stock owner = target)].
	neededStocks do: [ :oneStock | oneStock addToCardsAffectingPlayer: card.].
	self usedCards add: card.
	self lastCardUsed: card.
	self remove: card fromHandOf: player.
	
]

{ #category : #cardsMethods }
CardManager >> cancellateTarget: target using: card from: player [

	self remove: target.
	self remove: card fromHandOf: player
]

{ #category : #stocking }
CardManager >> cardsAffecting: player [
	| neededList |
	neededList := (self stockOf: player).
	^(neededList cardsAffecting).
]

{ #category : #deckCollaborations }
CardManager >> checkStateOfDeck [

	deck numberOfCards = 0 ifFalse: [ ^ self ].
	discardedCards shuffle.
	deck refill: discardedCards.
	discardedCards removeAll: discardedCards
]

{ #category : #stocking }
CardManager >> createHandsFor: thePlayersOfThisGame [
	| n |
	n:=0.
	playersStockTakings := thePlayersOfThisGame collect: [ :onePlayer | playersStockTakings add: (Stocktaking for: onePlayer). ].
]

{ #category : #stocking }
CardManager >> handOf: player [ 
	^(self stockOf: player) hand.
]

{ #category : #stocking }
CardManager >> handOutInitialCardsFor: thePlayersOfThisGame [
	| n |
	self createHandsFor: thePlayersOfThisGame.
	n:=0.
	playersStockTakings do:
		[ :oneStock | [n<2] whileTrue: [self addCardTo: oneStock.
		n:= n+1.].
		n:=0.
	].
]

{ #category : #initialize }
CardManager >> initializeWithCards: initialDeck in: aGame [
	deck := initialDeck.
	game := aGame.
	playersStockTakings := OrderedCollection new.
	usedCards := OrderedCollection new.
	discardedCards := OrderedCollection new.
]

{ #category : #cardsMethods }
CardManager >> lastCardUsed [
	^lastCardUsed.
]

{ #category : #cardsMethods }
CardManager >> lastCardUsed: newCard [
	discardedCards add: newCard.
	lastCardUsed:= newCard.
	
]

{ #category : #gameCollaborations }
CardManager >> lastTypeOfBoxForPlayer: aPlayer [
	game lastTypeOfBoxForPlayer: aPlayer.
]

{ #category : #gameCollaborations }
CardManager >> liberatePlayer: player [

	game liberatePlayer: player.


	
]

{ #category : #gameCollaborations }
CardManager >> modifyDistanceOf: player [ 
	| playerCards finalDistance|
	finalDistance:=0.
	playerCards := (self cardsAffecting: player).
	playerCards do: [:card| finalDistance:= finalDistance +(card applyEffectFrom: self).].
	^finalDistance.
]

{ #category : #cardsMethods }
CardManager >> remove: target [

	| neededStocks |
	neededStocks := playersStockTakings select: [ :stock | 
		                stock cardsAffecting includes: target ].
	neededStocks do: [ :oneStock | 
		oneStock removeCardAffectingPlayer: target ]
]

{ #category : #stocking }
CardManager >> remove: card fromHandOf: player [
	| neededStock |
	neededStock := self stockOf: player.
	neededStock removeOfHand: card.
]

{ #category : #cardsMethods }
CardManager >> removeEffectBy: target using: card by: player [

	self validateCancellationFor: target.
	game removeEffect: target.
	self remove: card fromHandOf: player
]

{ #category : #stocking }
CardManager >> stockOf: player [ 
	| neededStock |
	neededStock := (playersStockTakings select: [:stock| stock owner = player]) first.
	^neededStock.
]

{ #category : #cardsMethods }
CardManager >> usedCards [
	^usedCards
]

{ #category : #cardsValidations }
CardManager >> validateAllPlayersIn: target [
	(game players = target) 
	ifFalse: [Error signal: 'La acceleration card debe tener a todos los otros jugadores como target.'].
]

{ #category : #cardsValidations }
CardManager >> validateCancellationFor: target [

		(usedCards includes: target)
		ifFalse:[Error signal: 'No es una carta válida para cancelar.' ].
	
]

{ #category : #cardsValidations }
CardManager >> validatePermanentCard: card of: player [
	self verify: card belongsTo: player.
	game validateTurnOf: player.
	
]

{ #category : #cardsValidations }
CardManager >> validateinstant: card of: player [
	self verify: card belongsTo: player.
]

{ #category : #cardsValidations }
CardManager >> verify: card belongsTo: player [
	| neededStock |
	neededStock := self stockOf: player.
	(neededStock verifyBelongsToPlayerHand: card)
	ifFalse: [ Error signal: 'Un jugador no puede tirar una que no es suya' ].
]
