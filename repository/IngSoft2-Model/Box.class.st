Class {
	#name : #Box,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #abstract }
Box >> affect: positions triggeredOn: aPosition with: board [
	^self subclassResponsibility.
]
