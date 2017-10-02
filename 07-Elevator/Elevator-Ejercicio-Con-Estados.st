!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorEmergency methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 14:01:42'!
messageText

	^'Sensor de cabina desincronizado'.! !


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

!ElevatorTest methodsFor: 'tests 2' stamp: 'ad 10/1/2017 13:43:43'!
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

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:53'!
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


!classDefinition: #CabinDoorState category: #'Elevator-Ejercicio'!
Object subclass: #CabinDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 14:38:01'!
isCabinDoorOpening

	self subclassResponsibility.! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:16:42'!
isCabingDoorClosed

	self subclassResponsibility.! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:16:41'!
isCabingDoorClosing

	self subclassResponsibility.! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:16:38'!
isCabingDoorOpened

	self subclassResponsibility.! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:16:32'!
isCabingDoorOpening

	self subclassResponsibility.! !


!classDefinition: #CabinDoorClosed category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorClosed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:18:20'!
isCabingDoorClosed

	^ true.! !

!CabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:18:14'!
isCabingDoorClosing

	^ false.! !

!CabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:18:11'!
isCabingDoorOpened

	^ false.! !

!CabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:18:08'!
isCabingDoorOpening

	^ false.! !


!classDefinition: #CabinDoorClosing category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorClosing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:17:59'!
isCabingDoorClosed

	^ false.! !

!CabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:17:53'!
isCabingDoorClosing

	^ true.! !

!CabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:18:02'!
isCabingDoorOpened

	^ false.! !

!CabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:18:04'!
isCabingDoorOpening

	^ false.! !


!classDefinition: #CabinDoorOpened category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorOpened
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorOpened methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:17:45'!
isCabingDoorClosed

	^ false.! !

!CabinDoorOpened methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:17:46'!
isCabingDoorClosing

	^ false.! !

!CabinDoorOpened methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:17:37'!
isCabingDoorOpened

	^ true.! !

!CabinDoorOpened methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:17:41'!
isCabingDoorOpening

	^ false.! !


!classDefinition: #CabinDoorOpening category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorOpening
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:17:14'!
isCabingDoorClosed

	^ false.! !

!CabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:17:20'!
isCabingDoorClosing

	^ false.! !

!CabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:17:25'!
isCabingDoorOpened

	^ false.! !

!CabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:17:29'!
isCabingDoorOpening

	^ true.! !


!classDefinition: #CabinState category: #'Elevator-Ejercicio'!
Object subclass: #CabinState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinState methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:13:52'!
isCabinMoving

	self subclassResponsibility.! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:13:47'!
isCabinStopped

	self subclassResponsibility.! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 14:39:12'!
isCabinWaitingForPeople

	self subclassResponsibility.! !


!classDefinition: #CabinMoving category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:28:52'!
isCabinMoving

	^ true.! !

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:28:45'!
isCabinStopped

	^ false.! !

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 14:39:22'!
isCabinWaitingForPeople

	^ false.! !


!classDefinition: #CabinStopped category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinStopped
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:14:29'!
isCabinMoving

	^false.! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:14:23'!
isCabinStopped

	^true.! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 14:39:15'!
isCabinWaitingForPeople

	^false.! !


!classDefinition: #CabinWaitingForPeople category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinWaitingForPeople
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinWaitingForPeople methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 14:39:36'!
isCabinMoving

	^false.! !

!CabinWaitingForPeople methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 14:39:31'!
isCabinStopped

	^false.! !

!CabinWaitingForPeople methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 14:39:40'!
isCabinWaitingForPeople

	^true.! !


!classDefinition: #CurrentElevatorState category: #'Elevator-Ejercicio'!
Object subclass: #CurrentElevatorState
	instanceVariableNames: 'state cabinState cabinDoorState cabinFloorNumber currentState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:05:52'!
cabinDoorClosed

	currentState cabinDoorClosed: self.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:19:09'!
cabinDoorOpened

	currentState cabinDoorOpened: self.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:00:58'!
