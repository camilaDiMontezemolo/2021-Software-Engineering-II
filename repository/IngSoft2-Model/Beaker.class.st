Class {
	#name : #Beaker,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Beaker class >> validateDice: dice [
	dice < 1
		ifTrue: [ Error signal: 'Un beaker no puede tener menos de 1 dado(s).' ]
]

{ #category : #'instance creation' }
Beaker class >> with: dice [
	self validateDice: dice.
	^self new intializeWithDice: dice
]

{ #category : #initialize }
Beaker >> intializeWithDice: gameDice [
	dice := gameDice.
]

{ #category : #'as yet unclassified' }
Beaker >> isEmpty [
	^false.
]

{ #category : #'as yet unclassified' }
Beaker >> spin [
	|distance|
	distance := 0.
	dice do: [ :die | distance := distance + die spin ].
	^distance.
]
