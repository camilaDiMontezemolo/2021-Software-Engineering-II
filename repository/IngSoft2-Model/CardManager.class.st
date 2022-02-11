Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'lastCardUsed',
		'cardRegister',
		'game',
		'deck',
		'usedCards',
		'playersStockTakings'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardManager class >> with: initialCards in: aGame [
	^self new initializeWithCards: initialCards in: aGame.
]

{ #category : #stockManagment }
CardManager >> add: card toHandOf: player [
	| neededStock |
	neededStock := self stockOf: player.
	neededStock addToHand: card.
]

{ #category : #stockManagment }
CardManager >> addCardTo: oneStock [
	| newCard |
	newCard := deck drawACard.
	oneStock addToHand: newCard.
]

{ #category : #applyCardsEffects }
CardManager >> affect: target with: card of: player [

	| neededStocks |
	neededStocks := playersStockTakings select: [:stock| (target includes: (stock owner)) | (stock owner = target)].
	neededStocks do: [ :oneStock | oneStock addToCardsAffectingPlayer: card.].
	self usedCards add: card.
	self lastCardUsed: card.
	self remove: card fromHandOf: player.
]

{ #category : #applyCardsEffects }
CardManager >> cancellateTarget: target usig: card from: player [
	| neededStocks|
	self validateCancellationFor: target.
	neededStocks := playersStockTakings select: [:stock| (stock cardsAffecting) includes: target].
	neededStocks do:
		[ :oneStock | oneStock removeCardAffectingPlayer: target.].
	self remove: card fromHandOf: player. 
]

{ #category : #stockManagment }
CardManager >> cardsAffecting: player [
	| neededList |
	neededList := (self stockOf: player).
	^(neededList cardsAffecting).
]

{ #category : #stocksCreation }
CardManager >> createHandsFor: thePlayersOfThisGame [
	| n |
	n:=0.
	thePlayersOfThisGame do:
		[ :onePlayer | playersStockTakings add: (Stocktaking for: onePlayer). ].
]

{ #category : #stockManagment }
CardManager >> handOf: player [ 
	^(self stockOf: player) hand.
]

{ #category : #stocksCreation }
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
]

{ #category : #applyCardsEffects }
CardManager >> lastCardUsed [
	^lastCardUsed.
]

{ #category : #applyCardsEffects }
CardManager >> lastCardUsed: newCard [
	lastCardUsed:= newCard.
	
]

{ #category : #applyCardsEffects }
CardManager >> lastTypeOfBoxForPlayer: aPlayer [
	game lastTypeOfBoxForPlayer: aPlayer.
]

{ #category : #applyCardsEffects }
CardManager >> liberatePlayer: aPlayer [
	game liberatePlayer: aPlayer.
]

{ #category : #applyCardsEffects }
CardManager >> modifyDistanceOf: player [ 
	| playerCards finalDistance|
	finalDistance:=0.
	playerCards := (self cardsAffecting: player).
	playerCards do: [:card| finalDistance:= finalDistance +(card applyEffectFrom: self).].
	^finalDistance.
]

{ #category : #stockManagment }
CardManager >> remove: card fromHandOf: player [
	| neededStock |
	neededStock := self stockOf: player.
	neededStock removeOfHand: card.
]

{ #category : #stockManagment }
CardManager >> stockOf: player [ 
	| neededStock |
	neededStock := (playersStockTakings select: [:stock| stock owner = player]) first.
	^neededStock.
]

{ #category : #applyCardsEffects }
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

{ #category : #stockManagment }
CardManager >> verify: card belongsTo: player [
	| neededStock |
	neededStock := self stockOf: player.
	(neededStock verifyBelongsToPlayerHand: card)
	ifFalse: [ Error signal: 'Un jugador no puede tirar una que no es suya' ].
]
