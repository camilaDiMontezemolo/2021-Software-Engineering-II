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

{ #category : #'as yet unclassified' }
AccelerationCard >> initialize [ 
	value := 1.
]

{ #category : #'as yet unclassified' }
AccelerationCard >> initializeWithNewValue: newValue [
	value := newValue.
]

{ #category : #'as yet unclassified' }
AccelerationCard >> value [ 
	^value
]
