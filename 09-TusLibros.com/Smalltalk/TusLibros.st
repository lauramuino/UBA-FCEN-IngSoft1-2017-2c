!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'testInstanceFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/31/2017 17:04:56'!
test01unCarritoNuevoEstaVacio
	|unCarrito|
	unCarrito := testInstanceFactory emptyCartWithEmptyCatalog.
	
	self assert: unCarrito isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/31/2017 17:04:51'!
test02siSeAgregaUnLibroDeLaEditorialAUnCarritoDejaDeSerVacio
	| aCart |
	aCart _  testInstanceFactory cartWithAProduct.

	self deny: aCart isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/31/2017 17:05:07'!
test03noSePuedenAgregarLIbrosDeOtraEditorialAUnCarrito
	| unCarrito anIsbnNumber |
	anIsbnNumber _ 1234.
	unCarrito _ testInstanceFactory emptyCartWithEmptyCatalog.
	self
		should: [
			unCarrito
				add: anIsbnNumber
				withQuantity: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart ErrorItemDebePertenecerAlCatalogo.
			self assert: unCarrito isEmpty ].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/31/2017 17:04:38'!
test04siSeAgregaUnLibroAlCarritoDebePertenecerAlCarrito
	| unCarrito anIsbnNumber |
	anIsbnNumber _ 1234.
	unCarrito _ testInstanceFactory cartWithAProduct .

	self assert: (unCarrito contains: anIsbnNumber).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/31/2017 17:05:07'!
test05noSePuedenAgregarCantidadesNoEnterasDeLibrosAUnCarrito
	| aCatalog unCarrito anIsbnNumber |
	anIsbnNumber _ 1234.
	aCatalog _ Dictionary new.
	aCatalog add:
		(Association
			key: anIsbnNumber
			value: 20).
	unCarrito _ testInstanceFactory emptyCartWithCatalog: aCatalog.
	self
		should: [
			unCarrito
				add: anIsbnNumber
				withQuantity: 1.5 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart ErrorCantidadDeItemsDebeSerEntera.
			self assert: unCarrito isEmpty ].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/31/2017 17:04:13'!
test06unLibroQueNoSeAgregoAlCarritoNoPerteneceAlCarrito
	| unCarrito anIsbnNumber |
	anIsbnNumber _ 1234.
	unCarrito _ testInstanceFactory emptyCartWithEmptyCatalog .
	self deny: (unCarrito contains: anIsbnNumber).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/31/2017 17:06:00'!
test07noSePuedeHacerCheckoutDeUnCarritoVacio
	| aCart aCashier aCard salesBook |
	aCart _ testInstanceFactory emptyCartWithEmptyCatalog.
	salesBook _ OrderedCollection new.
	aCard _ testInstanceFactory validCard.
	aCashier _ Cashier
		withCart: aCart
		withCheckoutDate: Date today
		withCard: aCard
		withSalesBook: salesBook.
	self
		should: [ aCashier checkout ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorCheckOutDeCarritoVacio.
			self assert: salesBook isEmpty ].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/31/2017 17:06:00'!
test08noSePuedeHacerCheckoutDeUnCarritoConUnaTarjetaVencida
	| aCart aCashier aCard salesBook |
	aCart _ testInstanceFactory cartWithAProduct.
	salesBook _ OrderedCollection new.
	aCard _ testInstanceFactory expiredCard.
	aCashier _ Cashier
		withCart: aCart
		withCheckoutDate: Date today
		withCard: aCard
		withSalesBook: salesBook.
	self
		should: [ aCashier checkout ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorTarjetaVencida.
			self assert: salesBook isEmpty ].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/31/2017 17:06:00'!
test09checkoutConTarjetaValidaGeneraUnaEntradaEnElLibroDeVentasAsociadoAlCarritoCorrespondiente
	| aCatalog unCarrito aCashier aCard salesBook anIsbnNumber totalAmount |
	aCatalog _ Dictionary new.
	anIsbnNumber _ 1235.
	aCatalog add:
		(Association
			key: anIsbnNumber
			value: 20).
	unCarrito _ Cart withCatalog: aCatalog.
	unCarrito
		add: anIsbnNumber
		withQuantity: 2.
	salesBook _ OrderedCollection new.
	aCard _ testInstanceFactory validCard.
	aCashier _ Cashier
		withCart: unCarrito
		withCheckoutDate: Date today
		withCard: aCard
		withSalesBook: salesBook.
	totalAmount _ aCashier checkout.
	self assert: totalAmount = 40.
	salesBook find: unCarrito.! !


!TusLibrosTest methodsFor: 'setUp' stamp: 'ad 10/31/2017 17:02:52'!
setUp

	testInstanceFactory := TestInstanceFactory new.! !


!classDefinition: #Card category: #TusLibros!
Object subclass: #Card
	instanceVariableNames: 'cardID clientName expirationMonth expirationYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'as yet unclassified' stamp: 'lm 10/30/2017 20:50:39'!
validateWithDate: aDate

	^( expirationYear < aDate year yearNumber ) or: [ ( expirationYear = aDate year yearNumber ) and: [ expirationMonth < aDate month monthIndex ] ].
	! !

!Card methodsFor: 'as yet unclassified' stamp: 'lm 10/30/2017 19:04:35'!
withCardID: aCardID withClientName: aClientName withExpirationMonth: aMonth withExpirationYear: aYear

	cardID := aCardID.
	clientName := aClientName.
	expirationMonth := aMonth.
	expirationYear := aYear.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #TusLibros!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'as yet unclassified' stamp: 'lm 10/30/2017 19:04:56'!
