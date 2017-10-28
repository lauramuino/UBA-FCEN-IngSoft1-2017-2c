!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'lm 10/26/2017 20:15:56'!
test01unCarritoNuevoEstaVacio
	|unCarrito|
	unCarrito:= Carrito withCatalog: OrderedCollection new.
	
	self assert: unCarrito isEmpty.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'lm 10/26/2017 21:05:14'!
test02siSeAgregaUnLibroDeLaEditorialAUnCarritoDejaDeSerVacio
	|aCatalog unCarrito anIsbnNumber|
	
	anIsbnNumber:=1234.
	aCatalog := OrderedCollection new.
	aCatalog add: anIsbnNumber .
	
	unCarrito:= Carrito withCatalog: aCatalog.
	unCarrito addBook: anIsbnNumber withQuantity: 1.
	
	self deny: unCarrito isEmpty.
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'lm 10/26/2017 21:32:47'!
test03intentarAgregarUnLibroDeOtraEditorialAUnCarritoVacioLanzaUnError
	|aCatalog unCarrito anIsbnNumber|
	
	aCatalog:= OrderedCollection new.
	anIsbnNumber:=1235.
	
	unCarrito:= Carrito withCatalog: aCatalog.
	self 
		should: [unCarrito addBook: anIsbnNumber withQuantity: 1]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Carrito ErrorLibroDebePertenecerAEditorial. 
			"CAMBIAR"].
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'lm 10/26/2017 21:05:26'!
test04siSeAgregaUnLibroAlCarritoDebePertenecerAlCarrito
	|aCatalog unCarrito anIsbnNumber|
	
	aCatalog:= OrderedCollection new.
	anIsbnNumber:=1235.
	aCatalog add: anIsbnNumber.
	
	unCarrito:= Carrito withCatalog: aCatalog.
	unCarrito addBook: anIsbnNumber withQuantity: 1.
	
	self assert: (unCarrito containsBook: anIsbnNumber).
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'lm 10/26/2017 21:22:29'!
test05siSeAgreganCantidadesNoEnterasDeLibrosAlCarritoSeLanzaUnError
	|aCatalog unCarrito anIsbnNumber|
	
	anIsbnNumber:=1234.
	aCatalog := OrderedCollection new.
	aCatalog add: anIsbnNumber .
	
	unCarrito:= Carrito withCatalog: aCatalog.
	self should: [unCarrito addBook: anIsbnNumber withQuantity: 1.5]
		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = Carrito ErrorCantidadDeLibrosDebeSerEntera ].
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'lm 10/26/2017 21:23:08'!
test06unLibroQueNoSeAgregoAlCarritoNoPerteneceAlCarrito
	|aCatalog unCarrito anIsbnNumber|
	
	aCatalog:= OrderedCollection new.
	anIsbnNumber:=1235.
	
	unCarrito:= Carrito withCatalog: aCatalog.
	
	self deny: (unCarrito containsBook: anIsbnNumber).! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'products catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'lm 10/26/2017 21:19:28'!
addBook: anIsbnNumber withQuantity: aNumber

	( aNumber isKindOf: Integer ) ifFalse: [ self error: Carrito ErrorCantidadDeLibrosDebeSerEntera ].
	
	[ (catalog find: anIsbnNumber).
		products add: anIsbnNumber withOccurrences: aNumber  ] 
	on:Error
	do:[ self error: Carrito ErrorLibroDebePertenecerAEditorial ]! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'lm 10/26/2017 21:07:42'!
containsBook: anIsbnNumber 
	
	^ products includes: anIsbnNumber.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'lm 10/26/2017 20:05:05'!
isEmpty
	^products isEmpty.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'lm 10/26/2017 21:04:46'!
withCatalog: aCatalog.

	products := Bag new.
	catalog := aCatalog .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: #TusLibros!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'as yet unclassified' stamp: 'lm 10/26/2017 21:16:23'!
ErrorCantidadDeLibrosDebeSerEntera

	^'La cantidad de libros debe ser entera'.! !

!Carrito class methodsFor: 'as yet unclassified' stamp: 'lm 10/26/2017 20:44:41'!
ErrorLibroDebePertenecerAEditorial

	^'El libro debe pertenecer a la editorial'.! !

!Carrito class methodsFor: 'as yet unclassified' stamp: 'lm 10/26/2017 20:21:49'!
withCatalog: aCatalog
	^self new withCatalog: aCatalog.! !
