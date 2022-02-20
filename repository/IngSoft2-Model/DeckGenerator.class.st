Class {
	#name : #DeckGenerator,
	#superclass : #Object,
	#instVars : [
		'cards',
		'size'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DeckGenerator class >> give: aSize for: cardTypes with: probabilities [
	self validate: probabilities.
	^ self new initializeWithSize: aSize for: cardTypes with: probabilities.
]

{ #category : #'instance creation' }
DeckGenerator class >> validate: probabilities [
	| sum |
	sum := 0. 
	probabilities do: [:oneProba | sum := sum + oneProba].
	(sum = 1)
	ifFalse: [ Error signal: 'Las suma de probabilidades debe ser 1.'  ]
]

{ #category : #'instance creation' }
DeckGenerator class >> with: aNumberOfCards for: collectionOfCards [
	^ self new initializeWithANumberOfCards: aNumberOfCards for:collectionOfCards.
]

{ #category : #cardsCreation }
DeckGenerator >> add: aPercentage of: aCardType [
	| index |
	index := 1.
	[(index <= (size *aPercentage)) & (cards size < size)] whileTrue:[
			cards add: aCardType new.
			index := index +1.].
	cards := cards shuffled.
	^cards.
]

{ #category : #cardsCreation }
DeckGenerator >> completeEffectList [
	(cards size < size)
		ifTrue: [ (cards size) to: (size) do: [:card | cards add: (((cards first) class) new) ]].	
]

{ #category : #cardsCreation }
DeckGenerator >> createCardFor: collectionOfTypes [
	|randomCards |
	randomCards := collectionOfTypes shuffled.
	cards add: (randomCards first).
]

{ #category : #cardsCreation }
DeckGenerator >> createEffectsr: cardTypes with: probabilities [
	| index |
	index := 1.
	[ index <= cardTypes size ]
		whileTrue: [ self add: (probabilities at: index) of: (cardTypes at: index).
			index := index + 1 ]
]

{ #category : #initialization }
DeckGenerator >> initializeWithANumberOfCards: aNumberOfCards for: collectionOfTypes [
	| n |
	cards := OrderedCollection new.
	n:=0.
	[n< aNumberOfCards] whileTrue: [self createCardFor: collectionOfTypes.
	n:= n+1.].
	^cards.

]

{ #category : #initialization }
DeckGenerator >> initializeWithSize: aSize for: cardTypes with: probabilities [
	size := aSize - 1.
	cards := OrderedCollection new.
	self createEffectsr: cardTypes with: probabilities.
	self completeEffectList.
	^ cards

]
