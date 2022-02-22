Class {
	#name : #DeckGeneretor,
	#superclass : #Object,
	#instVars : [
		'size',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DeckGeneretor class >> give: aSize for: cardTypes with: probabilities [.
	self validate: probabilities.
	^ self new initializeWithSize: aSize for: cardTypes with: probabilities.
]

{ #category : #'instance creation' }
DeckGeneretor class >> validate: probabilities [
	| sum |
	sum := 0. 
	probabilities do: [:oneProba | sum := sum + oneProba].
	(sum = 1)
	ifFalse: [ Error signal: 'Las suma de probabilidades debe ser 1.'  ]
]

{ #category : #'set up' }
DeckGeneretor >> add: aPercentage of: aCardType [
	| index |
	index := 1.
	[(index <= (size *aPercentage)) & (cards size < size)] whileTrue:[
			cards add: aCardType new.
			index := index +1.].
	cards := cards shuffled.
	^cards.
		 
]

{ #category : #'set up' }
DeckGeneretor >> completeBoard [
	(cards size < size)
		ifTrue: [ (cards size) to: (size) do: [:emptyBox | cards add: (((cards first) class) new) ].	].
]

{ #category : #'set up' }
DeckGeneretor >> createBoardFor: boxTypes with: probabilities [
	| index |
	index := 1.
	[ index <= boxTypes size ]
		whileTrue: [ self add: (probabilities at: index) of: (boxTypes at: index).
			index := index + 1 ]
]

{ #category : #initalize }
DeckGeneretor >> initializeWithSize: aSize for: cardTypes with: probabilities [
	size := aSize - 1.
	cards := OrderedCollection new.
	self createBoardFor: cardTypes with: probabilities.
	self completeBoard.
	^ cards
]
