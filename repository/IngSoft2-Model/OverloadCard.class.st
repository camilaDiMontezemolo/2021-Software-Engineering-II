Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
OverloadCard >> applyEffectFrom: aCardManager [ 
	aCardManager lastCardUsed: self.
	^-2.
]
