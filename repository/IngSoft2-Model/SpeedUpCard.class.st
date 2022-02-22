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

{ #category : #initialize }
SpeedUpCard >> initialize [ 
	value := 1.
]

{ #category : #initialize }
SpeedUpCard >> initializeWithNewValue: newValue [
	value := newValue.
]

{ #category : #'apply effects' }
SpeedUpCard >> value [ 
	^value
]
