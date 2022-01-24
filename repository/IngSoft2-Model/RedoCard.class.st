Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
RedoCard >> triggerRedoEffectFrom: aCardManager [
	| card |
	card := (aCardManager giveLastCardUsed).
	^card.

]
