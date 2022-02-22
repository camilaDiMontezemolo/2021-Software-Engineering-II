Class {
	#name : #ProbabilityGenerator,
	#superclass : #Object,
	#instVars : [
		'size',
		'effects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ProbabilityGenerator class >> give: aSize for: boxTypes with: probabilities usingFiller: filler [

	self validate: probabilities.
	^ self new
		  initializeWithSize: aSize
		  for: boxTypes
		  with: probabilities
		  usingFiller: filler
]

{ #category : #'instance creation' }
ProbabilityGenerator class >> validate: probabilities [
	| sum |
	sum := 0. 
	probabilities do: [:oneProba | sum := sum + oneProba].
	(sum = 1)
	ifFalse: [ Error signal: 'Las suma de probabilidades debe ser 1.']
]

{ #category : #effectsCreation }
ProbabilityGenerator >> add: aPercentage of: effectType [
	| index |
	index := 1.
	[(index <= (size *aPercentage)) & (effects size < size)] whileTrue:[
			effects add: effectType new.
			index := index +1.].
	effects := effects shuffled.
		
]

{ #category : #effectsCreation }
ProbabilityGenerator >> completeListWith: filler [
	(effects size < size)
		ifTrue: [ (effects size) to: (size) do: [:emptyEffect | effects add: (filler new) ]].
]

{ #category : #effectsCreation }
ProbabilityGenerator >> createObjetct: effectTypes withProbability: probabilities [
	| index |
	index := 1.
	[ index <= effectTypes size ]
		whileTrue: [ self add: (probabilities at: index) of: (effectTypes at: index).
			index := index + 1 ]
]

{ #category : #effectsCreation }
ProbabilityGenerator >> effects [
	^effects.
		
]

{ #category : #initalize }
ProbabilityGenerator >> initializeWithSize: aSize for: effectTypes with: probabilities usingFiller: filler [
	size := aSize - 1.
	effects := OrderedCollection new.
	self createObjetct: effectTypes withProbability: probabilities.
	self completeListWith: filler.
]

{ #category : #initalize }
ProbabilityGenerator >> proportionOf: typeOfEffect [
	^(effects count: [ :effect | effect isMemberOf: typeOfEffect ]).
]

{ #category : #initalize }
ProbabilityGenerator >> size [
	^size+1
]
