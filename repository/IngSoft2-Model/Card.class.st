Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Card >> triggerEffectOn: target from: aCardManager by: aPlayer [
	^self subclassResponsibility
]
