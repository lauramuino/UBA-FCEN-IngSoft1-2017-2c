!classDefinition: #CardTest category: #TusLibros!
TestCase subclass: #CardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CardTest methodsFor: 'testing' stamp: 'ad 10/31/2017 19:09:33'!
test01NoSePuedeCrearUnaTarjetaSiSuIDNoSon16Digitos
	
	self should:
		[ Card withCardID: '123456789012345' withClientName: 'Pepe'  withExpirationMonth: 2 withExpirationYear: 2019.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card ErrorCardIDMustHave16Digits ].
		
	self should:
		[ Card withCardID: '12345678901a2345' withClientName: 'Pepe'  withExpirationMonth: 2 withExpirationYear: 2019.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card ErrorCardIDMustHave16Digits ].! !

!CardTest methodsFor: 'testing' stamp: 'ad 10/31/2017 19:10:50'!
test02NoSePuedeCrearUnaTarjetaConUnNombreVacioDeCliente
	self
		should: [
			Card
				withCardID: '1234567890123454'
				withClientName: ''
				withExpirationMonth: 2
				withExpirationYear: 2019 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card ErrorClientNameCannotBeEmpty ].! !

!CardTest methodsFor: 'testing' stamp: 'ad 10/31/2017 19:11:20'!
test03NoSePuedeCrearUnaTarjetaSiElNombreDelClienteNoSonLetrasConEspacios
	self
		should: [
			Card
				withCardID: '1234567890123454'
				withClientName: ' 1 '
				withExpirationMonth: 2
				withExpirationYear: 2019 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card ErrorClientNameCannotBeEmpty ].! !

!CardTest methodsFor: 'testing' stamp: 'ad 10/31/2017 19:20:19'!
test04NoSePuedeCrearUnaTarjetaSiElMesNoEsNumerico
	self
		should: [
			Card
				withCardID: '1234567890123454'
				withClientName: 'Juanito Nieve'
				withExpirationMonth: 'a'
				withExpirationYear: 2019 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card ErrorNumeroDeMesInvalido ].! !

!CardTest methodsFor: 'testing' stamp: 'ad 10/31/2017 19:20:35'!
test05NoSePuedeCrearUnaTarjetaSiElMesNoEsUnNumeroEntre1y12
	self
		should: [
			Card
				withCardID: '1234567890123454'
				withClientName: 'Juanito Nieve'
				withExpirationMonth: 0
				withExpirationYear: 2019 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card ErrorNumeroDeMesInvalido ].
	self
		should: [
			Card
				withCardID: '1234567890123454'
				withClientName: 'Juanito Nieve'
				withExpirationMonth: 13
				withExpirationYear: 2019 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card ErrorNumeroDeMesInvalido ].! !

!CardTest methodsFor: 'testing' stamp: 'ad 10/31/2017 19:20:49'!
test06NoSePuedeCrearUnaTarjetaSiElAñoEsEl0
	self
		should: [
			Card
				withCardID: '1234567890123454'
				withClientName: 'Juanito Nieve'
				withExpirationMonth: 5
				withExpirationYear: 0 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card ErrorNumeroDeAñoInvalido ].
		! !

!CardTest methodsFor: 'testing' stamp: 'ad 10/31/2017 19:20:08'!
test06NoSePuedeCrearUnaTarjetaSiElAñoNoEsNumerico
	self
		should: [
			Card
				withCardID: '1234567890123454'
				withClientName: 'Juanito Nieve'
				withExpirationMonth: 5
				withExpirationYear: 'h' ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card ErrorNumeroDeAñoInvalido ].
		! !

!CardTest methodsFor: 'testing' stamp: 'ad 10/31/2017 19:23:09'!
test07seDebePoderCrearUnaTarjetaValida

	Card  withCardID: '1234567890123454'
			withClientName: 'Juanito Nieve'
			withExpirationMonth: 5
			withExpirationYear: 2015.
		! !


!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testInstanceFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'testing' stamp: 'ad 11/1/2017 13:45:58'!
test01unCarritoNuevoEstaVacio
	|unCarrito|
	unCarrito := testInstanceFactory emptyCartWithEmptyCatalog.
	
	self assert: unCarrito isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'ad 11/1/2017 13:46:03'!
test02siSeAgregaUnLibroDeLaEditorialAUnCarritoDejaDeSerVacio
	| aCart |
	aCart _  testInstanceFactory cartWithAProduct.

	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'ad 11/1/2017 13:46:11'!
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

