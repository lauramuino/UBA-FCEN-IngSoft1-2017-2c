!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'aFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'testing' stamp: 'lm 10/31/2017 13:25:47'!
test01unCarritoNuevoEstaVacio
	|unCarrito|
	unCarrito := TestInstanceFactory new emptyCartWithEmptyCatalog.
	
	self assert: unCarrito isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'lm 10/31/2017 13:25:57'!
test02siSeAgregaUnLibroDeLaEditorialAUnCarritoDejaDeSerVacio
	| aCart |
	aCart _ TestInstanceFactory new cartWithAProduct.

	self deny: aCart isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'lm 10/31/2017 13:31:45'!
test03noSePuedenAgregarLIbrosDeOtraEditorialAUnCarrito
	| unCarrito anIsbnNumber |
	anIsbnNumber _ 1234.
	unCarrito _ TestInstanceFactory new emptyCartWithEmptyCatalog.
	
	self should: [unCarrito add: anIsbnNumber withQuantity: 1 ]
		 raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = Carrito ErrorItemDebePertenecerAlCatalogo.
			self assert: unCarrito isEmpty ].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'lm 10/31/2017 13:31:36'!
test04siSeAgregaUnLibroAlCarritoDebePertenecerAlCarrito
	| unCarrito anIsbnNumber |
	anIsbnNumber _ 1234.
	unCarrito _ TestInstanceFactory new cartWithAProduct .

	self assert: (unCarrito contains: anIsbnNumber).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'lm 10/31/2017 13:35:36'!
test05noSePuedenAgregarCantidadesNoEnterasDeLibrosAUnCarrito
	| aCatalog unCarrito anIsbnNumber |
	anIsbnNumber _ 1234.
	aCatalog _ Dictionary new.
	aCatalog add: (Association key: anIsbnNumber value: 20).
	unCarrito := TestInstanceFactory new emptyCartWithCatalog: aCatalog.

	self should: [ unCarrito add: anIsbnNumber withQuantity: 1.5 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Carrito ErrorCantidadDeItemsDebeSerEntera.
			self assert: unCarrito isEmpty ].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'lm 10/31/2017 13:32:28'!
test06unLibroQueNoSeAgregoAlCarritoNoPerteneceAlCarrito
	| unCarrito anIsbnNumber |
	anIsbnNumber _ 1234.
	unCarrito _ TestInstanceFactory new emptyCartWithEmptyCatalog .
	self deny: (unCarrito contains: anIsbnNumber).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'lm 10/31/2017 13:39:28'!
test07noSePuedeHacerCheckoutDeUnCarritoVacio

	| aCart aCashier aCard salesBook |
	aCart _ TestInstanceFactory new emptyCartWithEmptyCatalog .
	salesBook := OrderedCollection new.
	aCard := Tarjeta withCardID: 1234 withClientName: 'TABARE'  withExpirationMonth: 2 withExpirationYear: 2019 .
	aCashier := Cajera withCart: aCart withCheckoutDate: Date today withCard: aCard withSalesBook: salesBook.

	self
		should: [ aCashier checkout. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cajera ErrorCheckOutDeCarritoVacio.
			self assert: salesBook isEmpty. ].
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'lm 10/31/2017 13:41:28'!
test08noSePuedeHacerCheckoutDeUnCarritoConUnaTarjetaVencida

	| aCart aCashier aCard salesBook |
	aCart _ TestInstanceFactory new cartWithAProduct.
	
	salesBook := OrderedCollection new.
	aCard := Tarjeta withCardID: 1235 withClientName: 'TABARE'  withExpirationMonth: 2 withExpirationYear: ( ( Date today year yearNumber ) - 1 ) .
	aCashier := Cajera withCart: aCart withCheckoutDate: Date today withCard: aCard withSalesBook: salesBook.
	
	self
		should: [ aCashier checkout. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cajera ErrorTarjetaVencida.
			self assert: salesBook isEmpty. ].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'lm 10/31/2017 13:41:52'!