cabinDoorState

	^ cabinDoorState.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:01:03'!
cabinFloorNumber

	^ cabinFloorNumber.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:19:53'!
cabinOnFloor: aFloorNumber

	currentState cabinOnFloor: aFloorNumber with: self  onFloorNumber: cabinFloorNumber.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:01:06'!
cabinState

	^ cabinState.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:02:30'!
changeToState0

	state := IdleElevatorState new.
	cabinState := CabinStopped new.
	cabinDoorState := CabinDoorOpened new.
	cabinFloorNumber := 0.
	currentState := State0 new.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:03:03'!
changeToState1

	state := WorkingElevatorState new.
	cabinState := CabinStopped new.
	cabinDoorState := CabinDoorClosing new.
	currentState := State1 new.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:03:08'!
changeToState2

	state := WorkingElevatorState new.
	cabinState := CabinMoving new.
	cabinDoorState := CabinDoorClosed new.
	currentState := State2 new.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:03:18'!
changeToState3: aFloorNumber

	cabinFloorNumber := aFloorNumber.
	state := WorkingElevatorState new.
	cabinState := CabinStopped new.
	cabinDoorState := CabinDoorOpening new.
	currentState := State3 new.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:03:23'!
changeToState4

	state := IdleElevatorState new.
	cabinState := CabinStopped new.
	cabinDoorState := CabinDoorOpened new.
	currentState := State4 new.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:03:29'!
changeToState5

	state := WorkingElevatorState new.
	cabinState := CabinWaitingForPeople new.
	cabinDoorState := CabinDoorOpening new.
	currentState := State5 new.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:03:36'!
changeToState6

	state := WorkingElevatorState new.
	cabinState := CabinWaitingForPeople new.
	cabinDoorState := CabinDoorOpened new.
	currentState := State6 new.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:03:41'!
changeToState7

	state := WorkingElevatorState new.
	cabinState := CabinStopped new.
	cabinDoorState := CabinDoorOpening new.
	currentState := State7 new.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:20:31'!
closeCabinDoor

	currentState closeCabinDoorWith: self.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:20:47'!
goUpPushedFromFloor: aFloorNumber 

	currentState goUpPushedFromFloor: aFloorNumber with: self.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:07:06'!
initialize

	super initialize.
	self changeToState0.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:21:02'!
openCabinDoor

	currentState openCabinDoorWith: self.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:01:09'!
state

	^ state.! !

!CurrentElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:21:14'!
waitForPeopleTimedOut
	
	currentState waitForPeopleTimedOutWith: self.! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'floorsToGo finalState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:21:46'!
cabinDoorClosed
	
	"state := WorkingElevatorState new.
	cabinState := CabinMoving new.
	cabinDoorState := CabinDoorClosed new."
	
	finalState cabinDoorClosed.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:21:50'!
cabinDoorOpened
	
	"( self isCabinWaitingForPeople ) 
		ifTrue: [ state := WorkingElevatorState new ] 
		ifFalse: [ 
			state := IdleElevatorState new.
			cabinState := CabinStopped new.	
				 ].
	cabinDoorState := CabinDoorOpened new."
	
	finalState cabinDoorOpened.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 14:43:02'!
cabinFloorNumber
	
	^ (finalState cabinFloorNumber)! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:21:56'!
cabinOnFloor: aFloorNumber

	"cabinFloorNumber := aFloorNumber.
	state := WorkingElevatorState new.
	cabinState := CabinStopped new.
	cabinDoorState := CabinDoorOpening new.
	floorsToGo remove: aFloorNumber.
	( ( floorsToGo size ) > 0 ) 
		ifTrue: [ cabinState := CabinWaitingForPeople new]
		ifFalse: [ cabinState := CabinStopped new ]."
		
	finalState cabinOnFloor: aFloorNumber.	
	
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:22:01'!
closeCabinDoor
	
	"cabinState := CabinStopped new.
	cabinDoorState := CabinDoorClosing new."
	
	finalState closeCabinDoor.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:22:04'!
