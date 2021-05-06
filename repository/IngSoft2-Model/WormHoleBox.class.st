Class {
	#name : #WormHoleBox,
	#superclass : #Box,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
WormHoleBox >> pizzaEffect [
	| aPlayer myBoard |
	^[
		(aPlayer location - 4  > 0)
		ifTrue: [
			aPlayer setLocation:(aPlayer location - 4).
		]
		ifFalse: [ 
			aPlayer setLocation: (myBoard sizeOfBoard - (aPlayer location - 4)).
			"Acá considerar el cambio de VUELTAS al tablero."
		].
	].
	"players do: [algo :)]"
]
