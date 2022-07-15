Class {
	#name : #Beaker,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Beaker class >> with: dice [
	^self new intializeWithDice: dice
]

{ #category : #initialize }
Beaker >> intializeWithDice: gameDice [
	dice := gameDice.
]

{ #category : #initialize }
Beaker >> size [
	^dice size
]

{ #category : #'set up' }
Beaker >> spin [
	|distance|
	distance := 0.
	dice do: [ :die | distance := distance + die spin ].
	^distance.
]
