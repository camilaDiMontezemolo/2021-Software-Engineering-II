Class {
	#name : #SpeedUpCard,
	#superclass : #Card,
	#instVars : [
		'affectedPlayer',
		'active'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedUpCard >> applyEffectFrom: aCardManager [ 
	aCardManager lastCardUsed:(self).
	^1.
]

{ #category : #initialize }
SpeedUpCard >> instant [ 
	^false.
]
