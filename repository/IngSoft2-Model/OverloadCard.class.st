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
OverloadCard >> triggerEffectOn: target from: cardManager by: player [

	cardManager validatePermanentCard: self of: player. 
	cardManager affect:target with: self of: player.
]