test09checkoutConTarjetaValidaGeneraUnaEntradaEnElLibroDeVentasAsociadoAlCarritoCorrespondiente

	| aCatalog unCarrito aCashier aCard salesBook anIsbnNumber totalAmount |
	aCatalog _ Dictionary new.
	anIsbnNumber _ 1235.
	aCatalog add: ( Association key: anIsbnNumber value: 20).
	unCarrito _ Carrito withCatalog: aCatalog.
	unCarrito add: anIsbnNumber withQuantity: 2.
	
	salesBook := OrderedCollection new.
	aCard := Tarjeta withCardID: 1234 withClientName: 'TABARE'  withExpirationMonth: 2 withExpirationYear: ( ( Date today year yearNumber ) + 1 ) .
	aCashier := Cajera withCart: unCarrito withCheckoutDate: Date today withCard: aCard withSalesBook: salesBook.
	totalAmount := aCashier checkout.
	
	self assert: totalAmount = 40.
	salesBook find: unCarrito.! !


!classDefinition: #Cajera category: #TusLibros!
Object subclass: #Cajera
	instanceVariableNames: 'checkoutDate cart card salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cajera methodsFor: 'as yet unclassified' stamp: 'lm 10/30/2017 21:32:24'!
checkout

	cart isEmpty ifTrue: [ ^ self error: Cajera ErrorCheckOutDeCarritoVacio ].
	
	(card validateWithDate: checkoutDate) ifTrue: [ self error: Cajera ErrorTarjetaVencida ].
	
	salesBook add: cart.
	
	^ cart totalAmountOfItems.! !

!Cajera methodsFor: 'as yet unclassified' stamp: 'lm 10/30/2017 20:57:09'!
withCart: aCart withCheckoutDate: aDate withCard: aCard withSalesBook: aSalesBook

	cart:= aCart.
	checkoutDate:= aDate. 
	card := aCard.
	salesBook := aSalesBook.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cajera class' category: #TusLibros!
Cajera class
	instanceVariableNames: ''!

!Cajera class methodsFor: 'error message' stamp: 'ad 10/30/2017 18:20:37'!
ErrorCheckOutDeCarritoVacio
	^ 'No se puede hacer checkout de un carrito vacio'.! !

!Cajera class methodsFor: 'error message' stamp: 'lm 10/30/2017 18:58:18'!
ErrorTarjetaVencida
	^ 'No se puede hacer checkout de un carrito con una tarjeta vencida'.! !

!Cajera class methodsFor: 'error message' stamp: 'lm 10/30/2017 20:54:37'!
withCart: aCart withCheckoutDate: aDate withCard: aCard withSalesBook: aSalesBook

	^self new withCart: aCart withCheckoutDate: aDate withCard: aCard withSalesBook: aSalesBook! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'products catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'adding' stamp: 'lm 10/31/2017 11:18:10'!
add: anItem withQuantity: aQuantity

	(aQuantity isKindOf: Integer) ifFalse: [ self error: Carrito ErrorCantidadDeItemsDebeSerEntera ].
	
	( catalog includesKey: anItem) ifFalse: [ self error: Carrito ErrorItemDebePertenecerAlCatalogo ].
	
	products add: anItem withOccurrences: aQuantity.! !


!Carrito methodsFor: 'initialization' stamp: 'lm 10/31/2017 11:19:47'!
withCatalog: aCatalog.

	products := Bag new.
	catalog := aCatalog.! !


!Carrito methodsFor: 'testing' stamp: 'ad 10/29/2017 19:00:22'!
contains: item
	^ products includes: item.! !

!Carrito methodsFor: 'testing' stamp: 'lm 10/26/2017 20:05:05'!
isEmpty
	^products isEmpty.! !


