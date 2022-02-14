Class {
	#name : #Box,
	#superclass : #Object,
	#instVars : [
		'dice',
		'effects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Box class >> createWith: effects [
	^self new initializeWithEffects: effects.
]

{ #category : #effects }
Box >> addEffect: effect [
	effects add: effect.
]

{ #category : #effects }
Box >> affect: positions triggeredOn: positionOfPlayer  on: board withPreviousAdvance: distance [
	effects do: [:effect | effect affect: positions triggeredOn: (board positionOfPlayer: (positionOfPlayer player))  on: board withPreviousAdvance: distance].
]

{ #category : #initialization }
Box >> initializeWithEffects: boxEffects [
	effects:= OrderedCollection new.
	effects add: boxEffects.
	
]
