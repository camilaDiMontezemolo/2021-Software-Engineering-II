Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Effect >> affect: positions triggeredOn: aPosition on: board withPreviousAdvance: distance [
	^self subclassResponsibility.
]
