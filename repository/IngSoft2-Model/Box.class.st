Class {
	#name : #Box,
	#superclass : #Object,
	#instVars : [
		'dice',
		'effects',
		'cardsAffecting'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Box class >> createWith: effects [
	^self new initializeWithEffects: effects.
]

{ #category : #effects }
Box >> addEffect: effect using: card [
	effects add: effect.
	cardsAffecting add: card.
]

{ #category : #effects }
Box >> affect: positions triggeredOn: player  on: board withPreviousAdvance: distance [
	effects do: [:effect | 
		effect affect: positions triggeredOn: (board positionOfPlayer: player)  on: board withPreviousAdvance: distance
	].
]

{ #category : #initialization }
Box >> cardsAffecting [
	^cardsAffecting.
]

{ #category : #initialization }
Box >> initializeWithEffects: boxEffects [
	effects:= OrderedCollection new.
	effects add: boxEffects.
	cardsAffecting := OrderedCollection new.
]

{ #category : #effects }
Box >> removeCard: card [
	| orderOfInsertion |
	orderOfInsertion := cardsAffecting indexOf: card.
	cardsAffecting removeAt: orderOfInsertion.
	effects remove: (effects at: orderOfInsertion +1).
]
