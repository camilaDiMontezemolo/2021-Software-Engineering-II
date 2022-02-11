Class {
	#name : #JailBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
JailBox >> affect: positions triggeredOn: aPosition with: board [
	(board lastPlayerDistance <= board maximunToss )
	ifTrue: [ Error signal: 'prueba']
]
