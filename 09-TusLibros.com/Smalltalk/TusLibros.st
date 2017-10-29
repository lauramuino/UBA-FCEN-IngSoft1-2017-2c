!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2017 18:58:47'!
test01unCarritoNuevoEstaVacio

	|unCarrito|
	unCarrito:= Carrito withCatalog: OrderedCollection new.
	
	self assert: unCarrito isEmpty.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2017 18:59:28'!
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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2017 19:02:00'!
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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2017 19:00:11'!
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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2017 19:01:25'!
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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2017 19:00:11'!
test06unLibroQueNoSeAgregoAlCarritoNoPerteneceAlCarrito
	| aCatalog unCarrito anIsbnNumber |
	aCatalog _ OrderedCollection new.
	anIsbnNumber _ 1235.
	unCarrito _ Carrito withCatalog: aCatalog.
	self deny: (unCarrito contains: anIsbnNumber).! !


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
