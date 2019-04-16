/*
Nombre del equipo: Fortuna
*/

/*
Equipo: 4
Creador: Equipo Fortuna
Fecha de Creación: 23/10/2018
Objeto: customers_campaigns_ecommerce
Tipo de Objeto: DATABASE
Instrucción: DDL
Descripción: Creación de la base de datos
*/


CREATE DATABASE customers_campaigns_ecommerce;

\c customers_campaigns_ecommerce

/*
Equipo: 4
Creador: Equipo Fortuna
Fecha de Creación: 23/10/2018
Objeto: Ref_Order_Status, Ref_Payment_Methods, Mailshot_Campaigns, Ref_Outcome_Codes, Ref_Address_Types, Ref_Premises_Type, Ref_Order_Item_Status, Ref_Product_Categories, Ref_Shipping_Methods, Customer_Orders, Customers, Premises, Products, Mailshot_Customers, Customer_Addresses, Order_Items.
Tipo de Objeto: TABLE
Instrucción: DDL
Descripción: Creación de las tablas de la base de datos.
*/

/*
Tablas más importantes: Customers, Customer_Orders

Tablas:

    Padres: Ref_Order_Status, Ref_Payment_Methods, Mailshot_Campaigns, Ref_Outcome_Codes, Ref_Address_Types, Ref_Premises_Type, Ref_Order_Item_Status, Ref_Product_Categories, Ref_Shipping_Methods.
   
    Padres/hijas: Customers, Customer_Orders, Premises, Products.
   
    Hijas: Mailshot_Customers, Customer_Addresses, Order_Items.
   
*/

-- Tablas padres

CREATE TABLE Ref_Order_Status(

    order_status_code NUMERIC(1,0) NOT NULL,
    order_status_description VARCHAR(30) NULL,

    CONSTRAINT pkRef_Order_Status
    PRIMARY KEY(order_status_code)

);

CREATE TABLE Ref_Payment_Methods(
    payment_method_code NUMERIC(1,0) NOT NULL,
    payment_method_description VARCHAR(25) NULL,

    CONSTRAINT pkRef_Payment_Methods
    PRIMARY KEY(payment_method_code)

);

CREATE TABLE Mailshot_Campaigns(
    mailshot_id NUMERIC(3,0) NOT NULL,
    product_category_code NUMERIC(1,0) NULL,
    mailshot_name VARCHAR(100) NULL,
    mailshot_start_date DATE NULL,
    mailshot_end_date DATE NULL,
    mailshot_target_population VARCHAR(25) NULL,
    mailshot_objectives VARCHAR(50) NULL,
    other_mailshot_details VARCHAR(150) NULL,

    CONSTRAINT pkMailshot_Campaigns
    PRIMARY KEY(mailshot_id)

);

CREATE TABLE Ref_Outcome_Codes(
    outcome_code NUMERIC(1,0) NOT NULL,
    outcome_description VARCHAR(30) NULL,

    CONSTRAINT pkRef_Outcome_Codes
    PRIMARY KEY(outcome_code)

);

CREATE TABLE Ref_Address_Types(
    address_type_code NUMERIC(1,0) NOT NULL,
    addres_type_description VARCHAR(30) NULL,

    CONSTRAINT pkRef_Address_Types
    PRIMARY KEY(address_type_code)

);

CREATE TABLE Ref_Premises_Type(
    premises_type_code NUMERIC(1,0) NOT NULL,
    premises_type_description VARCHAR(75) NULL,

    CONSTRAINT pkRef_Premises_Type
    PRIMARY KEY(premises_type_code)

);

CREATE TABLE Ref_Order_Item_Status(
    order_item_status_code NUMERIC(1,0) NOT NULL,
    order_item_status_description VARCHAR(75) NULL,

    CONSTRAINT pkRef_Order_Item_Status
    PRIMARY KEY(order_item_status_code)

);

CREATE TABLE Ref_Product_Categories(
    product_category_code NUMERIC(1,0) NOT NULL,
    product_category_description VARCHAR(28) NULL,

    CONSTRAINT pkRef_Product_Categories
    PRIMARY KEY(product_category_code)

);

CREATE TABLE Ref_Shipping_Methods(
    shipping_method_code NUMERIC(2,0) NOT NULL,
    shipping_method_description VARCHAR(70) NULL,
   
    CONSTRAINT pkRef_Shipping_Methods
    PRIMARY KEY(shipping_method_code)

);

