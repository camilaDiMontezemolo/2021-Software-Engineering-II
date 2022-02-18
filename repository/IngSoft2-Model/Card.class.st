Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #cardEffect }
Card >> triggerEffectOn: target from: cardManager by: player [

	^ self subclassResponsibility
]
