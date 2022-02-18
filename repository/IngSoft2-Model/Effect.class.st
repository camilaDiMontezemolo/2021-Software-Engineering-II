Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #boxEffect }
Effect >> affect: positions triggeredOn: aPosition on: board withPreviousAdvance: distance [
	^self subclassResponsibility.
]
