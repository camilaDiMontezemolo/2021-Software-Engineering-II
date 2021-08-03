Class {
	#name : #BoxGenerator,
	#superclass : #Object,
	#classVars : [
		'myBoxes',
		'mySize'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoxGenerator class >> give: aSize andProbabilitiesForNoEffectBox: aProbForNoEf andSpeed: aProbForSpeed andWormm: aProbForWorm andMoon: aProbForMoon andAtomic: aProbForAtomic andCardBox: aProbForCardBox [
	self validateSize: aSize andProbabilitiesForNoEffectBox: aProbForNoEf andSpeed: aProbForSpeed andWormm: aProbForWorm andMoon: aProbForMoon andAtomic: aProbForAtomic andCardBox: aProbForCardBox.
	^ self new initializeWithSize: aSize andProbabilitiesForNoEffectBox: aProbForNoEf andSpeed: aProbForSpeed andWormm: aProbForWorm andMoon: aProbForMoon andAtomic: aProbForAtomic andCardBox: aProbForCardBox
]

{ #category : #'instance creation' }
BoxGenerator class >> validateSize: aSize andProbabilitiesForNoEffectBox: aProbForNoEf andSpeed: aProbForSpeed andWormm: aProbForWorm andMoon: aProbForMoon andAtomic: aProbForAtomic andCardBox: aProbForCardBox [.
	(aSize < 1) 
	ifTrue: [ Error signal: 'Un tablero no puede tener menos de 1 casillero.' ].
	((aProbForNoEf + aProbForSpeed + aProbForWorm + aProbForMoon + aProbForAtomic + aProbForCardBox) > 1)
	ifTrue: [ Error signal: 'Las suma de probabilidades debe ser mayor a 1.' ].
]

{ #category : #'as yet unclassified' }
BoxGenerator >> add: aPercentage of: aBoxType [
	| indice |
	indice := 1.
	[(indice <= (mySize *aPercentage)) & (myBoxes size < mySize)]
		whileTrue:[
			myBoxes add: (aBoxType new).
			indice := (indice +1).
			].
		
]

{ #category : #initalize }
BoxGenerator >> initializeWithSize: aSize andProbabilitiesForNoEffectBox: aProbForNoEf andSpeed: aProbForSpeed andWormm: aProbForWorm andMoon: aProbForMoon andAtomic: aProbForAtomic andCardBox: aProbForCardBox [
	mySize := (aSize-1).
	myBoxes := OrderedCollection new.
	self add: aProbForNoEf of: NoEffectBox.
	self add: aProbForSpeed of: SpeedupBox.
	self add: aProbForWorm of: WormHoleBox.
	self add: aProbForMoon of: MoonWalkBox.
	self add: aProbForAtomic of: AtomicBombBox.
	self add: aProbForCardBox of: CardBox.
	(myBoxes size < mySize)
		ifTrue: [ 
			(myBoxes size) to: (mySize) do: [:emptyBox | myBoxes add: (NoEffectBox new) ].
		].
	myBoxes := myBoxes shuffled.
	^myBoxes.
	
]
