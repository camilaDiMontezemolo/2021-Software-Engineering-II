Class {
	#name : #DeckGeneretor,
	#superclass : #Object,
	#instVars : [
		'size',
		'percentages',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DeckGeneretor class >> with: aNumberOfCards [
	^ self new initializeWithANumberOfCards: aNumberOfCards
]

{ #category : #'as yet unclassified' }
DeckGeneretor >> add: aPercentage of: aBoxType [
	| indice |
	indice := 1.
	[(indice <= (size *aPercentage)) & (cards size < size)]
		whileTrue:[
			cards add: (aBoxType new).
			indice := (indice +1).
			].
	cards := cards shuffled.
	self validatePorcenge: aPercentage.
	^cards.
		
]

{ #category : #'as yet unclassified' }
DeckGeneretor >> cards [
	^cards.
		
]

{ #category : #'as yet unclassified' }
DeckGeneretor >> completeDeck [
(cards size < size)
		ifTrue: [ 
			(cards size) to: (size) do: [:emptyBox | cards add: (((cards first) class) new) ].]
]

{ #category : #initalize }
DeckGeneretor >> initializeWithANumberOfCards: aNumberOfCards [
	cards := OrderedCollection new.
	size := (aNumberOfCards-1).
	percentages := 0.

]

{ #category : #'as yet unclassified' }
DeckGeneretor >> percentage [
	^percentages 
]

{ #category : #'as yet unclassified' }
DeckGeneretor >> validatePorcenge: aPercentage [
	percentages := percentages + aPercentage.
	(percentages>1)
	ifTrue: [ Error signal: 'Las suma de probabilidades no puede ser mayor a 1.' ].
	(percentages=1)
	ifTrue:[ self completeDeck. ]
]