-- Tablas padre/hija

CREATE TABLE Customers(
    customer_id NUMERIC(3,0) NOT NULL,
    payment_method_code NUMERIC(1,0) NOT NULL,
    customer_name VARCHAR(50) NULL,
    customer_phone  CHAR(10) NULL,
    customer_email VARCHAR(50) NULL,
    customer_address VARCHAR(75) NULL,
    customer_login VARCHAR(25) NULL,
    customer_password VARCHAR(30) NULL,
    other_customer_details VARCHAR(40) NULL,

    CONSTRAINT pkCustomers
    PRIMARY KEY(customer_id),

    CONSTRAINT fkCustomersRef_Payment_Methods
    FOREIGN KEY(payment_method_code)
    REFERENCES Ref_Payment_Methods(payment_method_code)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE Customer_Orders(
    order_id NUMERIC(3,0) NOT NULL,
    customer_id NUMERIC(3,0) NOT NULL,
    order_status_code NUMERIC(1,0) NOT NULL,
    shipping_method_code NUMERIC(2,0) NULL,
    order_placed_datetime DATE NOT NULL,
    order_delivered_datetime DATE NULL,
    order_shipping_charges NUMERIC(6,2) NULL,
    other_order_details VARCHAR(75) NULL,

    CONSTRAINT pkCustomer_Orders
    PRIMARY KEY(order_id),

    CONSTRAINT fkCustomer_OrdersCustomers
    FOREIGN KEY(customer_id)
    REFERENCES Customers(customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT fkCustomer_OrdersRef_Order_Status
    FOREIGN KEY(order_status_code)
    REFERENCES Ref_Order_Status(order_status_code)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

    CONSTRAINT fkCustomer_OrdersRef_Shipping_Methods
    FOREIGN KEY(shipping_method_code)
    REFERENCES Ref_Shipping_Methods(shipping_method_code)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE Premises(
    premise_id NUMERIC(3,0) NOT NULL,
    premises_type_code NUMERIC(1,0) NOT NULL,
    premise_details VARCHAR(75) NULL,

    CONSTRAINT pkPremises
    PRIMARY KEY(premise_id),

    CONSTRAINT fkPremisesRef_Premises_Type
    FOREIGN KEY(premises_type_code)
    REFERENCES Ref_Premises_Type(premises_type_code)
    ON DELETE CASCADE
    ON UPDATE RESTRICT

);

CREATE TABLE Products(
    product_id NUMERIC(2,0) NOT NULL,
    product_category_code NUMERIC(1,0) NOT NULL,
    product_name VARCHAR(100) NULL,
    other_product_details VARCHAR(75) NULL,

    CONSTRAINT pkProducts
    PRIMARY KEY(product_id),

    CONSTRAINT fkProductsRef_Product_Categories
    FOREIGN KEY(product_category_code)
    REFERENCES Ref_Product_Categories(product_category_code)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- Tablas hija

CREATE TABLE Mailshot_Customers(
    mailshot_id NUMERIC(3,0) NOT NULL,
    customer_id NUMERIC(3,0) NOT NULL,
    outcome_code NUMERIC(1,0) NOT NULL,
    mailshot_customer_date DATE NULL,

    CONSTRAINT pkMailshot_Customers
    PRIMARY KEY(mailshot_id, customer_id),

    CONSTRAINT fkMailshot_CustomersMailshot_Campaigns
    FOREIGN KEY(mailshot_id)
    REFERENCES Mailshot_Campaigns(mailshot_id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,

    CONSTRAINT fkMailshot_CustomersCustomers
    FOREIGN KEY(customer_id)
    REFERENCES Customers(customer_id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,

    CONSTRAINT fkMailshot_CustomersRef_Outcome_Codes
    FOREIGN KEY(outcome_code)
    REFERENCES Ref_Outcome_Codes(outcome_code)
    ON DELETE CASCADE
    ON UPDATE RESTRICT
);

CREATE TABLE Customer_Addresses(
    customer_id NUMERIC(3,0) NOT NULL,
    premise_id NUMERIC(3,0) NOT NULL,
    date_address_from DATE NOT NULL,
    address_type_code NUMERIC(1,0) NOT NULL,
    date_address_to DATE NULL,

    CONSTRAINT pkCustomer_Addresses
    PRIMARY KEY(customer_id, premise_id),

    CONSTRAINT fkCustomer_AddressesCustomers
    FOREIGN KEY(customer_id)
    REFERENCES Customers(customer_id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,

    CONSTRAINT fkCustomer_AddressesPremises
    FOREIGN KEY(premise_id)
    REFERENCES Premises(premise_id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,

    CONSTRAINT fkCustomer_AddressesRef_Address_Types
    FOREIGN KEY(address_type_code)
    REFERENCES Ref_Address_Types(address_type_code)
    ON DELETE CASCADE
    ON UPDATE RESTRICT
);

CREATE TABLE Order_Items(
    item_id NUMERIC(3,0) NOT NULL,
    order_item_status_code NUMERIC(1,0) NOT NULL,
    order_id NUMERIC(3,0) NOT NULL,
    product_id NUMERIC(2,0) NOT NULL,
    item_status_code NUMERIC(1,0) NULL,
    item_delivered_datetime DATE NULL,
    item_order_quantity NUMERIC(3,0) NULL,

    CONSTRAINT pkOrder_Items
    PRIMARY KEY(item_id),

    CONSTRAINT fkOrder_ItemsRef_Order_Item_Status
    FOREIGN KEY(order_item_status_code)
    REFERENCES Ref_Order_Item_Status(order_item_status_code)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

    CONSTRAINT fkOrder_ItemsCustomer_Orders
    FOREIGN KEY(order_id)
    REFERENCES Customer_Orders(order_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT fkOrder_ItemsProducts
    FOREIGN KEY(product_id)
    REFERENCES Products(product_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);


/*
Cuestionario al cliente:


Ref_Order_Status

    - ¿Cuántos tipos de código de estado de orden tiene actualmente? 5 tipos.
    - ¿Cuántos caracteres tiene la descripción más larga del estatus del pedido? 30 caracteres.

Ref_Payment_Methods

    - ¿Con cuántos métodos de pago cuenta actualmente? 5 métodos.
    - ¿Cuántos caracteres tiene la descripción más larga de los métodos de pago? 25 caracteres.

Mailshot_Campaigns

    - ¿Con cuántas campañas por correo cuenta actualmente? 120 campañas.
    - ¿Con cuántas categorías de producto cuenta actualmente? 3 categorías.
    - ¿Cuántos caracteres tiene el nombre más largo de sus campañas por correo? 100 caracteres.
    - ¿Cuántos caracteres contiene el nombre del público objetivo más largo de las campañas por correo? 25 caracteres.
    - ¿Cuántos caracteres contiene el nombre del objetivo más largo en las campañas publicitarias? 50 caracteres.
    - ¿Cuántos caracteres tiene la descripción más larga de detalles de campaña? 150 caracteres.

Ref_Outcome_Codes

    - ¿Con cuántos tipos de código de resultados cuenta actualmente? 5 tipos.
    - ¿Cuántos caracteres tiene la descripción más larga de las recepciones? 30 caracteres.

Ref_Address_Types

    - ¿Cuántos tipos de códigos de direcciones tiene actualmente? 3 tipos.
    - ¿Cuántos caracteres tiene la descripción más larga del tipo de    dirección? 30 caracteres.   

Ref_Premises_Type

    - ¿Cuántos tipos de códigos de premisas/locaciones acepta actualmente? 5 tipos.
    - ¿Cuántos caracteres tiene la descripción más larga del tipo de    premisa/locación? 75 caracteres.

Ref_Order_Item_Status

    - ¿Con cuántos tipos de códigos de estado del pedido de los productos cuenta actualmente? 5 tipos.
    - ¿Cuántos caracteres tiene la descripción más larga sobre el estado del pedido de los productos? 75 caracteres.

Ref_Product_Categories

    - ¿Con cuántos tipos de códigos de categoría de productos cuenta actualmente? 3 tipos.
    - ¿Cuántos caracteres tiene la descripción más larga sobre la categoría de los productos? 28 caracteres.

Ref_Shipping_Methods

    - ¿Con cuántos tipos de códigos de envío cuenta actualmente? 10 tipos.
    - ¿Cuál es el máximo de caracteres a utilizar en la descripción sobre los métodos de envío? 70 caracteres.

Customers

    - ¿Cuántos clientes tiene en total actualmente? 450 clientes.
    - ¿Cuántos caracteres tiene el nombre más largo de los clientes? 50 caracteres.
    - ¿Cuántos caracteres tiene el teléfono más largo de los clientes? 10 caracteres.
    - ¿Cuántos caracteres tiene el correo electrónico más largo de los clientes? 50 caracteres.
    - ¿Cuántos caracteres tiene la dirección más larga de los clientes? 75 caracteres.
    - ¿Cuántos caracteres contendrá el nombre de usuario más grande de los clientes? 25 caracteres.
    - ¿Cuántos caracteres contendrá la contraseña más larga de los clientes? 30 caracteres.
    - ¿Cuál es el máximo de caracteres a utilizar en los detalles adicionales de los clientes? 40 caracteres.

Customer_Orders

    - ¿Con cuántas órdenes de compra cuenta actualmente? 980 órdenes.
    - ¿Cuál es el máximo monto que puede haber en los cargos de envío? 2,500 pesos.
    - ¿Cuál es el máximo de caracteres a utilizar en los detalles del tipo de pedido? 75 caracteres.

Premises

    - ¿Con cuántas premisas/locaciones de clientes cuenta actualmente ? 390 premisas.
    - ¿Cuál es el máximo de caracteres a utilizar en los detalles del tipo de residencia? 75 caracteres.

Products

    - ¿Con cuántos productos cuenta actualmente? 60 productos.
    - ¿Cuántos caracteres tiene el nombre más largo de sus productos? 100 caracteres.
    - ¿Cuál es el máximo de caracteres a utilizar en otros detalles sobre el producto? 75 caracteres.

Order_Items

    - ¿Con cuántas órdenes de pedido cuenta actualmente? 850 órdenes.
    - ¿Con cuántos códigos del estado de producto cuenta actualmente? 5 tipos.
    - ¿Cuál es la cantidad máxima para ordenar en cada pedido? 200 productos.

Proyección de la base de datos

    - ¿Cuántos años tiene prospectado seguir el tipo de negocio? 3 años.

*/


/*
Equipo: 4
Creador: Equipo Fortuna
Fecha de Creación: 26/10/2018
Objeto: 
Tipo de Objeto: 
Instrucción: DML
Descripción: Inserciones de valores máximos para calcular el tamaño de la base de datos,
*/

--  Cálculo del tamaño de la base de datos

    --Ref_Order_Status--

    INSERT INTO Ref_Order_Status
    VALUES (9, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(Ref_Order_Status.*))
    FROM Ref_Order_Status;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 9
        Row: 60 bytes
        8,102/60 = 135.03 = 136 UPI
        9/136 = 0.06 = 1 página
        1*8 = 8 kb de PESO TOTAL  
        */


    --Ref_Payment_Methods--

    INSERT INTO Ref_Payment_Methods
    VALUES (9, 'xxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(Ref_Payment_Methods.*))
    FROM Ref_Payment_Methods;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 9
        Row: 55 bytes
        8,102/55 = 147.30 = 148 UPI
        9/148 = 0.06 = 1 página
        1*8 = 8 kb de PESO TOTAL  
        */


    --Mailshot_Campaigns--

    INSERT INTO Mailshot_Campaigns
    VALUES (999, 9, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', now(), now(), 'xxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(Mailshot_Campaigns.*))
    FROM Mailshot_Campaigns;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 999
        Row: 378 bytes
        8,102/378 = 21.43 = 22 UPI
        999/22 = 45.40 = 46 páginas
        46*8 = 368 kb de PESO TOTAL  
        */


    --Ref_Outcome_Codes--

    INSERT INTO Ref_Outcome_Codes
    VALUES (9, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(Ref_Outcome_Codes.*))
    FROM Ref_Outcome_Codes;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 9
        Row: 60 bytes
        8,102/60 = 135.03 = 136 UPI
        9/136 = 0.06 = 1 página
        1*8 = 8 kb de PESO TOTAL  
        */


    --Ref_Address_Types--

    INSERT INTO Ref_Address_Types
    VALUES (9, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(Ref_Address_Types.*))
    FROM Ref_Address_Types;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 9
        Row: 60 bytes
        8,102/60 = 135.03 = 136 UPI
        9/136 = 0.06 = 1 página
        1*8 = 8 kb de PESO TOTAL  
        */


    --Ref_Premises_Type--

    INSERT INTO Ref_Premises_Type
    VALUES (9, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(Ref_Premises_Type.*))
    FROM Ref_Premises_Type;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 9
        Row: 105 bytes
        8,102/105 = 77.16 = 78 UPI
        9/78 = 0.11 = 1 página
        1*8 = 8 kb de PESO TOTAL  
        */


    --Ref_Order_Item_Status--

    INSERT INTO Ref_Order_Item_Status
    VALUES (9, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(Ref_Order_Item_Status.*))
    FROM Ref_Order_Item_Status;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 9
        Row: 105 bytes
        8,102/105 = 77.16 = 78 UPI
        9/78 = 0.11 = 1 página
        1*8 = 8 kb de PESO TOTAL  
        */


    --Ref_Product_Categories--

    INSERT INTO Ref_Product_Categories
    VALUES (9, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(Ref_Product_Categories.*))
    FROM Ref_Product_Categories;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 9
        Row: 58 bytes
        8,102/58 = 139.68 = 140 UPI
        9/140 = 0.06 = 1 página
        1*8 = 8 kb de PESO TOTAL  
        */


    --Ref_Shipping_Methods--

    INSERT INTO Ref_Shipping_Methods
    VALUES (99, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(Ref_Shipping_Methods.*))
    FROM Ref_Shipping_Methods;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 99
        Row: 100 bytes
        8,102/100 = 81.02 = 82 UPI
        99/82 = 1.20 = 2 páginas
        2*8 = 16 kb de PESO TOTAL  
        */


    --Customers--

    INSERT INTO Customers
    VALUES (999, 9, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(Customers.*))
    FROM Customers;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 999
        Row: 321 bytes
        8,102/321 = 25.23 = 26 UPI
        999/26 = 38.42 = 39 páginas
        39*8 = 312 kb de PESO TOTAL  
        */


    --Customer_Orders--

    INSERT INTO Customer_Orders
    VALUES (999, 999, 9, 99, now(), now(), 9999.99, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(Customer_Orders.*))
    FROM Customer_Orders;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 999
        Row: 135 bytes
        8,102/135 = 60.01 = 61 UPI
        999/61 = 16.37 = 17 páginas
        17*8 = 136 kb de PESO TOTAL 
        */


    --Premises--

    INSERT INTO Premises
    VALUES (999, 9, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(Premises.*))
    FROM Premises;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 999
        Row: 110 bytes
        8,102/110 = 73.65 = 74 UPI
        999/74 = 13.5 = 14 páginas
        14*8 = 112 kb de PESO TOTAL  
        */


    --Products--

    INSERT INTO Products
    VALUES (99, 9, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(Products.*))
    FROM Products;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 99
        Row: 211 bytes
        8,102/211 = 38.39 = 39 UPI
        99/39 = 2.53 = 3 páginas
        3*8 = 24 kb de PESO TOTAL  
        */


    --Mailshot_Customers--

    INSERT INTO Mailshot_Customers
    VALUES (999, 999, 9, now());

    SELECT pg_column_size(row(Mailshot_Customers.*))
    FROM Mailshot_Customers;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 998001
        Row: 44 bytes
        8,102/44 = 184.13 = 185 UPI
        998001/185 = 5394.6 = 5395 páginas
        5395*8 = 43160 kb de PESO TOTAL  
        */


    --Customer_Addresses--  14541651531

    INSERT INTO Customer_Addresses
    VALUES (999, 999, now(), 9, now());

    SELECT pg_column_size(row(Customer_Addresses.*))
    FROM Customer_Addresses;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 998001
        Row: 52 bytes
        8,102/52 = 155.80 = 156 UPI
        998001/156 = 6397.44 = 6398 páginas
        6398*8 = 51184 kb de PESO TOTAL  
        */


    --Order_Items--

    INSERT INTO Order_Items
    VALUES (999, 9, 999, 99, 9, now(), 999);

    SELECT pg_column_size(row(Order_Items.*))
    FROM Order_Items;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 999
        Row: 61 bytes
        8,102/61 = 132.81 = 133 UPI
        999/133 = 7.51 = 8 páginas
        8*8 = 64 kb de PESO TOTAL  
        */

    --PESO TOTAL DE LAS TABLAS: 95432 kb


/*
Proyección de la base de datos:

	- Peso total de las tablas: 95,432 kb.
	- Tiempo prospectado: 3 años.
	- Nivel de riesgo: 50%

	- Aumento por año: 47,716 (95,432 * .50)


	Año:	Peso:
	0		95,432
	1		143,418
	2		190,864
	3		238,580

	- Proyección a 3 años: 238,580 kb
*/
;
