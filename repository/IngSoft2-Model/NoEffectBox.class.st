Class {
	#name : #NoEffectBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
NoEffectBox >> pizzaEffect [
	^[:a | Transcript show: 'No hubo efecto'.].
]
