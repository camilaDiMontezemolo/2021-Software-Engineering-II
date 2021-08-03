Class {
	#name : #DeckGenerator,
	#superclass : #Object,
	#classVars : [
		'myCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DeckGenerator class >> with: aNumberOfCards [
	aNumberOfCards < 2
		ifTrue: [ Error signal: 'Un deck no puede tener menos de 2 carta.' ].
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
	myCards add: (randomCards first).
]

{ #category : #initialization }
DeckGenerator >> initializeWithANumberOfCards: aNumberOfCards [
	| n |
	myCards := OrderedCollection new.
	n:=0.
	[n< aNumberOfCards] whileTrue: [self createCard. 
	n:= n+1.].
	^myCards.

"creo que do hace algo así. ver?"
]
