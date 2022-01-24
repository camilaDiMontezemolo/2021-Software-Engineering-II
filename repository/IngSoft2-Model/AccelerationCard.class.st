Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AccelerationCard >> applyEffectFrom: aCardManager [ 
	aCardManager lastCardUsed: self.
	^1.
]
