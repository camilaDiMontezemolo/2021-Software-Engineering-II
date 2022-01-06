Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#instVars : [
		'affectedPlayer',
		'active'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
OverloadCard >> applyEffectFrom: aCardManager [ 
	aCardManager lastCardUsed: self.
	^-2.
]

{ #category : #initialize }
OverloadCard >> instant [
	^false.
]
