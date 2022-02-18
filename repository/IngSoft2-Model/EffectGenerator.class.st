Class {
	#name : #EffectGenerator,
	#superclass : #Object,
	#instVars : [
		'size',
		'effects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
EffectGenerator class >> give: aSize for: boxTypes with: probabilities [
	self validate: probabilities.
	^ self new initializeWithSize: aSize for: boxTypes with: probabilities.
]

{ #category : #'instance creation' }
EffectGenerator class >> validate: probabilities [
	| sum |
	sum := 0. 
	probabilities do: [:oneProba | sum := sum + oneProba].
	(sum = 1)
	ifFalse: [ Error signal: 'Las suma de probabilidades debe ser 1.']
]

{ #category : #effectsCreation }
EffectGenerator >> add: aPercentage of: effectType [
	| index |
	index := 1.
	[(index <= (size *aPercentage)) & (effects size < size)] whileTrue:[
			effects add: effectType new.
			index := index +1.].
	effects := effects shuffled.
		
]

{ #category : #effectsCreation }
EffectGenerator >> completeEffectList [ 
	(effects size < size)
		ifTrue: [ (effects size) to: (size) do: [:emptyEffect | effects add: (NoEffect new) ]].
]

{ #category : #effectsCreation }
EffectGenerator >> createEffectsr: effectTypes with: probabilities [
	| index |
	index := 1.
	[ index <= effectTypes size ]
		whileTrue: [ self add: (probabilities at: index) of: (effectTypes at: index).
			index := index + 1 ]
]

{ #category : #effectsCreation }
EffectGenerator >> effects [
	^effects.
		
]

{ #category : #initalize }
EffectGenerator >> initializeWithSize: aSize for: effectTypes with: probabilities [
	size := aSize - 1.
	effects := OrderedCollection new.
	self createEffectsr: effectTypes with: probabilities.
	self completeEffectList.
]

{ #category : #initalize }
EffectGenerator >> proportionOf: typeOfEffect [
	^(effects count: [ :effect | effect isMemberOf: typeOfEffect ]).
]
