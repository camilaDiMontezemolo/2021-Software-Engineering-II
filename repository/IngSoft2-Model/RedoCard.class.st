Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
RedoCard >> triggerEffectOn: target from: aCardManager by: aPlayer [
	| card |
	aCardManager validateinstant: self of: aPlayer. 
	card := (aCardManager lastCardUsed).
	aCardManager add: card toHandOf: aPlayer.
	card triggerEffectOn: target from: aCardManager by: aPlayer. 
]