!Carrito methodsFor: 'as yet unclassified' stamp: 'ad 10/30/2017 18:29:24'!
listItemsWithQuantities
	
	|listOfItems|
	
	listOfItems := Dictionary new.
	
	(products asSet) do: [ :item | 
		listOfItems add: ( Association key: item value: (products occurrencesOf: item) ). ].
	
	^listOfItems.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'lm 10/30/2017 21:18:20'!
totalAmountOfItems
	
	|total|
	
	total := 0.
	
	(products asSet) do: [ :item | 
		total := total + ( (products occurrencesOf: item) * (catalog at: item ) ). ].
	
	^total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: #TusLibros!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'initialization' stamp: 'lm 10/26/2017 20:21:49'!
withCatalog: aCatalog
	^self new withCatalog: aCatalog.! !


!Carrito class methodsFor: 'error message' stamp: 'ad 10/29/2017 19:02:39'!
ErrorCantidadDeItemsDebeSerEntera
	^ 'La cantidad de items a agregar debe ser entera'.! !

!Carrito class methodsFor: 'error message' stamp: 'ad 10/29/2017 19:02:49'!
ErrorItemDebePertenecerAlCatalogo
	^ 'El item a agregar debe pertenecer al catalogo'.! !


!classDefinition: #Tarjeta category: #TusLibros!
Object subclass: #Tarjeta
	instanceVariableNames: 'cardID clientName expirationMonth expirationYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Tarjeta methodsFor: 'as yet unclassified' stamp: 'lm 10/30/2017 20:50:39'!
validateWithDate: aDate

	^( expirationYear < aDate year yearNumber ) or: [ ( expirationYear = aDate year yearNumber ) and: [ expirationMonth < aDate month monthIndex ] ].
	! !

!Tarjeta methodsFor: 'as yet unclassified' stamp: 'lm 10/30/2017 19:04:35'!
withCardID: aCardID withClientName: aClientName withExpirationMonth: aMonth withExpirationYear: aYear

	cardID := aCardID.
	clientName := aClientName.
	expirationMonth := aMonth.
	expirationYear := aYear.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tarjeta class' category: #TusLibros!
Tarjeta class
	instanceVariableNames: ''!

!Tarjeta class methodsFor: 'as yet unclassified' stamp: 'lm 10/30/2017 19:04:56'!
withCardID: aCardID withClientName: aClientName withExpirationMonth: aMonth withExpirationYear: aYear

	^ self new withCardID: aCardID withClientName: aClientName withExpirationMonth: aMonth withExpirationYear: aYear.! !


!classDefinition: #TestInstanceFactory category: #TusLibros!
Object subclass: #TestInstanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestInstanceFactory methodsFor: 'cartInstances' stamp: 'lm 10/31/2017 13:13:11'!
cartWithAProduct
	| aCatalog aCart anIsbnNumber |
	
	anIsbnNumber _ 1234.
	
	aCatalog _ Dictionary new.
	aCatalog add: (Association key: anIsbnNumber value: 20).
	
	aCart _ Carrito withCatalog: aCatalog.
	aCart add: anIsbnNumber withQuantity: 1.
	^aCart.! !

!TestInstanceFactory methodsFor: 'cartInstances' stamp: 'lm 10/31/2017 13:14:25'!
cartWithProduct: anIsbnNumber withCatalog: aCatalog
	| aCart|
	
	aCart _ Carrito withCatalog: aCatalog.
	aCart add: anIsbnNumber withQuantity: 1.
	^aCart.! !

!TestInstanceFactory methodsFor: 'cartInstances' stamp: 'lm 10/31/2017 13:28:00'!
emptyCartWithCatalog: aCatalog
	| aCart|
	aCart _ Carrito withCatalog: aCatalog.
	^aCart.! !

!TestInstanceFactory methodsFor: 'cartInstances' stamp: 'lm 10/31/2017 13:12:28'!
emptyCartWithEmptyCatalog

	^Carrito withCatalog: Dictionary new.! !