!CartTest methodsFor: 'testing' stamp: 'ad 11/1/2017 13:46:17'!
test04siSeAgregaUnLibroAlCarritoDebePertenecerAlCarrito
	| unCarrito anIsbnNumber |
	anIsbnNumber _ 1234.
	unCarrito _ testInstanceFactory cartWithAProduct .

	self assert: (unCarrito contains: anIsbnNumber).! !

!CartTest methodsFor: 'testing' stamp: 'lm 11/5/2017 02:05:26'!
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
		should: [unCarrito 	add: anIsbnNumber withQuantity: 1.5 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart ErrorCantidadDeItemsDebeSerEntera.
			self assert: unCarrito isEmpty ].! !

!CartTest methodsFor: 'testing' stamp: 'ad 11/1/2017 13:46:34'!
test06unLibroQueNoSeAgregoAlCarritoNoPerteneceAlCarrito
	| unCarrito anIsbnNumber |
	anIsbnNumber _ 1234.
	unCarrito _ testInstanceFactory emptyCartWithEmptyCatalog .
	self deny: (unCarrito contains: anIsbnNumber).! !


!CartTest methodsFor: 'setup' stamp: 'ad 11/1/2017 13:46:47'!
setUp

	testInstanceFactory := TestInstanceFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testInstanceFactory debitSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'ad 11/1/2017 13:55:24'!
