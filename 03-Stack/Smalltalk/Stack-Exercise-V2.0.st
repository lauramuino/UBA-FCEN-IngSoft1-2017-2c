!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'ad 9/16/2017 11:53:10'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #Node category: #'Stack-Exercise'!
Object subclass: #Node
	instanceVariableNames: 'next previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Node methodsFor: 'accesing' stamp: 'ad 9/16/2017 12:33:08'!
next

	self subclassResponsibility .! !

!Node methodsFor: 'accesing' stamp: 'ad 9/16/2017 12:33:03'!
next: aNode

	self subclassResponsibility.! !

!Node methodsFor: 'accesing' stamp: 'ad 9/16/2017 12:32:52'!
previous

	self subclassResponsibility.! !

!Node methodsFor: 'accesing' stamp: 'ad 9/16/2017 12:34:17'!
previous: aNode

	self subclassResponsibility.! !

!Node methodsFor: 'accesing' stamp: 'ad 9/16/2017 12:34:23'!
value

	self subclassResponsibility.! !


!Node methodsFor: 'testing' stamp: 'ad 9/16/2017 12:36:30'!
isNil

	self subclassResponsibility.! !


!classDefinition: #NilNode category: #'Stack-Exercise'!
Node subclass: #NilNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NilNode methodsFor: 'accesing' stamp: 'ad 9/17/2017 13:30:26'!
next

	^self! !

!NilNode methodsFor: 'accesing' stamp: 'ad 9/16/2017 12:34:47'!
next: aNode

	! !

!NilNode methodsFor: 'accesing' stamp: 'ad 9/17/2017 13:30:39'!
previous

	^self.! !

!NilNode methodsFor: 'accesing' stamp: 'ad 9/16/2017 12:34:53'!
previous: aNode

	! !

!NilNode methodsFor: 'accesing' stamp: 'ad 9/17/2017 13:21:29'!
value

	self error: OOStack stackEmptyErrorDescription.! !


!NilNode methodsFor: 'testing' stamp: 'ad 9/16/2017 12:36:11'!
isNil

	^true.
	! !


!NilNode methodsFor: 'initialization' stamp: 'ad 9/17/2017 13:31:32'!
initialize

	super initialize.
	next := self.
	previous := self.! !


!classDefinition: #NonNullNode category: #'Stack-Exercise'!
Node subclass: #NonNullNode
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NonNullNode methodsFor: 'accesing' stamp: 'ad 9/16/2017 12:32:03'!
next

	^next.! !

!NonNullNode methodsFor: 'accesing' stamp: 'ad 9/16/2017 12:32:03'!
next: aNode

	next := aNode.! !

!NonNullNode methodsFor: 'accesing' stamp: 'ad 9/16/2017 12:32:03'!
previous

	^previous.! !

!NonNullNode methodsFor: 'accesing' stamp: 'ad 9/16/2017 12:32:03'!
previous: aNode

	previous := aNode.! !

!NonNullNode methodsFor: 'accesing' stamp: 'ad 9/16/2017 12:32:03'!
value

	^value.! !


!NonNullNode methodsFor: 'testing' stamp: 'ad 9/16/2017 12:36:18'!
isNil

	^false.! !


!NonNullNode methodsFor: 'initialization' stamp: 'ad 9/16/2017 12:35:21'!
initializeWith: aValue

	value := aValue.
	self next: NilNode new.
	self previous: NilNode new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonNullNode class' category: #'Stack-Exercise'!
NonNullNode class
	instanceVariableNames: ''!

!NonNullNode class methodsFor: 'as yet unclassified' stamp: 'ad 9/16/2017 12:32:03'!
with: aValue

	^self new initializeWith: aValue.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'ad 9/17/2017 13:20:30'!
isEmpty
	
	^ top isNil.! !


!OOStack methodsFor: 'adding' stamp: 'ad 9/17/2017 13:34:49'!
push: aString

	| newNode |
	
	newNode := NonNullNode with: aString.
	top next: newNode.
	newNode previous: top.
	top _ newNode.
	size := size + 1.! !


!OOStack methodsFor: 'removing' stamp: 'ad 9/17/2017 13:33:39'!
pop
	
	| currentTop nodeBeforeCurrent |
	
	currentTop := top value.
	nodeBeforeCurrent := top previous.
	
	nodeBeforeCurrent next: NilNode new.
	top := nodeBeforeCurrent.
	size := size - 1.
	^ currentTop.
	! !


!OOStack methodsFor: 'accessing' stamp: 'ad 9/17/2017 13:44:28'!
size

	^ size.! !

!OOStack methodsFor: 'accessing' stamp: 'ad 9/17/2017 13:21:17'!
top

	^ top value.! !


!OOStack methodsFor: 'initialization' stamp: 'ad 9/17/2017 13:36:14'!
initialize

	super initialize.
	top := NilNode new.
	size := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !
