Class {
	#name : #BoxAtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
BoxAtomicBomb >> affect: positions triggeredOn: aPosition with: sizeOfBoard [
	positions do: [:position | position changeLocation: 0].
]
