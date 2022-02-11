Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CancellationCard >> triggerEffectOn: target from: aCardManager by: aPlayer [
	aCardManager validateinstant: self of: aPlayer. 
	aCardManager cancellateTarget: target usig: self from: aPlayer.
	aCardManager lastCardUsed: self. 
]
