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


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'state cabinState cabinDoorState cabinFloorNumber floorsToGo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:26:06'!
cabinDoorClosed
	
	state := WorkingElevatorState new.
	cabinState := CabinMoving new.
	cabinDoorState := CabinDoorClosed new.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 15:02:46'!
cabinDoorOpened
	
	( self isCabinWaitingForPeople ) 
		ifTrue: [ state := WorkingElevatorState new ] 
		ifFalse: [ 
			state := IdleElevatorState new.
			cabinState := CabinStopped new.	
				 ].
	cabinDoorState := CabinDoorOpened new.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:05:23'!
cabinFloorNumber
	
	^cabinFloorNumber! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 15:07:02'!
cabinOnFloor: aFloorNumber

	cabinFloorNumber := aFloorNumber.
	state := WorkingElevatorState new.
	"cabinState := CabinStopped new."
	cabinDoorState := CabinDoorOpening new.
	floorsToGo remove: aFloorNumber.
	( ( floorsToGo size ) > 0 ) 
		ifTrue: [ cabinState := CabinWaitingForPeople new]
		ifFalse: [ cabinState := CabinStopped new ].
	
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 15:04:44'!
closeCabinDoor
	
	cabinState := CabinStopped new.
	cabinDoorState := CabinDoorClosing new.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 15:10:04'!
goUpPushedFromFloor: aFloorNumber 
	
	cabinFloorNumber := aFloorNumber.
	state := WorkingElevatorState new.
	cabinState := CabinStopped new.
	cabinDoorState := CabinDoorClosing new.
	floorsToGo add: aFloorNumber.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 14:36:23'!
initialize
	super initialize.
	state := IdleElevatorState new.
	cabinState := CabinStopped new.
	cabinDoorState := CabinDoorOpened new.
	floorsToGo := OrderedCollection new.
	cabinFloorNumber  := 0.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:22:28'!
isCabinDoorClosed
	
	^ cabinDoorState isCabingDoorClosed.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:22:33'!
isCabinDoorClosing
	
	^ cabinDoorState isCabingDoorClosing.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:22:12'!
isCabinDoorOpened
	
	^ cabinDoorState isCabingDoorOpened.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:22:18'!
isCabinDoorOpening
	
	^ cabinDoorState isCabingDoorOpening.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:23:33'!
isCabinMoving
	
	^ cabinState isCabinMoving.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:15:08'!
isCabinStopped
	
	^ cabinState isCabinStopped.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 14:39:59'!
isCabinWaitingForPeople

	^ cabinState isCabinWaitingForPeople.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:12:48'!
isIdle

	^ state isIdle.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 13:12:56'!
isWorking

	^ state isWorking.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 14:02:30'!
openCabinDoor

	( state isKindOf: IdleElevatorState ) 
		ifTrue: [ cabinDoorState := CabinDoorOpened new ]
		ifFalse: [ 
			( cabinState isKindOf: CabinMoving ) ifTrue: [ cabinDoorState := CabinDoorClosed new ].
			( cabinState isKindOf: CabinStopped ) ifTrue: [ cabinDoorState := CabinDoorOpening new].
			 ]
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ad 10/1/2017 15:03:47'!
waitForPeopleTimedOut
	
	cabinDoorState := CabinDoorClosing new.
	cabinState := CabinStopped new.! !


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
