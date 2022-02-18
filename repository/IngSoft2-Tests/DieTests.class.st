Class {
	#name : #DieTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DieTests >> should: block raise: kindOfError withMessage: errorMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : #beaker }
DieTests >> testABeakerMximunTossIsTheAdditionOfTheMax [

	|beaker|
	
	beaker := Beaker with: (OrderedCollection with: (LoadedDie withTosses: #( 2 ) andSides: 3) with: (LoadedDie withTosses: #( 2 ) andSides: 3)).
	self assert: beaker maxToss equals:6
	
]

{ #category : #die }
DieTests >> testADieWithinvalidSizeRaisesAnError [
	self should: [Die withSides: 2] raise: Error withMessage: 'Un dado no puede tener menos de 3 cara(s).'.
]

{ #category : #die }
DieTests >> testALoadedDieWithTossesGreaterThanSizeRaisesAnError [
	self should: [ LoadedDie withTosses: #( 1 4 ) andSides: 3 ] raise: Error withMessage: 'La tirada no puede ser mayor que el tamaño del dado'.
]

{ #category : #die }
DieTests >> testALoadedDieWithinvalidSizeRaisesAnError [
	self should: [ LoadedDie withTosses: #( 1 2 ) andSides: 2 ] raise: Error withMessage: 'Un dado no puede tener menos de 3 cara(s).'.
]

{ #category : #die }
DieTests >> testALoadedDieWithinvalidTossesRaisesAnError [
	self should: [ LoadedDie withTosses: #( 1 -2 ) andSides: 3 ] raise: Error withMessage: 'No se pueden usar tiradas iguales o menores a cero'.
]

{ #category : #beaker }
DieTests >> testaBeakerWithoutDiceRaiseAnError [
	self should: [ Beaker with: (OrderedCollection new)] raise: Error withMessage: 'No se puede implementar un cubilete vacio'.
	
]
