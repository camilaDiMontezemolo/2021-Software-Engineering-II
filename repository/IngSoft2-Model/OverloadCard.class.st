Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
OverloadCard >> applyEffectFrom: aCardManager [ 
	^-2.
]

{ #category : #'as yet unclassified' }
OverloadCard >> triggerEffectOn: target from: aCardManager by: aPlayer [
	aCardManager validatePermanentCard: self of: aPlayer. 
	aCardManager affect:target with: self of: aPlayer.
]
