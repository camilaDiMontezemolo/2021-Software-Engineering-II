Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'apply effects' }
RedoCard >> triggerRedoEffectFrom: aCardManager [
	| card |
	card := (aCardManager lastCardUsed).
	^card.

]
