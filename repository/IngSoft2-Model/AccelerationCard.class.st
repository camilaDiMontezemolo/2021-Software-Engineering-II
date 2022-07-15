Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#instVars : [
		'value'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
AccelerationCard class >> withValue: newValue [
	^self new initializeWithNewValue: newValue
]

{ #category : #initialize }
AccelerationCard >> initialize [ 
	value := 1.
]

{ #category : #initialize }
AccelerationCard >> initializeWithNewValue: newValue [
	value := newValue.
]

{ #category : #'apply effects' }
AccelerationCard >> value [ 
	^value
]
