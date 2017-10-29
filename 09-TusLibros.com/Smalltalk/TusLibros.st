!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/29/2017 18:58:47'!
test01unCarritoNuevoEstaVacio

	|unCarrito|
	unCarrito:= Carrito withCatalog: OrderedCollection new.
	
	self assert: unCarrito isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/29/2017 18:59:28'!
test02siSeAgregaUnLibroDeLaEditorialAUnCarritoDejaDeSerVacio
	| aCatalog unCarrito anIsbnNumber |
	anIsbnNumber _ 1234.
	aCatalog _ OrderedCollection new.
	aCatalog add: anIsbnNumber.
	unCarrito _ Carrito withCatalog: aCatalog.
	unCarrito
		add: anIsbnNumber
		withQuantity: 1.
	self deny: unCarrito isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/29/2017 19:02:00'!
test03noSePuedenAgregarLIbrosDeOtraEditorialAUnCarrito
	| aCatalog unCarrito anIsbnNumber |
	aCatalog _ OrderedCollection new.
	anIsbnNumber _ 1235.
	unCarrito _ Carrito withCatalog: aCatalog.
	self
		should: [
			unCarrito
				add: anIsbnNumber
				withQuantity: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Carrito ErrorItemDebePertenecerAlCatalogo.
			self assert: unCarrito isEmpty ].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/29/2017 19:00:11'!
test04siSeAgregaUnLibroAlCarritoDebePertenecerAlCarrito
	| aCatalog unCarrito anIsbnNumber |
	aCatalog _ OrderedCollection new.
	anIsbnNumber _ 1235.
	aCatalog add: anIsbnNumber.
	unCarrito _ Carrito withCatalog: aCatalog.
	unCarrito
		add: anIsbnNumber
		withQuantity: 1.
	self assert: (unCarrito contains: anIsbnNumber).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/29/2017 19:01:25'!
test05noSePuedenAgregarCantidadesNoEnterasDeLibrosAUnCarrito
	| aCatalog unCarrito anIsbnNumber |
	anIsbnNumber _ 1234.
	aCatalog _ OrderedCollection new.
	aCatalog add: anIsbnNumber.
	unCarrito _ Carrito withCatalog: aCatalog.
	self
		should: [
			unCarrito
				add: anIsbnNumber
				withQuantity: 1.5 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Carrito ErrorCantidadDeItemsDebeSerEntera.
			self assert: unCarrito isEmpty ].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/29/2017 19:00:11'!
test06unLibroQueNoSeAgregoAlCarritoNoPerteneceAlCarrito
	| aCatalog unCarrito anIsbnNumber |
	aCatalog _ OrderedCollection new.
	anIsbnNumber _ 1235.
	unCarrito _ Carrito withCatalog: aCatalog.
	self deny: (unCarrito contains: anIsbnNumber).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/29/2017 20:02:22'!
test07listarLosItemsDeUnCarritoVacioDevuelveUnaColeccionVacia
	| aCatalog unCarrito |
	aCatalog _ OrderedCollection new.
	unCarrito _ Carrito withCatalog: aCatalog.
	self assert: unCarrito listItemsWithQuantities isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ad 10/29/2017 20:01:30'!
test08seDebenListarLosItemsDeUnCarritoConSuCantidad
	| aCatalog unCarrito isbnNumber isbnNumber2 listaDeItems |
	aCatalog _ OrderedCollection new.
	unCarrito _ Carrito withCatalog: aCatalog.
	isbnNumber := 4356.
	isbnNumber2  := 8741.
	aCatalog add: isbnNumber.
	aCatalog add: isbnNumber2.
	unCarrito add: isbnNumber withQuantity: 2.
	unCarrito add: isbnNumber2 withQuantity: 6.
	unCarrito add: isbnNumber withQuantity: 3.
	
	listaDeItems := unCarrito listItemsWithQuantities.
	self deny: listaDeItems isEmpty.
	listaDeItems find: { isbnNumber. 5 }.
	listaDeItems find: {isbnNumber2. 6}.! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'products catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'adding' stamp: 'ad 10/29/2017 19:02:11'!
add: anItem withQuantity: aQuantity
	(aQuantity isKindOf: Integer) ifFalse: [ self error: Carrito ErrorCantidadDeItemsDebeSerEntera ].
	
	[catalog find: anItem.
	products
		add: anItem
		withOccurrences: aQuantity ]
		on: Error
		do: [ self error: Carrito ErrorItemDebePertenecerAlCatalogo ].! !


!Carrito methodsFor: 'initialization' stamp: 'lm 10/26/2017 21:04:46'!
withCatalog: aCatalog.

	products := Bag new.
	catalog := aCatalog .! !


!Carrito methodsFor: 'testing' stamp: 'ad 10/29/2017 19:00:22'!
contains: item
	^ products includes: item.! !

!Carrito methodsFor: 'testing' stamp: 'lm 10/26/2017 20:05:05'!
isEmpty
	^products isEmpty.! !


!Carrito methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2017 19:59:52'!
listItemsWithQuantities
	
	|listOfItems|
	
	listOfItems := OrderedCollection new.
	
	(products asSet) do: [ :item | 
		listOfItems add: { item. (products occurrencesOf: item) }. ].
	
	^listOfItems.! !

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
