Class {
	#name : #BoxNoEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
BoxNoEffect >> affect: positions triggeredOn: aPosition with: sizeOfBoard [
	^[:a | Transcript show: 'No hubo efecto'.].
]