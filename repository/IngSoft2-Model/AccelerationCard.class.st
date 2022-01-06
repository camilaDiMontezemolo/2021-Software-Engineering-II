Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#instVars : [
		'affectedPlayer',
		'active'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AccelerationCard >> applyEffectFrom: aCardManager [ 
	aCardManager lastCardUsed: self.
	^1.
]

{ #category : #initialize }
AccelerationCard >> instant [
	^false.
]
