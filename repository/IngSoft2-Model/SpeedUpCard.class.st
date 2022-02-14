Class {
	#name : #SpeedUpCard,
	#superclass : #Card,
	#instVars : [
		'value'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpeedUpCard class >> withValue: newValue [
	^self new initializeWithNewValue: newValue
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> initialize [ 
	value := 1.
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> initializeWithNewValue: newValue [
	value := newValue.
]

{ #category : #'as yet unclassified' }
SpeedUpCard >> value [ 
	^value
]
