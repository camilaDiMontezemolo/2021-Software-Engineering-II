Class {
	#name : #RedoCard,
	#superclass : #Instantaneous,
	#category : #'IngSoft2-Model'
}

{ #category : #'apply effects' }
RedoCard >> triggerRedoEffectFrom: aCardManager [
	| card |
	card := (aCardManager lastCardUsed).
	^card.

]