goUpPushedFromFloor: aFloorNumber 
	
	"cabinFloorNumber := aFloorNumber.
	state := WorkingElevatorState new.
	cabinState := CabinStopped new.
	cabinDoorState := CabinDoorClosing new.
	floorsToGo add: aFloorNumber."
	
	finalState goUpPushedFromFloor: aFloorNumber.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:21:29'!
initialize
	
	super initialize.
	finalState := CurrentElevatorState new.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 14:41:08'!
isCabinDoorClosed
	
	^ (finalState cabinDoorState) isCabingDoorClosed.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 14:41:15'!
isCabinDoorClosing
	
	^ (finalState cabinDoorState) isCabingDoorClosing.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 14:38:18'!
isCabinDoorOpened
	
	^( finalState cabinDoorState) isCabingDoorOpened. "cabinDoorState isCabingDoorOpened."! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 14:41:21'!
isCabinDoorOpening
	
	^ (finalState cabinDoorState) isCabingDoorOpening.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 14:41:28'!
isCabinMoving
	
	^ (finalState cabinState) isCabinMoving.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 14:41:39'!
isCabinStopped
	
	^ (finalState cabinState) isCabinStopped.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 14:41:45'!
isCabinWaitingForPeople

	^ (finalState cabinState) isCabinWaitingForPeople.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 14:41:51'!
isIdle

	^ (finalState state) isIdle.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 14:41:57'!
isWorking

	^ (finalState state) isWorking.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:22:10'!
openCabinDoor

	"( state isKindOf: IdleElevatorState ) 
		ifTrue: [ cabinDoorState := CabinDoorOpened new ]
		ifFalse: [ 
			( cabinState isKindOf: CabinMoving ) ifTrue: [ cabinDoorState := CabinDoorClosed new ].
			( cabinState isKindOf: CabinStopped ) ifTrue: [ cabinDoorState := CabinDoorOpening new].
			 ]
	"
	
	finalState openCabinDoor.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:22:14'!
waitForPeopleTimedOut
	
	"cabinDoorState := CabinDoorClosing new.
	cabinState := CabinStopped new."
	
	finalState waitForPeopleTimedOut.! !


!classDefinition: #ElevatorState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:10:04'!
isIdle

	self subclassResponsibility.! !

!ElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:10:07'!
isWorking

	self subclassResponsibility.! !


!classDefinition: #IdleElevatorState category: #'Elevator-Ejercicio'!
ElevatorState subclass: #IdleElevatorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!IdleElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:10:16'!
isIdle

	^ true.! !

!IdleElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:10:22'!
isWorking

	^ false.! !


!classDefinition: #WorkingElevatorState category: #'Elevator-Ejercicio'!
ElevatorState subclass: #WorkingElevatorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!WorkingElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:10:37'!
isIdle

	^false! !

!WorkingElevatorState methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:10:44'!
isWorking

	^true.! !


!classDefinition: #State category: #'Elevator-Ejercicio'!
Object subclass: #State
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!State methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:07:25'!
cabinDoorClosed: anElevatorState

	self subclassResponsibility.! !

!State methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:08:17'!
cabinDoorOpened: anElevatorState

	self subclassResponsibility.! !

!State methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:13:13'!
cabinOnFloor: aFloorNumber with: anElevatorState onFloorNumber: currentFloorNumber

	self subclassResponsibility.! !

!State methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:08:30'!
closeCabinDoorWith: anElevatorState

	self subclassResponsibility.! !

!State methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:08:13'!
goUpPushedFromFloor: aFloorNumber with: anElevatorState

	self subclassResponsibility.! !

!State methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:08:27'!
openCabinDoorWith: anElevatorState

	self subclassResponsibility.! !

!State methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:28:47'!
raiseError
	
	^self error: ( ElevatorEmergency new ).! !

!State methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:08:46'!
waitForPeopleTimedOutWith: anElevatorState

	self subclassResponsibility.! !


