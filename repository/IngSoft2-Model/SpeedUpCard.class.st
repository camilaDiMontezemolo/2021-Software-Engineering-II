Class {
	#name : #SpeedUpCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedUpCard >> applyEffectFrom: aCardManager [ 
	aCardManager lastCardUsed: self.
	^1.
]
