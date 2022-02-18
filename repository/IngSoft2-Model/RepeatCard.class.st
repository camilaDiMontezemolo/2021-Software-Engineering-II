Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #cardEffect }
RepeatCard >> triggerEffectOn: target from: cardManager by: player [

	cardManager validateinstant: self of: player.
	cardManager lastCardUsed: self.
	cardManager lastTypeOfBoxForPlayer: target.
]
