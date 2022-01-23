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
