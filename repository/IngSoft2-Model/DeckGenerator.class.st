Class {
	#name : #DeckGenerator,
	#superclass : #Object,
	#classVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DeckGenerator class >> with: aNumberOfCards [
	^ self new initializeWithANumberOfCards: aNumberOfCards.
]

{ #category : #'as yet unclassified' }
DeckGenerator >> createCard [
	|randomCards |
	randomCards:=OrderedCollection 
		with: (AccelerationCard new) 
		with: (CancellationCard new) 
		with: (OverloadCard new) 
		with: (RedoCard new) 
		with: (RepeatCard new) 
		with:(SpeedUpCard new).
	
	randomCards := randomCards shuffled.
	cards add: (randomCards first).
]

{ #category : #initialization }
DeckGenerator >> initializeWithANumberOfCards: aNumberOfCards [
	| n |
	cards := OrderedCollection new.
	n:=0.
	[n< aNumberOfCards] whileTrue: [self createCard. 
	n:= n+1.].
	^cards.

]
