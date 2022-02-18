Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #cardEffect }
RedoCard >> triggerEffectOn: target from: cardManager by: player [

	| card |
	cardManager validateinstant: self of: player. 
	card := (cardManager lastCardUsed).
	cardManager add: card toHandOf: player.
	card triggerEffectOn: target from: cardManager by: player.
]
