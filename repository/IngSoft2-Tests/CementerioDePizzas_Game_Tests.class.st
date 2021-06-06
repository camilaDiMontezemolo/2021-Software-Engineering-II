Class {
	#name : #'CementerioDePizzas_Game_Tests',
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CementerioDePizzas_Game_Tests >> should: block raise: kindOfError withMessage: errorMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test000_AGameShouldHaveAtLeastOneLap [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	| myDie hawaiana myPlayers  block myBoard |
	
	hawaiana := Player withName: 'hawaiana'.
	
	myDie := OrderedCollection with: (Die withSides: 3).
	
	myPlayers:= (OrderedCollection with: hawaiana).
	
	block:=[PizzaGame withBoard:myBoard andPlayers: myPlayers andDie: myDie andLaps: 0].
	
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 vuelta.'.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test000_CreateAGameWithOnePlayerAnd10Boxes [
	"a dummy test comment"
	"un dia en un cementerio de pizzas habian 2 pizzas"
	| myBoard myDie hawaiana myPlayers myGame |
	
	hawaiana := Player withName: 'hawaiana'.
	
	myDie := OrderedCollection with: (Die withSides: 3).
	
	myPlayers:= (OrderedCollection with: hawaiana).
	
	myBoard:= Board withSize: 10.
	
	myGame:= PizzaGame withBoard:myBoard andPlayers: myPlayers andDie: myDie andLaps: 1.
	
	self assert: (myBoard sizeOfBoard) equals: 10.

	self assert: (myGame players) = myPlayers.
	
	self assert: (myGame dice) equals: myDie.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test001_aBoardShouldHaveMoreThanCeroBoxes [

	| block kindOfError errorMessage|
	
	
	block := [ Board withSize:0.].
	kindOfError := Error.
	errorMessage := 'Un tablero no puede tener menos de 1 casillero.'.
	
	self should: block raise: kindOfError withMessage: errorMessage.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test001_aBoardShouldHaveMoreThanCeroDie [

	|  myDie laQueHablaRaro block boardWithoutDie |

	laQueHablaRaro := Player withName: 'laQueHablaRaro'.
	
	myDie := OrderedCollection with: (Die withSides: 3).
		
	block:=[boardWithoutDie := PizzaGame
		withBoard: (Board withSize: 20)
		andPlayers: (OrderedCollection with: laQueHablaRaro)
		andDie: OrderedCollection new
		andLaps: 1
		].
		
	self should: block raise: Error withMessage: 'Un juego no puede tener menos de 1 dado.'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test001_aBoardShouldHaveMoreThanCeroPlayers [

	|  myDie laQueHablaRaro block2 boardWithoutPlayers |

	laQueHablaRaro := Player withName: 'laQueHablaRaro'.
	
	myDie := OrderedCollection with: (Die withSides: 3).

	block2:= [
		boardWithoutPlayers :=PizzaGame
		withBoard: (Board withSize: 1)
		andPlayers: OrderedCollection new
		andDie: myDie
		andLaps: 1.
		].
	
	self should: block2 raise: Error withMessage: 'Un juego no puede tener menos de 1 jugador.'.
		
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test002_aPlayerMustHaveAName [
	| myPlayer block |
	myPlayer := Player withName: 'Push-Pop :)'.
	
	self assert: (myPlayer name) equals: 'Push-Pop :)'.
	
	block:= [Player withName: ''.].
	self should: block raise: Error withMessage: 'Todo jugador debe tener un nombre.'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test004_aDiceShouldHaveAtLeastOneSide [
	| myDice block |
	myDice := Die withSides: 6.
	self assert: (myDice sides) equals:6.
	
	block:= [Die withSides: 0.].
	self should: block raise: Error withMessage: 'Un dado no puede tener menos de 3 cara(s).'.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test005_CreateAPosition [
	|myPosition aPlayer anAbsoluteLocation |
	aPlayer:= Player withName: 'Alejandra'.
	anAbsoluteLocation := 20.
	myPosition := Position of: aPlayer at: anAbsoluteLocation.
	self assert: (myPosition absoluteLocation) equals:20.
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test006_AMoonWalkBoxJumpsAPlayerBoxesBack [
	
	| myPositions napolitana mozzarella box napolitanaPosition newLocations mozzaPosition|
	
	mozzarella:= Player withName: 'mozzarella'.
	napolitana:= Player withName: 'napolitana'.
	
	box := MoonWalkBox loadedWith: 1.
	napolitanaPosition := (Position of: napolitana at: 4).
	mozzaPosition:= (Position of: mozzarella at:3).
	myPositions:= OrderedCollection with: napolitanaPosition with: mozzaPosition.
	
	
	newLocations := box affect: myPositions triggeredOn: napolitanaPosition with: 30. 
	

	self assert: (newLocations at: mozzaPosition) equals: 2.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test007_CreateAGameMultiPlayer [
	
	| game myBoard myDie napolitana ranking margarita testPlayers mozzarella myBoxes |
	
	napolitana:= Player withName: 'napolitana'.	
	margarita:= Player withName: 'margarita'.
	mozzarella:= Player withName: 'mozzarella'.
	
	myBoxes := OrderedCollection with: (NoEffectBox new) with: (NoEffectBox new) with: (WormHoleBox new) with: (AtomicBombBox new) with: (MoonWalkBox loadedWith: 1) with: (SpeedupBox new).
	
	myBoard := Board withBoxes: myBoxes.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	myDie := OrderedCollection with: (LoadedDice withTosses: #(4 4 4 2 2 2 2 2 2 6 6 6 2 2 2)).
	
	game:= PizzaGame withBoard: myBoard andPlayers: testPlayers andDie: myDie andLaps: 1.
	
	game play.
	ranking := game ranking.
	
	
	self assert: (game isFinished).
	self assert: (game firstPlace) player equals: napolitana.
	self assert: ((ranking at:1) player equals: napolitana).
	self assert: ((ranking at:2) player equals: margarita).
	self assert: ((ranking at:3) player equals: mozzarella).
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test008_ANoEffectBoxHasNoEffects [
	
	| mozzarella napolitana box napolitanaPosition myPositions newLocations |

	mozzarella:= Player withName: 'mozzarella'.
	napolitana:= Player withName: 'napolitana'.
	
	box := NoEffectBox new.
	napolitanaPosition := (Position of: napolitana at: 4).
	myPositions:= OrderedCollection with: napolitanaPosition with: (Position of: mozzarella at:2).
	
	
	newLocations := box affect: myPositions triggeredOn: napolitanaPosition with: 30. 
	

	self assert: (newLocations size) equals: 0.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test009_ASpeedupBoxJumpsYouFourBoxes [
	
	| myPositions napolitana mozzarella box napolitanaPosition newLocations|
	
	mozzarella:= Player withName: 'mozzarella'.
	napolitana:= Player withName: 'napolitana'.
	
	box := SpeedupBox  new.
	napolitanaPosition := (Position of: napolitana at: 4).
	myPositions:= OrderedCollection with: napolitanaPosition with: (Position of: mozzarella at:2).
	
	
	newLocations := box affect: myPositions triggeredOn: napolitanaPosition with: 30. 
	

	self assert: (newLocations at: napolitanaPosition) equals: 8.

]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test010_AnAtomicBombBoxSendsEveryoneBackToZero [
	
	| myPositions napolitana mozzarella box napolitanaPosition newLocations mozzaPosition hawaiana hawaPosition |
	
	mozzarella:= Player withName: 'mozzarella'.
	napolitana:= Player withName: 'napolitana'.
	hawaiana:= Player withName: 'hawaiana'.
	
	box := AtomicBombBox new.
	napolitanaPosition := (Position of: napolitana at: 4).
	mozzaPosition:= (Position of: mozzarella at:3).
	hawaPosition := (Position of: hawaiana at: 8).
	myPositions:= OrderedCollection with: napolitanaPosition with: mozzaPosition with: hawaPosition.
	
	
	newLocations := box affect: myPositions triggeredOn: napolitanaPosition with: 30. 
	

	self assert: (newLocations at: mozzaPosition) equals: 0.
	self assert: (newLocations at: hawaPosition) equals: 0.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test011_CreateAGameSinglePlayer [
	
	| myBoard game myDie positions napolitana |
	
	napolitana:= Player withName: 'napolitana'.
	
	myDie := OrderedCollection with: (Die withSides: 5).
	
	myBoard := Board withSize: 5.
	
	game:= PizzaGame withBoard: myBoard andPlayers: (OrderedCollection with: napolitana) andDie: myDie andLaps: 1.
	
	game play.
	positions := game ranking.
	self assert: (game isFinished).
	self assert: (positions at:1) player equals: napolitana.
	
]

{ #category : #tests }
CementerioDePizzas_Game_Tests >> test012_CreateARandomMultiPlayerGame [
	
	| game myBoard myDie napolitana margarita testPlayers mozzarella |
	
	napolitana:= Player withName: 'napolitana'.	
	margarita:= Player withName: 'margarita'.
	mozzarella:= Player withName: 'mozzarella'.
	
	
	myBoard := Board withSize: 40.
	
	testPlayers:= OrderedCollection with: napolitana with: margarita with: mozzarella.
	
	myDie := OrderedCollection with: (Die withSides: 5) with: (Die withSides: 4).
	
	game:= PizzaGame withBoard: myBoard andPlayers: testPlayers andDie: myDie andLaps: 1.
	
	game play.
	
	self assert: (game isFinished).
	
]