!classDefinition: #State0 category: #'Elevator-Ejercicio'!
State subclass: #State0
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!State0 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:26:09'!
cabinDoorClosed: anElevatorState

	anElevatorState raiseError.! !

!State0 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:23:55'!
closeCabinDoorWith: anElevatorState

	! !

!State0 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:09:44'!
goUpPushedFromFloor: aFloorNumber with: anElevatorState
	
	anElevatorState changeToState1.! !

!State0 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:10:18'!
openCabinDoorWith: anElevatorState

	anElevatorState changeToState4.! !


!classDefinition: #State1 category: #'Elevator-Ejercicio'!
State subclass: #State1
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!State1 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:11:03'!
cabinDoorClosed: anElevatorState

	anElevatorState changeToState2.! !

!State1 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:11:22'!
openCabinDoorWith: anElevatorState

	anElevatorState changeToState7.! !


!classDefinition: #State2 category: #'Elevator-Ejercicio'!
State subclass: #State2
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!State2 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:26:23'!
cabinDoorClosed: anElevatorState

	anElevatorState raiseError.! !

!State2 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:26:32'!
cabinOnFloor: aFloorNumber with: anElevatorState onFloorNumber: currentFloorNumber

	
	( aFloorNumber > ( currentFloorNumber + 1) ) 
		ifTrue: [ anElevatorState raiseError. ]
		ifFalse: [ anElevatorState changeToState3: aFloorNumber ].! !

!State2 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:15:44'!
closeCabinDoorWith: anElevatorState! !

!State2 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:13:37'!
goUpPushedFromFloor: aFloorNumber with: anElevatorState

	anElevatorState changeToState5.! !

!State2 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:15:55'!
openCabinDoorWith: anElevatorState! !


!classDefinition: #State3 category: #'Elevator-Ejercicio'!
State subclass: #State3
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!State3 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:26:44'!
cabinDoorClosed: anElevatorState

	anElevatorState raiseError.! !

!State3 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:22:39'!
cabinDoorOpened: anElevatorState

	anElevatorState changeToState4.! !

!State3 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:26:47'!
cabinOnFloor: aFloorNumber with: anElevatorState onFloorNumber: currentFloorNumber

	anElevatorState raiseError.! !

!State3 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:14:31'!
closeCabinDoorWith: anElevatorState! !

!State3 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:15:02'!
goUpPushedFromFloor: aFloorNumber with: anElevatorState

	anElevatorState changeToState5.! !

!State3 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:15:14'!
openCabinDoorWith: anElevatorState! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'State3 class' category: #'Elevator-Ejercicio'!
State3 class
	instanceVariableNames: ''!

!State3 class methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 14:07:38'!
with: aFloorNumber

	^self new initializeWith: aFloorNumber.! !


!classDefinition: #State4 category: #'Elevator-Ejercicio'!
State subclass: #State4
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!State4 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:16:20'!
closeCabinDoorWith: anElevatorState

	anElevatorState changeToState1.! !

!State4 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:16:36'!
waitForPeopleTimedOutWith: anElevatorState

	anElevatorState changeToState1.! !


!classDefinition: #State5 category: #'Elevator-Ejercicio'!
State subclass: #State5
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!State5 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:16:52'!
cabinDoorOpened: anElevatorState

	anElevatorState changeToState6.! !

!State5 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:17:36'!
cabinOnFloor: aFloorNumber with: anElevatorState onFloorNumber: currentFloorNumber

	anElevatorState changeToState3: aFloorNumber.! !


!classDefinition: #State6 category: #'Elevator-Ejercicio'!
State subclass: #State6
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!State6 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:18:01'!
closeCabinDoorWith: anElevatorState

	anElevatorState changeToState1.! !

!State6 methodsFor: 'as yet unclassified' stamp: 'ad 10/2/2017 15:18:18'!
waitForPeopleTimedOutWith: anElevatorState

	anElevatorState changeToState1.! !


!classDefinition: #State7 category: #'Elevator-Ejercicio'!
State subclass: #State7
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!
