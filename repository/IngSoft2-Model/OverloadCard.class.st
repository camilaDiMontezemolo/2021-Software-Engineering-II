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

{ #category : #'as yet unclassified' }
OverloadCard >> initialize [ 
	value := -2.
]

{ #category : #'as yet unclassified' }
OverloadCard >> initializeWithNewValue: newValue [
	value := newValue.
]

{ #category : #'as yet unclassified' }
OverloadCard >> value [ 
	^value
]
