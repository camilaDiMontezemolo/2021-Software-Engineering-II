Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'lastCardUsed',
		'cardRegister',
		'myGame',
		'myDeck',
		'usedCards',
		'playersStockTakings'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardManager class >> with: initialCards in: aGame [
	^self new initializeWithCards: initialCards in: aGame.
]

{ #category : #'as yet unclassified' }
CardManager >> addCardFromRedoCard: newCards [
	usedCards add: newCards.
	"dealtCards addAll: myNewCards."
]

{ #category : #'as yet unclassified' }
CardManager >> affect: target with: card [

	| neededStocks |
	neededStocks := playersStockTakings select: [:stock| (target includes: (stock owner)) | (stock owner = target)].
	neededStocks do:
		[ :oneStock | oneStock AddToCardsAffectingPlayer: card. 
							self usedCards add: card].
	
	
	
	
"assignCard: card to: affectedPlayer with: currentTurnPlayer

	| newCard |
	newCard := self createNewCard: card withAffectedPlayer: affectedPlayer.
	newCard instant
		ifTrue: [ self replaceInstantCard: card withCard: newCard ]
		ifFalse: [ self compareOwnerOfCard: card withThePayerOfCurrentTurn: currentTurnPlayer 	generating: newCard ]"
	
]

{ #category : #'as yet unclassified' }
CardManager >> affectCard: target with: card [
	card cancellateCard: target from: self. 
	
	"| neededStocks |
	neededStocks := playersStockTakings select: [:stock| (target includes: (stock owner)) | (stock owner = target)].
	neededStocks do:
		[ :oneStock | oneStock AddToCardsAffectingPlayer: card. ]."
	
	
	
	
"assignCard: card to: affectedPlayer with: currentTurnPlayer

	| newCard |
	newCard := self createNewCard: card withAffectedPlayer: affectedPlayer.
	newCard instant
		ifTrue: [ self replaceInstantCard: card withCard: newCard ]
		ifFalse: [ self compareOwnerOfCard: card withThePayerOfCurrentTurn: currentTurnPlayer 	generating: newCard ]"
	
]

{ #category : #'as yet unclassified' }
CardManager >> assignCard: card to: affectedPlayer with: currentTurnPlayer [
"Se reemplaza con affect: with:"

	| newCard |
	newCard := self createNewCard: card withAffectedPlayer: affectedPlayer.
	newCard instant
		ifTrue: [ self replaceInstantCard: card withCard: newCard ]
		ifFalse: [ self compareOwnerOfCard: card withThePayerOfCurrentTurn: currentTurnPlayer 	generating: newCard ]
	
]

{ #category : #'as yet unclassified' }
CardManager >> cancellateCard: aCard [
	| neededStocks|
	neededStocks := playersStockTakings select: [:stock| (stock getCardsAffecting) includes: aCard].
	neededStocks do:
		[ :oneStock | oneStock removeCardAffectingPlayer: aCard.].
	"usedCards remove: aCard ifAbsent: [ Error signal: 'No se puede cancelar una carta que no está en deck']."
]

{ #category : #'as yet unclassified' }
CardManager >> check: card andRaiseErrorOf: target [
	card class = AccelerationCard
		ifTrue: [
			(target = myGame players)
				ifFalse: [ Error signal: 'La acceleration card debe tener a todos los otros jugadores como target.' ]. ]
]

{ #category : #'as yet unclassified' }
CardManager >> compareOwnerOfCard: card withThePayerOfCurrentTurn: currentTurnPlayer generating: newCard [
	card owner = currentTurnPlayer
		ifTrue: [ self replace: card with: newCard ]
		ifFalse: [ Error
				signal: 'Un jugador no puede tirar una carta fuera de su turno.' ]
]

{ #category : #'as yet unclassified' }
CardManager >> createHandsFor: thePlayersOfThisGame [
	| n |
	n:=0.
	thePlayersOfThisGame do:
		[ :onePlayer | playersStockTakings add: (Stocktaking for: onePlayer). ].
]

{ #category : #'as yet unclassified' }
CardManager >> findLastTypeOfBoxForPlayer: aPlayer [
	myGame findLastTypeOfBoxForPlayer: aPlayer.
]

{ #category : #'as yet unclassified' }
CardManager >> getCardsAffecting: player [
	| neededList |
	neededList := (playersStockTakings select: [:stock| stock owner = player]) first.
	^(neededList getCardsAffecting).
]

{ #category : #'as yet unclassified' }
CardManager >> getHandOf: player [ 
	| neededStock |
	neededStock := (playersStockTakings select: [:stock| stock owner = player]) first.
	^(neededStock getHand).
]

{ #category : #'as yet unclassified' }
CardManager >> giveACardTo: oneStock [
	| newCard |
	newCard := myDeck drawACard.
	oneStock addToHand: newCard.
]

{ #category : #'as yet unclassified' }
CardManager >> handOutInitialCardsFor: thePlayersOfThisGame [
	| n |
	self createHandsFor: thePlayersOfThisGame.
	n:=0.
	playersStockTakings do:
		[ :oneStock | [n<2] whileTrue: [self giveACardTo: oneStock.
		n:= n+1.].
		n:=0.
	].
]

{ #category : #initialize }
CardManager >> initializeWithCards: initialDeck in: aGame [
	myDeck := initialDeck.
	myGame := aGame.
	playersStockTakings := OrderedCollection new.
	usedCards := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
CardManager >> lastCardUsed: newCard [
	lastCardUsed:= newCard.
	
]

{ #category : #'as yet unclassified' }
CardManager >> modifyDistanceOf: player [ 
	| playerCards finalDistance|
	finalDistance:=0.
	"playerCards := (self findCardsAffecting: player)."
	playerCards := (self getCardsAffecting: player).
	playerCards do: [:card| finalDistance:= finalDistance +(card applyEffectFrom: self).].
	^finalDistance.
]

{ #category : #'as yet unclassified' }
CardManager >> redoTheLastCardUsedBy:owner for: affectedPlayer [
	^((lastCardUsed class) of: owner on: affectedPlayer).
]

{ #category : #'as yet unclassified' }
CardManager >> replace: card with: newCard [  
	usedCards add: newCard.
	dealtCards remove: card.
	

]

{ #category : #'as yet unclassified' }
CardManager >> replaceInstantCard: card withCard: newCard [
	self replace: card with: newCard.
	newCard applyEffectFrom: self.
	self cancellateCard: newCard.
	

]

{ #category : #'as yet unclassified' }
CardManager >> usedCards [
	^usedCards
]
