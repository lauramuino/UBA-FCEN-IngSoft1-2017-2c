!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!


!classDefinition: #ElevatorTest category: #'Elevator-Ejercicio'!
TestCase subclass: #ElevatorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:38'!
test09RequestToGoUpAreEnqueueWhenRequestedWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test10CabinDoorStartClosingAfterWaitingForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test11StopsWaitingForPeopleIfCloseDoorIsPressed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test12CloseDoorDoesNothingIfIdle

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController closeCabinDoor.

	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test13CloseDoorDoesNothingWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test14CloseDoorDoesNothingWhenOpeningTheDoorToWaitForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:42'!
test15ElevatorHasToEnterEmergencyIfStoppedAndOtherFloorSensorTurnsOn

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test16ElevatorHasToEnterEmergencyIfFalling

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test17ElevatorHasToEnterEmergencyIfJumpsFloors

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:3.
	elevatorController cabinDoorClosed.
	self 
		should: [ elevatorController cabinOnFloor: 3 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test18ElevatorHasToEnterEmergencyIfDoorClosesAutomatically
	| elevatorController |
	elevatorController := ElevatorController new.
	
	self 
		should: [ elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test19ElevatorHasToEnterEmergencyIfDoorClosedSensorTurnsOnWhenClosed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:49'!
test20ElevatorHasToEnterEmergencyIfDoorClosesWhenOpening
	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'.]! !


!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:35'!
test06DoorKeepsOpenedWhenOpeningIsRequested

	| elevatorController |
	elevatorController := ElevatorController new.
	
	self assert: elevatorController isCabinDoorOpened.
	
	elevatorController openCabinDoor.

	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 6/16/2014 13:24'!
test07DoorMustBeOpenedWhenCabinIsStoppedAndClosingDoors

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
		
	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.
! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:36'!
test08CanNotOpenDoorWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test09DoorKeepsOpeneingWhenItIsOpeneing

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test21CabinHasToStopOnTheFloorsOnItsWay
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test22ElevatorCompletesAllTheRequests
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:2.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test23CabinHasToStopOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test24CabinHasToStopAndWaitForPeopleOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !


!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/10/2011 17:33'!
test01ElevatorStartsIdleWithDoorOpenOnFloorZero

	| elevatorController |
		
	elevatorController := ElevatorController new.
		
	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.
	self assert: elevatorController cabinFloorNumber = 0
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'lm 10/2/2017 14:31:26'!
test02CabinDoorStartsClosingWhenElevatorGetsCalled

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self assert: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:57'!
test03CabinStartsMovingWhenDoorGetsClosed

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.

	self deny: elevatorController isCabinStopped.
	self assert: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test04CabinStopsAndStartsOpeningDoorWhenGetsToDestination

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.

	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
			
	self deny: elevatorController isCabinDoorOpened.
	self assert: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.

	self assert: elevatorController cabinFloorNumber = 1
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test05ElevatorGetsIdleWhenDoorGetOpened

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.
	elevatorController cabinDoorOpened.
		
	self assert: elevatorController isIdle.
	self deny: elevatorController isWorking.
		
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.

	self assert: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.
		
	self assert: elevatorController cabinFloorNumber = 1! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'globalState floorsToGo cabinFloorNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:55:34'!
cabinDoorClosed

	globalState := globalState cabinDoorClosed.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 21:16:27'!
cabinDoorOpened
	globalState := globalState cabinDoorOpened: floorsToGo.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 13:45:35'!
cabinFloorNumber
	^cabinFloorNumber .! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'lm 10/3/2017 19:50:55'!
cabinOnFloor: aFloorNumber

	(aFloorNumber = (cabinFloorNumber +1) ) ifFalse:[^ElevatorEmergency signal:  'Sensor de cabina desincronizado'.].
	cabinFloorNumber := aFloorNumber .
	^globalState := globalState cabinOnFloor.
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 21:30:42'!
closeCabinDoor
	^globalState := globalState closeCabinDoor.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'lm 10/3/2017 20:07:33'!
goUpPushedFromFloor: aFloorNumber
	(self isIdle) ifFalse:[
		floorsToGo add: aFloorNumber .
	].
	globalState := globalState goUpPushedFromFloor.

! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'lm 10/3/2017 19:27:10'!
initialize
	globalState := IdleState new.
	cabinFloorNumber := 0.
	floorsToGo := OrderedCollection new.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'lm 10/3/2017 19:20:01'!
openCabinDoor
	^globalState := globalState openCabinDoor.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'lm 10/3/2017 19:23:01'!
waitForPeopleTimedOut
	globalState := globalState waitForPeopleTimedOut.! !


!ElevatorController methodsFor: 'testing' stamp: 'lm 10/2/2017 20:49:52'!
isCabinDoorClosed
	^ globalState isCabinDoorClosed.! !

!ElevatorController methodsFor: 'testing' stamp: 'lm 10/2/2017 20:50:28'!
isCabinDoorClosing
	^globalState isCabinDoorClosing .! !

!ElevatorController methodsFor: 'testing' stamp: 'lm 10/2/2017 20:50:57'!
isCabinDoorOpened
	^globalState isCabinDoorOpened .! !

!ElevatorController methodsFor: 'testing' stamp: 'lm 10/2/2017 20:51:06'!
isCabinDoorOpening
	^globalState isCabinDoorOpening .! !

!ElevatorController methodsFor: 'testing' stamp: 'lm 10/2/2017 20:51:37'!
isCabinMoving
	^globalState isCabinMoving .! !

!ElevatorController methodsFor: 'testing' stamp: 'lm 10/2/2017 20:51:48'!
isCabinStopped
	^globalState isCabinStopped .! !

!ElevatorController methodsFor: 'testing' stamp: 'lm 10/2/2017 20:52:00'!
isCabinWaitingForPeople
	^globalState isCabinWaitingForPeople .! !

!ElevatorController methodsFor: 'testing' stamp: 'lm 10/2/2017 20:52:21'!
isIdle
	^globalState isIdle.! !

!ElevatorController methodsFor: 'testing' stamp: 'lm 10/2/2017 20:52:36'!
isWorking
	^globalState isWorking.! !


!classDefinition: #GlobalState category: #'Elevator-Ejercicio'!
Object subclass: #GlobalState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!GlobalState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:50:15'!
isCabinDoorClosed
	^ false.! !

!GlobalState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:50:34'!
isCabinDoorClosing
	^false.! !

!GlobalState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:50:46'!
isCabinDoorOpened
	^ false.! !

!GlobalState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:50:48'!
isCabinDoorOpening
	^ false.! !

!GlobalState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:51:18'!
isCabinMoving
	^false.! !

!GlobalState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:51:25'!
isCabinStopped
	^true.! !

!GlobalState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:52:03'!
isCabinWaitingForPeople
	^false.! !

!GlobalState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:52:26'!
isIdle
	^false.! !

!GlobalState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:52:39'!
isWorking
	^true.! !


!classDefinition: #ClosingCabinDoorState category: #'Elevator-Ejercicio'!
GlobalState subclass: #ClosingCabinDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ClosingCabinDoorState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:56:11'!
cabinDoorClosed

	^TravellingState new.! !

!ClosingCabinDoorState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:16:57'!
isCabinDoorClosing
	^true.! !

!ClosingCabinDoorState methodsFor: 'as yet unclassified' stamp: 'lm 10/3/2017 19:18:38'!
openCabinDoor
	^OpeningCabinDoorState new.! !


!classDefinition: #IdleState category: #'Elevator-Ejercicio'!
GlobalState subclass: #IdleState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!IdleState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 19:45:06'!
cabinDoorClosed
	^ElevatorEmergency signal: 'Sensor de puerta desincronizado'.! !

!IdleState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 21:31:49'!
closeCabinDoor
	^self.! !

!IdleState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 21:40:27'!
goUpPushedFromFloor
	^ClosingCabinDoorState new.! !

!IdleState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:08:39'!
isCabinDoorOpened
	^true.! !

!IdleState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:08:17'!
isCabinStopped
	^true.! !

!IdleState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 19:54:14'!
isIdle 
	^true.! !

!IdleState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 19:54:24'!
isWorking
	^false.! !

!IdleState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 19:52:19'!
openCabinDoor! !


!classDefinition: #OpenedCabinDoorWaitingForPeopleState category: #'Elevator-Ejercicio'!
GlobalState subclass: #OpenedCabinDoorWaitingForPeopleState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!OpenedCabinDoorWaitingForPeopleState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 21:34:13'!
closeCabinDoor
	^ClosingCabinDoorState new.! !

!OpenedCabinDoorWaitingForPeopleState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:18:08'!
isCabinDoorOpened
	^true.! !

!OpenedCabinDoorWaitingForPeopleState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:19:56'!
isCabinWaitingForPeople
	^true.! !

!OpenedCabinDoorWaitingForPeopleState methodsFor: 'as yet unclassified' stamp: 'lm 10/3/2017 19:23:32'!
waitForPeopleTimedOut
	^ClosingCabinDoorState new.! !


!classDefinition: #OpeningCabinDoorState category: #'Elevator-Ejercicio'!
GlobalState subclass: #OpeningCabinDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!OpeningCabinDoorState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:55:27'!
cabinDoorClosed
	^ElevatorEmergency signal: 'Sensor de puerta desincronizado'.! !

!OpeningCabinDoorState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 21:14:55'!
cabinDoorOpened: floorsToGo

	(floorsToGo isEmpty) ifTrue: [	^IdleState new].
	^OpenedCabinDoorWaitingForPeopleState new.! !

!OpeningCabinDoorState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 21:37:27'!
closeCabinDoor
	^self.! !

!OpeningCabinDoorState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 21:52:51'!
goUpPushedFromFloor
	^self! !

!OpeningCabinDoorState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:18:32'!
isCabinDoorOpening
	^true.! !

!OpeningCabinDoorState methodsFor: 'as yet unclassified' stamp: 'lm 10/3/2017 19:19:16'!
openCabinDoor
	^self.! !


!classDefinition: #TravellingState category: #'Elevator-Ejercicio'!
GlobalState subclass: #TravellingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!TravellingState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 19:55:41'!
cabinDoorClosed
	^ElevatorEmergency signal: 'Sensor de puerta desincronizado'.! !

!TravellingState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 21:25:51'!
cabinOnFloor
	^OpeningCabinDoorState new.! !

!TravellingState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 21:38:02'!
closeCabinDoor
	^self.! !

!TravellingState methodsFor: 'as yet unclassified' stamp: 'lm 10/3/2017 19:30:12'!
goUpPushedFromFloor
	^self! !

!TravellingState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:07:33'!
isCabinDoorClosed
	^true.! !

!TravellingState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:04:56'!
isCabinMoving
	^true.! !

!TravellingState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:19:39'!
isCabinStopped
	^false.! !

!TravellingState methodsFor: 'as yet unclassified' stamp: 'lm 10/2/2017 20:07:21'!
isWorking
	^true.! !

!TravellingState methodsFor: 'as yet unclassified' stamp: 'lm 10/3/2017 19:18:58'!
openCabinDoor
	^self.! !
