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

!CartTest methodsFor: 'testing' stamp: 'ad 11/5/2017 14:03:43'!
test05noSePuedenAgregarCantidadesNoValidasDeLibrosAUnCarrito
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
			self assert: unCarrito isEmpty ].
	self
		should: [unCarrito 	add: anIsbnNumber withQuantity: 0 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart ErrorCantidadDeItemsDebeSerPositiva.
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

!CashierTest methodsFor: 'testing' stamp: 'ad 11/5/2017 14:26:49'!
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
		withMerchantProcessor: ( testInstanceFactory defaultMPSimulator ).
	self
		should: [ aCashier checkout ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorCheckOutDeCarritoVacio.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'ad 11/5/2017 14:26:59'!
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
		 withMerchantProcessor: ( testInstanceFactory defaultMPSimulator ).
	self
		should: [ aCashier checkout ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorTarjetaVencida.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'ad 11/5/2017 14:28:48'!
test03noSePuedeHacerCheckoutDeUnCarritoConUnaTarjetaRobada
	| aCart aCashier salesBook |
	aCart _ testInstanceFactory cartWithAProduct.
	salesBook _ OrderedCollection new.
	aCashier _ Cashier
		withCart: aCart
		withCheckoutDate: Date today
		withCard: testInstanceFactory stolenCard
		withSalesBook: salesBook
		withMerchantProcessor: ( testInstanceFactory MPSimulatorWithStolenCard ).
		
	self should: [ aCashier checkout ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorTarjetaRobada .
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'ad 11/5/2017 14:27:23'!
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
		withMerchantProcessor: ( testInstanceFactory defaultMPSimulator ).
		
	totalAmount _ aCashier checkout.
	self assert: totalAmount = 40.
	self deny: (salesBook find: unCarrito) < 0.! !

!CashierTest methodsFor: 'testing' stamp: 'ad 11/5/2017 14:29:52'!
test05noSePuedeHacerCheckoutDeUnCarritoConUnaTarjetaSinFondos
	| aCart aCashier salesBook |
	aCart _ testInstanceFactory cartWithAProduct.
	salesBook _ OrderedCollection new.
	aCashier _ Cashier
		withCart: aCart
		withCheckoutDate: Date today
		withCard: testInstanceFactory stolenCard
		withSalesBook: salesBook
		withMerchantProcessor: testInstanceFactory MPSimulatorWithoutMoneyCard.
	self
		should: [ aCashier checkout ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorTarjetaSinFondos.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'ad 11/5/2017 14:29:35'!
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
		withMerchantProcessor: ( MPSimulator withDebitSimulator: [ :anAmount :aCard | amount := anAmount. card := aCard ] ).
		
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


!classDefinition: #RestInterfaceTest category: #TusLibros!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'testInstanceFactory usersDataBase cartSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 12:27:14'!
TESTEXTRA
	| restInterface cartID aCatalog |
	restInterface _ RestInterface withAuthenticator: self.
	cartID _ restInterface
		createCartWithUser: testInstanceFactory validUserID
		withPassword: testInstanceFactory validPassword.
	aCatalog _ Bag new.
	aCatalog add: 1234.
	restInterface
		addToCart: cartID
		product: 1234
		withQuantity: 1
		withCatalog: aCatalog.
	self deny: (restInterface listCart: cartID) isEmpty.! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ad 11/2/2017 20:36:23'!
authenticateUser: userID withPassword: password.

	( ( usersDataBase includesKey: userID ) and: [ (usersDataBase at: userID ) = password ] ) ifFalse: [ ^ self error: RestInterface ErrorInvalidUser ].! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ad 11/2/2017 20:30:27'!
setUp

	testInstanceFactory := TestInstanceFactory new.
	usersDataBase := Dictionary new.
	usersDataBase add: ( Association key: ( testInstanceFactory validUserID ) value: ( testInstanceFactory validPassword ) ).! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 13:05:23'!
test01noSePuedeLoguearConUnUsuarioOContraseñaInvalidos

	self should: [ RestInterface withUser: ( testInstanceFactory invalidUserID ) withPassword: ( testInstanceFactory invalidPassword ) withCatalog: ( Dictionary new ) withAuthenticator: self ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText =  RestInterface ErrorInvalidUser. ].
		 
	self should: [ RestInterface withUser: ( testInstanceFactory invalidUserID ) withPassword: ( testInstanceFactory invalidPassword ) withCatalog: ( Dictionary new ) withAuthenticator: self ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText =  RestInterface ErrorInvalidUser. ].
	
	! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 13:05:53'!
test02crearUnCarritoConUsuarioYContraseñaValidosGeneraUnCarritoVacio

	| restInterface cartID |
	
	restInterface := RestInterface withUser: ( testInstanceFactory validUserID ) withPassword: ( testInstanceFactory validPassword ) withCatalog: ( Dictionary new ) withAuthenticator: self.
	cartID := restInterface createCart.
	
	self assert: ( restInterface listCart: cartID ) isEmpty.! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 13:15:14'!
test03agregarUnItemAUnCarritoValidoLoAgregaAlCarrito

	| restInterface cartID aBook aCatalog |
	
	aBook := '1234'.
	aCatalog _ Dictionary new.
	aCatalog add:
		(Association
			key: aBook
			value: 20).
			
	restInterface := RestInterface withUser: ( testInstanceFactory validUserID ) withPassword: ( testInstanceFactory validPassword ) withCatalog: aCatalog withAuthenticator: self.
	
	cartID := restInterface createCart.
	restInterface addToCart: cartID product: aBook withQuantity: 1..
	
	self deny: ( restInterface listCart: cartID ) isEmpty.
	self assert: ( ( restInterface listCart: cartID ) includesKey: aBook ).! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:01:46'!
test04noSePuedeAgregarUnLibroDeOtraEditorialAlCarrito

	| restInterface cartID aBook |
	
	aBook := '1234'.
			
	restInterface := RestInterface withUser: ( testInstanceFactory validUserID ) withPassword: ( testInstanceFactory validPassword ) withCatalog: ( Dictionary new ) withAuthenticator: self.
	
	cartID := restInterface createCart.
	
	self should:  
		[ restInterface addToCart: cartID product: aBook withQuantity: 1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart ErrorItemDebePertenecerAlCatalogo.
			self assert: ( restInterface listCart: cartID ) isEmpty. ]
	! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:04:16'!
test05noSePuedeAgregarCantidadesNoValidasDeLibrosAlCarrito

	| restInterface cartID aBook aCatalog |
	
	aBook := '1234'.
	aCatalog _ Dictionary new.
	aCatalog add:
		(Association
			key: aBook
			value: 20).
			
	restInterface := RestInterface withUser: ( testInstanceFactory validUserID ) withPassword: ( testInstanceFactory validPassword ) withCatalog: ( Dictionary new ) withAuthenticator: self.
	
	cartID := restInterface createCart.
	
	self
		should: [ restInterface addToCart: cartID product: aBook withQuantity: 1.5 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart ErrorCantidadDeItemsDebeSerEntera.
			self assert: ( restInterface listCart: cartID ) isEmpty. ].
		
	self
		should: [ restInterface addToCart: cartID product: aBook withQuantity: 0 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart ErrorCantidadDeItemsDebeSerPositiva.
			self assert: ( restInterface listCart: cartID ) isEmpty. ].! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:11:14'!
test06noSePuedenAgregarItemsAUnCarritoQueNoExiste

	| restInterface cartID aBook |
	
	aBook := '1234'.
			
	restInterface := RestInterface withUser: ( testInstanceFactory validUserID ) withPassword: ( testInstanceFactory validPassword ) withCatalog: ( Dictionary new ) withAuthenticator: self.
	
	cartID := restInterface createCart.
	
	self should:  
		[ restInterface addToCart: ( cartID - 1 ) product: aBook withQuantity: 1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface ErrorCarritoInvalido.
			self assert: ( restInterface listCart: cartID ) isEmpty. ]
	! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:33:23'!
test07noSePuedeHacerCheckoutDeUnCarritoVacio

	| restInterface cartID salesBook |
				
	restInterface := RestInterface withUser: ( testInstanceFactory validUserID ) withPassword: ( testInstanceFactory validPassword ) withCatalog: ( Dictionary new ) withAuthenticator: self.
	salesBook := OrderedCollection new.
	cartID := restInterface createCart.
	
	self should:  
		[ restInterface checkoutWithCardID: cartID withCard: ( testInstanceFactory validCard ) withCheckoutDate: ( Date today ) withSalesBook: salesBook  withMerchantProcessor: ( testInstanceFactory defaultMPSimulator ) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorCheckOutDeCarritoVacio.
			self assert: ( restInterface listCart: cartID ) isEmpty. ]
	! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:36:45'!
test08noSePuedeHacerCheckoutDeUnCarritoValidoConTarjetaVencida
	| restInterface cartID salesBook book catalog |
	
	book := '1234'.
	catalog _ Dictionary new.
	catalog add:
		(Association
			key: book
			value: 20).
	restInterface _ RestInterface
		withUser: testInstanceFactory validUserID
		withPassword: testInstanceFactory validPassword
		withCatalog: catalog
		withAuthenticator: self.
		
	salesBook _ OrderedCollection new.
	
	cartID _ restInterface createCart.
	restInterface addToCart: cartID product: book withQuantity: 1.
	self
		should: [
			restInterface
				checkoutWithCardID: cartID
				withCard: testInstanceFactory expiredCard
				withCheckoutDate: Date today
				withSalesBook: salesBook
				withMerchantProcessor: testInstanceFactory defaultMPSimulator ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorTarjetaVencida.
			self assert: salesBook isEmpty].! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:38:24'!
test09noSePuedeHacerCheckoutDeUnCarritoValidoConTarjetaSinFondos
	| restInterface cartID salesBook book catalog |
	
	book := '1234'.
	catalog _ Dictionary new.
	catalog add:
		(Association
			key: book
			value: 20).
	restInterface _ RestInterface
		withUser: testInstanceFactory validUserID
		withPassword: testInstanceFactory validPassword
		withCatalog: catalog
		withAuthenticator: self.
		
	salesBook _ OrderedCollection new.
	
	cartID _ restInterface createCart.
	restInterface addToCart: cartID product: book withQuantity: 1.
	self
		should: [
			restInterface
				checkoutWithCardID: cartID
				withCard: testInstanceFactory validCard 
				withCheckoutDate: Date today
				withSalesBook: salesBook
				withMerchantProcessor: testInstanceFactory MPSimulatorWithoutMoneyCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorTarjetaSinFondos.
			self assert: salesBook isEmpty].! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:38:56'!
test10noSePuedeHacerCheckoutDeUnCarritoValidoConTarjetaRobada
	| restInterface cartID salesBook book catalog |
	
	book := '1234'.
	catalog _ Dictionary new.
	catalog add:
		(Association
			key: book
			value: 20).
	restInterface _ RestInterface
		withUser: testInstanceFactory validUserID
		withPassword: testInstanceFactory validPassword
		withCatalog: catalog
		withAuthenticator: self.
		
	salesBook _ OrderedCollection new.
	
	cartID _ restInterface createCart.
	restInterface addToCart: cartID product: book withQuantity: 1.
	self
		should: [
			restInterface
				checkoutWithCardID: cartID
				withCard: testInstanceFactory stolenCard 
				withCheckoutDate: Date today
				withSalesBook: salesBook
				withMerchantProcessor: testInstanceFactory MPSimulatorWithStolenCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ErrorTarjetaRobada.
			self assert: salesBook isEmpty].! !


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

!Cart methodsFor: 'adding' stamp: 'ad 11/5/2017 14:03:09'!
add: anItem withQuantity: aQuantity
	(aQuantity isKindOf: Integer) ifFalse: [ self error: Cart ErrorCantidadDeItemsDebeSerEntera ].
	(aQuantity <= 0 ) ifTrue: [ self error: Cart ErrorCantidadDeItemsDebeSerPositiva ].
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

!Cart class methodsFor: 'error message' stamp: 'ad 11/5/2017 14:03:02'!
ErrorCantidadDeItemsDebeSerPositiva
	^ 'La cantidad de items a agregar debe ser positiva'.! !

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


!classDefinition: #MPSimulator category: #TusLibros!
Object subclass: #MPSimulator
	instanceVariableNames: 'debitSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPSimulator methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:23:20'!
debitAmount: anAmount withCard: aCard

	^debitSimulator value: anAmount value: aCard.! !

!MPSimulator methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:23:11'!
withDebitSimulator: aDebitSimulator

	debitSimulator := aDebitSimulator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MPSimulator class' category: #TusLibros!
MPSimulator class
	instanceVariableNames: ''!

!MPSimulator class methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:23:00'!
withDebitSimulator: aDebitSimulator

	^ self new withDebitSimulator: aDebitSimulator.! !


!classDefinition: #RestInterface category: #TusLibros!
Object subclass: #RestInterface
	instanceVariableNames: 'authenticator user password catalog cartList historicPurchasedCarts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:14:47'!
addToCart: aCartID product: anIsbn withQuantity: aQuantity

	( cartList includesKey: aCartID ) 
		ifTrue: [ ( cartList at: aCartID ) add: anIsbn withQuantity: aQuantity. ]
		ifFalse: [ self error: RestInterface ErrorCarritoInvalido ].
	! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:32:57'!
checkoutWithCardID: aCardID withCard: aCard withCheckoutDate: aDate withSalesBook: aSalesBook  withMerchantProcessor: aMP
	
	( Cashier withCart: ( cartList at: aCardID ) withCheckoutDate: aDate withCard: aCard withSalesBook: aSalesBook withMerchantProcessor: aMP ) checkout.! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:13:51'!
createCart
	
	|cartID|
	
	cartID := 1.

	cartList add: ( Association key: cartID value: ( Cart withCatalog: catalog ) ).
	
	^cartID.! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 12:43:18'!
createCartWithUser: userID withPassword: password withCatalog: aCatalog

	authenticator authenticateUser: userID withPassword: password.
	^1.! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 13:12:22'!
listCart: cartID 
	
	^ ( cartList at: cartID ) listItemsWithQuantities.! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'ad 11/2/2017 20:21:09'!
withAuthenticator: anAuthenticator

	authenticator := anAuthenticator.! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:43:09'!
withUser: anUser withPassword: aPassword withCatalog: aCatalog withAuthenticator: anAuthenticator

	anAuthenticator authenticateUser: anUser withPassword: aPassword.
	
	cartList := Dictionary new.
	historicPurchasedCarts := OrderedCollection new.
	user := anUser.
	password := aPassword.
	catalog := aCatalog.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 14:09:50'!
ErrorCarritoInvalido

	^'El id del carrito es inválido'.! !

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

!RestInterface class methodsFor: 'as yet unclassified' stamp: 'ad 11/5/2017 12:57:51'!
withUser: anUser withPassword: aPassword withCatalog: aCatalog withAuthenticator: anAuthenticator
	
	^ self new withUser: anUser withPassword: aPassword withCatalog: aCatalog withAuthenticator: anAuthenticator.! !


!classDefinition: #TestInstanceFactory category: #TusLibros!
Object subclass: #TestInstanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestInstanceFactory methodsFor: 'cartInstances' stamp: 'ad 11/5/2017 14:28:37'!
MPSimulatorWithStolenCard

	^MPSimulator withDebitSimulator: [ :anAmount :aCard | self error: Cashier ErrorTarjetaRobada ].! !

!TestInstanceFactory methodsFor: 'cartInstances' stamp: 'ad 11/5/2017 14:29:52'!
MPSimulatorWithoutMoneyCard
	^ MPSimulator withDebitSimulator: [ :anAmount :aCard |
		self error: Cashier ErrorTarjetaSinFondos ].! !

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

!TestInstanceFactory methodsFor: 'cartInstances' stamp: 'ad 11/5/2017 14:26:30'!
defaultMPSimulator
	^ MPSimulator withDebitSimulator: [ :anAmount :aCard |
		nil ].! !

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