withCardID: aCardID withClientName: aClientName withExpirationMonth: aMonth withExpirationYear: aYear

	^ self new withCardID: aCardID withClientName: aClientName withExpirationMonth: aMonth withExpirationYear: aYear.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'products catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'adding' stamp: 'ad 10/31/2017 17:05:07'!
add: anItem withQuantity: aQuantity
	(aQuantity isKindOf: Integer) ifFalse: [ self error: Cart ErrorCantidadDeItemsDebeSerEntera ].
	(catalog includesKey: anItem) ifFalse: [ self error: Cart ErrorItemDebePertenecerAlCatalogo ].
	products
		add: anItem
		withOccurrences: aQuantity.! !


!Cart methodsFor: 'initialization' stamp: 'lm 10/31/2017 11:19:47'!
withCatalog: aCatalog.

	products := Bag new.
	catalog := aCatalog.! !


!Cart methodsFor: 'testing' stamp: 'ad 10/29/2017 19:00:22'!
contains: item
	^ products includes: item.! !

!Cart methodsFor: 'testing' stamp: 'lm 10/26/2017 20:05:05'!
isEmpty
	^products isEmpty.! !


!Cart methodsFor: 'as yet unclassified' stamp: 'ad 10/30/2017 18:29:24'!
listItemsWithQuantities
	
	|listOfItems|
	
	listOfItems := Dictionary new.
	
	(products asSet) do: [ :item | 
		listOfItems add: ( Association key: item value: (products occurrencesOf: item) ). ].
	
	^listOfItems.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'lm 10/30/2017 21:18:20'!
totalAmountOfItems
	
	|total|
	
	total := 0.
	
	(products asSet) do: [ :item | 
		total := total + ( (products occurrencesOf: item) * (catalog at: item ) ). ].
	
	^total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'initialization' stamp: 'lm 10/26/2017 20:21:49'!
withCatalog: aCatalog
	^self new withCatalog: aCatalog.! !


!Cart class methodsFor: 'error message' stamp: 'ad 10/29/2017 19:02:39'!
ErrorCantidadDeItemsDebeSerEntera
	^ 'La cantidad de items a agregar debe ser entera'.! !

!Cart class methodsFor: 'error message' stamp: 'ad 10/29/2017 19:02:49'!
ErrorItemDebePertenecerAlCatalogo
	^ 'El item a agregar debe pertenecer al catalogo'.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'checkoutDate cart card salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'ad 10/31/2017 17:06:00'!
checkout
	cart isEmpty ifTrue: [ ^ self error: Cashier ErrorCheckOutDeCarritoVacio ].
	(card validateWithDate: checkoutDate) ifTrue: [ self error: Cashier ErrorTarjetaVencida ].
	salesBook add: cart.
	^ cart totalAmountOfItems.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'lm 10/30/2017 20:57:09'!
withCart: aCart withCheckoutDate: aDate withCard: aCard withSalesBook: aSalesBook

	cart:= aCart.
	checkoutDate:= aDate. 
	card := aCard.
	salesBook := aSalesBook.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error message' stamp: 'ad 10/30/2017 18:20:37'!
ErrorCheckOutDeCarritoVacio
	^ 'No se puede hacer checkout de un carrito vacio'.! !

!Cashier class methodsFor: 'error message' stamp: 'lm 10/30/2017 18:58:18'!
ErrorTarjetaVencida
	^ 'No se puede hacer checkout de un carrito con una tarjeta vencida'.! !

!Cashier class methodsFor: 'error message' stamp: 'lm 10/30/2017 20:54:37'!
withCart: aCart withCheckoutDate: aDate withCard: aCard withSalesBook: aSalesBook

	^self new withCart: aCart withCheckoutDate: aDate withCard: aCard withSalesBook: aSalesBook! !


!classDefinition: #TestInstanceFactory category: #TusLibros!
Object subclass: #TestInstanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestInstanceFactory methodsFor: 'cartInstances' stamp: 'ad 10/31/2017 17:05:07'!
cartWithAProduct
	| aCatalog aCart anIsbnNumber |
	anIsbnNumber _ 1234.
	aCatalog _ Dictionary new.
	aCatalog add:
		(Association
			key: anIsbnNumber
			value: 20).
	aCart _ Cart withCatalog: aCatalog.
	aCart
		add: anIsbnNumber
		withQuantity: 1.
	^ aCart.! !

!TestInstanceFactory methodsFor: 'cartInstances' stamp: 'ad 10/31/2017 17:05:07'!
cartWithProduct: anIsbnNumber withCatalog: aCatalog
	| aCart |
	aCart _ Cart withCatalog: aCatalog.
	aCart
		add: anIsbnNumber
		withQuantity: 1.
	^ aCart.! !

!TestInstanceFactory methodsFor: 'cartInstances' stamp: 'ad 10/31/2017 17:05:07'!
emptyCartWithCatalog: aCatalog
	| aCart |
	aCart _ Cart withCatalog: aCatalog.
	^ aCart.! !

!TestInstanceFactory methodsFor: 'cartInstances' stamp: 'ad 10/31/2017 17:05:07'!
emptyCartWithEmptyCatalog
	^ Cart withCatalog: Dictionary new.! !


!TestInstanceFactory methodsFor: 'cardInstances' stamp: 'ad 10/31/2017 17:05:44'!
expiredCard
	^ Card
		withCardID: 1235
		withClientName: 'TABARE'
		withExpirationMonth: 2
		withExpirationYear: Date today year yearNumber - 1.! !

!TestInstanceFactory methodsFor: 'cardInstances' stamp: 'ad 10/31/2017 17:05:44'!
validCard
	^ Card
		withCardID: 1235
		withClientName: 'TABARE'
		withExpirationMonth: 2
		withExpirationYear: Date today year yearNumber + 1.! !
