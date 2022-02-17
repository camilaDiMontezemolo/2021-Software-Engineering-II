Class {
	#name : #EffectGenerator,
	#superclass : #Object,
	#instVars : [
		'size',
		'percentages',
		'boxCol'
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

{ #category : #'as yet unclassified' }
EffectGenerator >> add: aPercentage of: aBoxType [
	| index |
	index := 1.
	[(index <= (size *aPercentage)) & (boxCol size < size)] whileTrue:[
			boxCol add: aBoxType new.
			index := index +1.].
	boxCol := boxCol shuffled.
	^boxCol.
		
]

{ #category : #'as yet unclassified' }
EffectGenerator >> boxes [
	^boxCol.
		
]

{ #category : #'as yet unclassified' }
EffectGenerator >> completeBoard [ 
	(boxCol size < size)
		ifTrue: [ (boxCol size) to: (size) do: [:emptyBox | boxCol add: (NoEffect new) ]].
]

{ #category : #'as yet unclassified' }
EffectGenerator >> createBoardFor: boxTypes with: probabilities [
	| index |
	index := 1.
	[ index <= boxTypes size ]
		whileTrue: [ self add: (probabilities at: index) of: (boxTypes at: index).
			index := index + 1 ]
]

{ #category : #initalize }
EffectGenerator >> initializeWithSize: aSize for: boxTypes with: probabilities [
	size := aSize - 1.
	boxCol := OrderedCollection new.
	self createBoardFor: boxTypes with: probabilities.
	self completeBoard.
	^ boxCol
]
