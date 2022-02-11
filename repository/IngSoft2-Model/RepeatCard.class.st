Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
RepeatCard >> triggerEffectOn: target from: aCardManager by: aPlayer [
	aCardManager validateinstant: self of: aPlayer.
	aCardManager lastCardUsed: self.
	aCardManager lastTypeOfBoxForPlayer: target.
]
