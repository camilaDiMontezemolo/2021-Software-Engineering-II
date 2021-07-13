Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'lastCardUsed',
		'cardRegister',
		'myGame',
		'myDeck',
		'dealtCards',
		'usedCards'
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
CardManager >> assign: aCard to: onePlayer [ 
	| newCard |
	newCard := self createNewCard: aCard withOwner: onePlayer.
	dealtCards add: newCard.
]

{ #category : #'as yet unclassified' }
CardManager >> assignCard: card to: affectedPlayer with: currentTurnPlayer [
	| newCard |
	newCard := self createNewCard: card withAffectedPlayer: affectedPlayer.
	newCard instant
		ifTrue: [ self replaceInstantCard: card withCard: newCard ]
		ifFalse: [ self
				checkMplayerOf: card
				withCurrentTurn: currentTurnPlayer
				generating: newCard ]
			
]

{ #category : #'as yet unclassified' }
CardManager >> check: card andRaiseErrorOf: target [
	card class = AccelerationCard
		ifTrue: [
			(target = myGame players)
				ifFalse: [ Error signal: 'La acceleration card debe tener a todos los otros jugadores como target.' ]. ]
]

{ #category : #'as yet unclassified' }
CardManager >> checkMplayerOf: card withCurrentTurn: currentTurnPlayer generating: newCard [
	card owner = currentTurnPlayer
		ifTrue: [ self replace: card with: newCard ]
		ifFalse: [ Error
				signal: 'Un jugador no puede tirar una carta fuera de su turno.' ]
]

{ #category : #'as yet unclassified' }
CardManager >> createNewCard: card withAffectedPlayer: target [
	self check: card andRaiseErrorOf: target.
	^ card class of: card owner on: target
]

{ #category : #'as yet unclassified' }
CardManager >> createNewCard: card withOwner: aPlayer [
	((card class) = CancellationCard)
	ifTrue:[^(card class of: aPlayer on: EmptyCard new).]
	ifFalse:[^(card class of: aPlayer on:'').]
]

{ #category : #'as yet unclassified' }
CardManager >> findCardsAffecting: player [
	^usedCards select: [:card| card usedOn: player].
]

{ #category : #'as yet unclassified' }
CardManager >> findCardsBelonging: player [
	^dealtCards select: [:card| card owner = player].
]

{ #category : #'as yet unclassified' }
CardManager >> findLastTypeOfBoxForPlayer: aPlayer [
	myGame findLastTypeOfBoxForPlayer: aPlayer.
]

{ #category : #'as yet unclassified' }
CardManager >> giveACardTo: onePlayer [
	| newCard |
	newCard := myDeck drawACard.
	self assign: newCard to: onePlayer.
]

{ #category : #'as yet unclassified' }
CardManager >> handOutASingleCardFor: thePlayerOfThisTurn [
	self giveACardTo: thePlayerOfThisTurn.

"Lo malo de que existe giveACardTo es que tecnicamente puedo darme una carta desde fuera del juego, lo que rompe el enclapsulamiento. Quizas es mejor ELIMINAR este metodo y hacer todo dentro del do? el problema de eso es que queda feo"
]

{ #category : #'as yet unclassified' }
CardManager >> handOutInitialCardsFor: thePlayersOfThisGame [
	| n |
	n:=0.
	thePlayersOfThisGame do:
		[ :onePlayer | [n<2] whileTrue: [self giveACardTo: onePlayer.
		n:= n+1.].
		n:=0.
	].

"Lo malo de que existe giveACardTo es que tecnicamente puedo darme una carta desde fuera del juego, lo que rompe el enclapsulamiento. Quizas es mejor ELIMINAR este metodo y hacer todo dentro del do? el problema de eso es que queda feo"
]

{ #category : #initialize }
CardManager >> initializeWithCards: initialDeck in: aGame [
	myDeck := initialDeck.
	myGame := aGame.
	dealtCards := OrderedCollection new.
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
	playerCards := (self findCardsAffecting: player).
	playerCards do: [:card| finalDistance:= finalDistance +(card applyEffectFrom: self).].
	^finalDistance.
]

{ #category : #'as yet unclassified' }
CardManager >> redoTheLastCardUsedBy:owner for: affectedPlayer [
	^((lastCardUsed class) of: owner on: affectedPlayer).
]

{ #category : #'as yet unclassified' }
CardManager >> removeCard: aCard [
	usedCards remove: aCard ifAbsent: [ Error signal: 'No se puede cancelar una carta que no está en deck'].
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
	self removeCard: newCard.
]

{ #category : #'as yet unclassified' }
CardManager >> usedCards [
	^usedCards
]
