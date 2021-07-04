Class {
	#name : #Box,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Box >> affect: positions triggeredOn: aPosition with: board [
	^self subclassResponsibility.
]