test01noSePuedeHacerCheckoutDeUnCarritoVacio
	| aCart aCashier aCard salesBook |
	aCart _ testInstanceFactory emptyCartWithEmptyCatalog.
	salesBook _ OrderedCollection new.
	aCard _ testInstanceFactory validCard.
	aCashier _ Cashier
		withCart: aCart
		withCheckoutDate: Date today
		withCard: aCard
		withSalesBook: salesBook
		 withMerchantProcessor: self.
	self
		should: [ aCashier checkout ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorCheckOutDeCarritoVacio.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'ad 11/1/2017 13:55:35'!
test02noSePuedeHacerCheckoutDeUnCarritoConUnaTarjetaVencida
	| aCart aCashier aCard salesBook |
	aCart _ testInstanceFactory cartWithAProduct.
	salesBook _ OrderedCollection new.
	aCard _ testInstanceFactory expiredCard.
	aCashier _ Cashier
		withCart: aCart
		withCheckoutDate: Date today
		withCard: aCard
		withSalesBook: salesBook
		 withMerchantProcessor: self.
	self
		should: [ aCashier checkout ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorTarjetaVencida.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'lm 11/4/2017 17:16:47'!
test03noSePuedeHacerCheckoutDeUnCarritoConUnaTarjetaRobada
	| aCart aCashier salesBook |
	aCart _ testInstanceFactory cartWithAProduct.
	salesBook _ OrderedCollection new.
	aCashier _ Cashier
		withCart: aCart
		withCheckoutDate: Date today
		withCard: testInstanceFactory stolenCard
		withSalesBook: salesBook
		withMerchantProcessor: self.
		
	debitSimulator := [ :anAmount :aCard | self error: Cashier ErrorTarjetaRobada ].	
	self should: [ aCashier checkout ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorTarjetaRobada .
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'lm 11/4/2017 17:51:57'!
test04checkoutConCarritoNoVacioYTarjetaValidaGeneraUnaEntradaEnElLibroDeVentasAsociadoAlCarritoCorrespondiente
	| aCatalog unCarrito aCashier salesBook anIsbnNumber totalAmount |
	aCatalog _ Dictionary new.
	anIsbnNumber _ 1235.
	aCatalog add: 	(Association key: anIsbnNumber value: 20).
	unCarrito _ Cart withCatalog: aCatalog.
	unCarrito add: anIsbnNumber withQuantity: 2.
	salesBook _ OrderedCollection new.
	aCashier _ Cashier withCart: unCarrito withCheckoutDate: Date today
		withCard: testInstanceFactory validCard withSalesBook: salesBook
		withMerchantProcessor: self.
	debitSimulator := [ :anAmount :aCard |  ].	
	totalAmount _ aCashier checkout.
	self assert: totalAmount = 40.
	self deny: (salesBook find: unCarrito) < 0.! !

!CashierTest methodsFor: 'testing' stamp: 'ad 11/2/2017 19:38:26'!
test05noSePuedeHacerCheckoutDeUnCarritoConUnaTarjetaSinFondos
	| aCart aCashier salesBook |
	aCart _ testInstanceFactory cartWithAProduct.
	salesBook _ OrderedCollection new.
	aCashier _ Cashier
		withCart: aCart
		withCheckoutDate: Date today
		withCard: testInstanceFactory stolenCard
		withSalesBook: salesBook
		withMerchantProcessor: self.
		
	debitSimulator := [ :anAmount :aCard | self error: Cashier ErrorTarjetaSinFondos ].	
	self
		should: [ aCashier checkout ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorTarjetaSinFondos.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'ad 11/2/2017 19:56:18'!
test06seDebitaElMontoCorrectoConLaTarjetaCorrecta
	| aCart aCashier salesBook amount card userCard checkoutAmount |
	aCart _ testInstanceFactory cartWithAProduct.
	salesBook _ OrderedCollection new.
	userCard := testInstanceFactory validCard.
	aCashier _ Cashier
		withCart: aCart
		withCheckoutDate: Date today
		withCard: userCard
		withSalesBook: salesBook
		withMerchantProcessor: self.
		
	debitSimulator := [ :anAmount :aCard | amount := anAmount. card := aCard ].	
	checkoutAmount := aCashier checkout.
	self assert: amount = checkoutAmount.
	self assert: userCard = card.! !


!CashierTest methodsFor: 'setUp' stamp: 'ad 10/31/2017 17:02:52'!
setUp

	testInstanceFactory := TestInstanceFactory new.! !


!CashierTest methodsFor: 'mp simulator' stamp: 'ad 11/2/2017 19:28:43'!
debitAmount: anAmount withCard: aCard

	^debitSimulator value: anAmount value: aCard.
! !


!classDefinition: #RESTest category: #TusLibros!
TestCase subclass: #RESTest
	instanceVariableNames: 'testInstanceFactory usersDataBase cartSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTest methodsFor: 'as yet unclassified' stamp: 'lm 11/4/2017 21:34:21'!
addToCart: anIsbn withQuantity: aQuantity

	^cartSimulator value: anIsbn value: aQuantity.
! !

!RESTest methodsFor: 'as yet unclassified' stamp: 'ad 11/2/2017 20:36:23'!
authenticateUser: userID withPassword: password.

	( ( usersDataBase includesKey: userID ) and: [ (usersDataBase at: userID ) = password ] ) ifFalse: [ ^ self error: RestInterface ErrorInvalidUser ].! !

!RESTest methodsFor: 'as yet unclassified' stamp: 'ad 11/2/2017 20:30:27'!
setUp

	testInstanceFactory := TestInstanceFactory new.
	usersDataBase := Dictionary new.
	usersDataBase add: ( Association key: ( testInstanceFactory validUserID ) value: ( testInstanceFactory validPassword ) ).! !

!RESTest methodsFor: 'as yet unclassified' stamp: 'ad 11/2/2017 20:32:12'!
test01noSePuedeLoguearConUnUsuarioOContraseñaInvalidos

	| restInterface |
	
	restInterface := RestInterface withAuthenticator: self.
	self should: [ restInterface createCartWithUser: ( testInstanceFactory invalidUserID ) withPassword: ( testInstanceFactory invalidPassword ).]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText =  RestInterface ErrorInvalidUser. ].
		 
	self should: [ restInterface createCartWithUser: ( testInstanceFactory validUserID ) withPassword: ( testInstanceFactory invalidPassword ).]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText =  RestInterface ErrorInvalidUser. ].
	
	! !

!RESTest methodsFor: 'as yet unclassified' stamp: 'ad 11/2/2017 20:41:49'!
test02crearUnCarritoConUsuarioYContraseñaValidosGeneraUnCarritoVacio

	| restInterface cartID |
	
	restInterface := RestInterface withAuthenticator: self.
	cartID := restInterface createCartWithUser: ( testInstanceFactory validUserID ) withPassword: ( testInstanceFactory validPassword ).
	
	self assert: ( restInterface listCart: cartID ) isEmpty.! !

!RESTest methodsFor: 'as yet unclassified' stamp: 'lm 11/5/2017 02:27:45'!
test03noSePuedenAgregarProductosConCantidadesNoEnterasONoPositivasAUnCarritoValido
	| restInterface cartID |
	
	restInterface := RestInterface withAuthenticator: self.
	cartID := restInterface createCartWithUser: ( testInstanceFactory validUserID ) withPassword: ( testInstanceFactory validPassword ).
	
	self should: [restInterface addToCart: cartID product: 1234 withQuantity: -1 withCatalog: Bag new.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 	self assert: anError messageText =  RestInterface ErrorInvalidProductQuantity.].

	self should: [restInterface addToCart: cartID product: 1234 withQuantity: 1.4 withCatalog: Bag new.] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError | 	self assert: anError messageText =  RestInterface ErrorInvalidProductQuantity.].! !

!RESTest methodsFor: 'as yet unclassified' stamp: 'lm 11/5/2017 02:26:25'!
test04noSePuedenAgregarProductosQueNoPertenezcanALaEditorial
	| restInterface cartID|
	
	restInterface := RestInterface withAuthenticator: self.
	cartID := restInterface createCartWithUser: ( testInstanceFactory validUserID ) withPassword: ( testInstanceFactory validPassword ).

	self should: [restInterface addToCart: cartID product: 1234 withQuantity: 1 withCatalog: Bag new.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 	self assert: anError messageText =  RestInterface ErrorInvalidProductIsbn.].
! !

!RESTest methodsFor: 'as yet unclassified' stamp: 'lm 11/5/2017 02:28:33'!
test05agregarProductosDeLaEditorialACarritoValidoHACENALGOQUESEYO
	| restInterface cartID aCatalog|
	
	restInterface := RestInterface withAuthenticator: self.
	cartID := restInterface createCartWithUser: ( testInstanceFactory validUserID ) withPassword: ( testInstanceFactory validPassword ).
	
	aCatalog := Bag new.
	aCatalog add: 1234.
	
	restInterface addToCart: cartID product: 1234 withQuantity: 1 withCatalog: aCatalog .
	
	self deny: (restInterface listCart: cartID) isEmpty.
! !


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

!Card class methodsFor: 'as yet unclassified' stamp: 'ad 10/31/2017 18:48:59'!
ErrorCardIDMustHave16Digits! !

!Card class methodsFor: 'as yet unclassified' stamp: 'ad 10/31/2017 19:03:37'!
ErrorClientNameCannotBeEmpty! !

!Card class methodsFor: 'as yet unclassified' stamp: 'ad 10/31/2017 19:05:19'!
ErrorClientNameMustBeLettersWithSpaces! !

!Card class methodsFor: 'as yet unclassified' stamp: 'ad 10/31/2017 19:15:06'!
ErrorNumeroDeAñoInvalido! !

!Card class methodsFor: 'as yet unclassified' stamp: 'ad 10/31/2017 19:13:32'!
ErrorNumeroDeMesInvalido! !

!Card class methodsFor: 'as yet unclassified' stamp: 'ad 10/31/2017 19:18:55'!
withCardID: aCardID withClientName: aClientName withExpirationMonth: aMonth withExpirationYear: aYear

	( ( aCardID size ) == 16 ) ifFalse: [ ^ self error: Card ErrorCardIDMustHave16Digits ].
	( aCardID allSatisfy: [ :char | char isDigit ] ) ifFalse: [ ^ self error: Card ErrorCardIDMustHave16Digits ].
	( aClientName allSatisfy: [ :char | char isSeparator ] ) ifTrue: [ ^ self error: Card ErrorClientNameCannotBeEmpty ].
	( aClientName allSatisfy: [ :char | char isSeparator | char isLetter ]  ) ifFalse: [ ^self error: Card ErrorClientNameMustBeLettersWithSpaces ].
	( ( aMonth isKindOf: Integer ) and: [ (aMonth <= 12) and: [ aMonth >= 1 ] ] ) ifFalse: [ ^self error: Card ErrorNumeroDeMesInvalido ].
	( ( aYear isKindOf: Integer ) and: [ aYear ~= 0 ] ) ifFalse: [ ^self error: Card ErrorNumeroDeAñoInvalido ].

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
	instanceVariableNames: 'checkoutDate cart card salesBook mp'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'ad 11/2/2017 19:37:34'!
checkout

	| totalAmount |
	
	cart isEmpty ifTrue: [ ^ self error: Cashier ErrorCheckOutDeCarritoVacio ].
	(card validateWithDate: checkoutDate) ifTrue: [ self error: Cashier ErrorTarjetaVencida ].

	totalAmount := cart totalAmountOfItems.		
	mp debitAmount: totalAmount withCard: card.
	salesBook add: cart.
	
	^ totalAmount.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ad 11/1/2017 13:54:55'!
withCart: aCart withCheckoutDate: aDate withCard: aCard withSalesBook: aSalesBook  withMerchantProcessor: aMP

	cart:= aCart.
	checkoutDate:= aDate. 
	card := aCard.
	salesBook := aSalesBook.
	mp := aMP.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error message' stamp: 'ad 10/30/2017 18:20:37'!
ErrorCheckOutDeCarritoVacio
	^ 'No se puede hacer checkout de un carrito vacio'.! !

!Cashier class methodsFor: 'error message' stamp: 'ad 11/2/2017 19:32:28'!
ErrorTarjetaRobada
	^ 'No se puede hacer checkout de un carrito con una tarjeta robada'.! !

!Cashier class methodsFor: 'error message' stamp: 'ad 11/2/2017 19:38:04'!
ErrorTarjetaSinFondos
	^ 'La tarjeta no tiene fondos'.! !

!Cashier class methodsFor: 'error message' stamp: 'lm 10/30/2017 18:58:18'!
ErrorTarjetaVencida
	^ 'No se puede hacer checkout de un carrito con una tarjeta vencida'.! !

!Cashier class methodsFor: 'error message' stamp: 'ad 11/1/2017 13:54:40'!
withCart: aCart withCheckoutDate: aDate withCard: aCard withSalesBook: aSalesBook withMerchantProcessor: aMP

	^self new withCart: aCart withCheckoutDate: aDate withCard: aCard withSalesBook: aSalesBook withMerchantProcessor: aMP! !


!classDefinition: #RestInterface category: #TusLibros!
Object subclass: #RestInterface
	instanceVariableNames: 'authenticator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'as yet unclassified' stamp: 'lm 11/5/2017 02:23:56'!
addToCart: aCartID product: anIsbn withQuantity: aQuantity withCatalog: aCatalog
	
	(aQuantity isKindOf: Integer) ifFalse: [^ self error: RestInterface ErrorInvalidProductQuantity].
	
	(aQuantity > 0) ifFalse: [^ self error: RestInterface ErrorInvalidProductQuantity].
	
	(aCatalog includes: anIsbn) ifFalse: [^ self error: RestInterface ErrorInvalidProductIsbn ].
	
	
	! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'lm 11/4/2017 16:35:06'!
createCartWithUser: userID withPassword: password 

	authenticator authenticateUser: userID withPassword: password.
	^1.! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'ad 11/2/2017 20:42:11'!
listCart: aRestInterface 
	
	^ Dictionary new.! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'ad 11/2/2017 20:21:09'!
withAuthenticator: anAuthenticator

	authenticator := anAuthenticator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'as yet unclassified' stamp: 'lm 11/4/2017 19:46:43'!
ErrorInvalidProductIsbn

	^'Los productos no pertenecen al catálogo'.! !

!RestInterface class methodsFor: 'as yet unclassified' stamp: 'lm 11/4/2017 16:32:51'!
ErrorInvalidProductQuantity

	^'Las cantidades del producto deben ser enteras y positivas'.! !

!RestInterface class methodsFor: 'as yet unclassified' stamp: 'ad 11/2/2017 20:33:16'!
ErrorInvalidUser

	^'Usuario o contraseña inexistentes'.! !

!RestInterface class methodsFor: 'as yet unclassified' stamp: 'ad 11/2/2017 20:20:45'!
withAuthenticator: anAuthenticator
	
	^ self new withAuthenticator: anAuthenticator.! !


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


!TestInstanceFactory methodsFor: 'cardInstances' stamp: 'ad 10/31/2017 19:24:00'!
expiredCard
	^ Card
		withCardID: '1234567890123454'
		withClientName: 'TABARE'
		withExpirationMonth: 2
		withExpirationYear: Date today year yearNumber - 1.! !

!TestInstanceFactory methodsFor: 'cardInstances' stamp: 'ad 11/2/2017 20:31:10'!
invalidPassword

	^'123456'.! !

!TestInstanceFactory methodsFor: 'cardInstances' stamp: 'ad 11/2/2017 20:31:02'!
invalidUserID

	^'juancito'.! !

!TestInstanceFactory methodsFor: 'cardInstances' stamp: 'ad 11/1/2017 14:09:24'!
stolenCard
	^ Card
		withCardID: '1234567890123456'
		withClientName: 'TABARE'
		withExpirationMonth: 2
		withExpirationYear: Date today year yearNumber + 1.! !

!TestInstanceFactory methodsFor: 'cardInstances' stamp: 'ad 10/31/2017 19:23:46'!
validCard
	^ Card
		withCardID: '1234567890123454'
		withClientName: 'TABARE'
		withExpirationMonth: 5
		withExpirationYear: Date today year yearNumber + 1.! !

!TestInstanceFactory methodsFor: 'cardInstances' stamp: 'ad 11/2/2017 20:26:15'!
validPassword

	^'1234'.! !

!TestInstanceFactory methodsFor: 'cardInstances' stamp: 'ad 11/2/2017 20:26:07'!
validUserID

	^'pepe'.! !
