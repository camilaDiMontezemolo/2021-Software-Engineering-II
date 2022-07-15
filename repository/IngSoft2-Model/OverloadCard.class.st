Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#instVars : [
		'value'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
OverloadCard class >> withValue: newValue [
	^self new initializeWithNewValue: newValue
]

{ #category : #initialize }
OverloadCard >> initialize [ 
	value := -2.
]

{ #category : #initialize }
OverloadCard >> initializeWithNewValue: newValue [
	value := newValue.
]

{ #category : #'apply effects' }
OverloadCard >> value [ 
	^value
]
