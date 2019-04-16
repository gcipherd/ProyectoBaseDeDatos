/******************************
 * Nombre del equipo: Fortuna *
 ******************************/

/*
Rediseño de la Base de Datos - Cambios propuestos (ordenados de la tabla más padre a las más hija):

    -- Tabla Ref_Outcome_Codes --

    Debido a que solo contenía un atributo además de su llave primaria, se decidió eliminar la tabla debido a que dicho atributo era una descripción que ocupaba un espacio innecesario. Se decidió traspasarlo como un atributo llamado “outcome” de tipo CHAR y longitud 1 en la tabla “Mailshot_Customers”, con tal de mejorar el espacio disponible y simplificar el proceso de indicar un pedido entregado o sin respuesta.

    -- Tabla Ref_Address_Types --

    Debido a que la tabla sólo contenía su llave primaria y un atributo que describía los tipos de direcciones, se pasó la información de dicha descripción a un atributo agregado a la Tabla “Customer_Addresses” llamado “address_type” tipo CHAR y longitud 1, con tal de eliminar la tabla, debido al espacio innecesario que ocupaba,

    -- Tabla Ref_Premises_Type --

    Debido a lo reiterativo y poco optimizable que es manejar el tipo de edificios en una tabla por separado de los mismos y sus detalles, se decidió pasar la información contenida en la descripción de su único atributo, además de su llave primaria, como un atributo agregado a la Tabla “Premises” llamado “premises_type” de tipo CHAR y longitud 1, con tal de tener a esta última tabla más completa y sin utilizar el espacio innecesario de una tabla extra.

    -- Tabla Ref_Payment_Methods --

    La información contenida en la descripción de su único atributo se pasó como un atributo agregado a la Tabla “Customers” llamado “payment_method” de tipo CHAR y longitud 2, debido a que era una Tabla reiterativa que contenía su llave primaria y una descripción del método de pago utilizado por el cliente, más fácilmente manejable dentro de los detalles de los clientes, es decir, la Tabla “Customers” y sin ocupar espacio de manera innecesaria, he allí que surgiera la necesidad de eliminar la tabla.

    -- Tabla Ref_Order_Status --

    Se optó por pasar la información contenida en la descripción de su único atributo, además de su llave primaria, como un atributo más a la Tabla “Customer_Orders” de nombre “order_status” de tipo CHAR y longitud 1, debido a que sólo contenía una llave primaria y la descripción del estatus del pedido, de manera que la información del mismo, sea consultado de una manera más completa en la Tabla “Customer_Orders” y por ello, se eliminó a la tabla.

    -- Tabla Ref_Shipping_Methods --

    Debido a que la tabla contenía dos atributos, además de su llave primaria, el primero indicando el tipo de envío (“shipping_method_description”) y el segundo, su cargo (shipping_charges), se optó por pasar el primero como atributo a la Tabla “Customer_Orders” de nombre “shipping_method”  tipo CHAR y longitud 2,  sin embargo,  la información del segundo ya se incluía en la Tabla “Customer_Orders” con el atributo “order_shipping_charges”, por ende, se eliminó a la tabla. 

    -- Tabla Ref_Order_Item_Status --

    Se eliminó completamente debido que el atributo que contenía almacenaba la misma información (el estatus de la entrega de los productos) que el atributo “item_status_code” en la tabla “Order_Items” ya incluía.

    -- Tabla Ref_Product_Categories --

    Debido a que sólo contenía su llave primaria y un atributo describiendo las categorías de los productos, se optó por trasladar la información contenida en dicho atributo hacia otro denominado “product_category” dentro de la Tabla “Products”, con el fin de mejorar el espacio disponible y poder eliminar esta Tabla. 

    -- Tabla Mailshot_Campaigns --

    Se renombró la tabla a “mailshotCampaign” para cumplir el estándar de nombramiento de tablas, así como de sus atributos, de la siguiente forma:

    mailshot_id -> idMailshot
    product_category_code -> productCategoryCode
    mailshot_name -> mailshotName
    mailshot_start_date -> mailshotStartDate
    mailshot_end_date -> mailshotEndDate
    mailshot_target_population -> mailshotTargetPopulation
    mailshot_objectives -> mailshotObjectives
    other_mailshot_details -> otherMailshotDetails

    -- Tabla Customers --

    Se agregó el atributo ““payment_method” tipo CHAR de longitud 2 conteniendo la descripción de la Tabla eliminada “Ref_Payment_Methods” con tal de indicar el método de pago de los clientes en conjunto al resto de su información, mejorando el espacio disponible.

    Se eliminó la llave foránea “payment_method_code” hacia la Tabla eliminada “Ref_Payment_Methods”

    Se renombró a customer para cumplir con el estándar de nombramiento, así como los siguientes atributos:

    customer_id -> idCustomer
    payment_method -> paymentMethod
    customer_name -> customerName
    customer_phone -> customerPhone
    customer_email -> customerEmail
    customer_address -> customerAddress
    customer_login -> customerLogin
    customer_password -> customerPassword
    other_customer_details -> otherCustomerDetails

    -- Tabla Customer_Orders --

    Se agregó el atributo “order_status” de tipo CHAR y longitud 1 conteniendo la descripción de la Tabla eliminada “Ref_Order_Status”, de manera que el estatus de la entrega del Cliente sea indicada en conjunto con el resto de los detalles de la misma.

    Se agregó el atributo “shipping_method”  tipo CHAR y longitud 2 conteniendo la descripción de la Tabla eliminada “Ref_Shipping_Methods”, de manera que el tipo de envío se muestre junto al resto de los detalles del pedido del cliente.

    Se eliminó la llave foránea “order_status_code”  hacia la Tabla eliminada “Ref_Order_Status”.

    Se eliminó la llave foránea “shipping_method_code” hacia la Tabla eliminada “Ref_Shipping_Methods”.


    Se renombró la tabla a customerOrder para cumplir con el estándar de nombramiento, así como los siguientes atributos:

    order_id -> idOrder
    customer_id -> idCustomer
    order_status -> orderStatus
    shipping_method -> shippingMethod
    order_placed_datetime -> orderPlacedDatetime
    order_delivered_datetime -> orderDeliveredDatetime
    order_shipping_charges -> orderShippingCharges
    other_order_details -> otherOrderDetails

    -- Tabla Premises --

    Se agregó el atributo “Premises_Type” tipo CHAR de longitud 1 conteniendo la descripción de la Tabla eliminada “Ref_Premises_Type” con tal de indicar el tipo de propiedad de los clientes, sin ocupar innecesario y complementando la información.

    Se eliminó la llave foránea “premises_type_code” hacia la Tabla eliminada “Ref_Premises_Type”.

    Se renombró la tabla a premise para cumplir con el estándar, así como los siguientes atributos:

    premise_id -> idPremise
    premises_type -> premiseType
    premise_details -> premiseDetails

    -- Tabla Products --

    Se agregó un atributo denominado “product_category” tipo CHAR y longitud 1 conteniendo la descripción de la Tabla eliminada “Ref_Product_Categories” con tal de incluir la información concerniente a las categorías de los productos junto al resto de los detalles concernientes a los mismos.

    Se eliminó la llave foránea “product_category_code” hacia la Tabla eliminada “Ref_Product_Categories”

    Se renombró la tabla a product para cumplir con el estándar de nombramiento de tablas, así como los siguientes atributos:

    product_id -> idProduct
    product_category -> productCategory
    product_name -> productName
    other_product_details -> otherProductDetails

    -- Tabla Mailshot_Customers --

    Se agregó el atributo “outcome” tipo CHAR y longitud 1 conteniendo la descripción de la Tabla eliminada “Ref_Outcome_Codes” con tal de mejorar el espacio disponible y complementar la información de la tabla, por ejemplo, se puede utilizar como una bandera que indique si el cliente ha recibido o no la promoción.

    Se eliminó la llave foránea “outcome_code” hacia la Tabla eliminada “Ref_Outcome_Codes”.

    Se renombró la tabla a mailshoxcustomer para cumplir con el estándar de nombramiento de tablas, así como los siguientes atributos:

    mailshot_id -> idMailshot
    customer_id -> idCustomer
    mailshot_customer_date -> mailshotCustomerDate

    -- Tabla Customer_Addresses --

    Se agregó el atributo “address_type” tipo CHAR de longitud 1 conteniendo la descripción de la Tabla eliminada “Ref_Address_Types”, para indicar el tipo de dirección de facturación de los clientes sin la necesidad de ocupar una tabla extra. 

    Se eliminó la llave foránea “address_type_code” hacia la Tabla eliminada “Ref_Address_Types”.

    Se renombró la tabla a “customerxpremise”, dada su transitividad entre customer y premise, para que cumpliese con el estándar del nombramiento de tablas.
    Se cambiaron de nombre los siguientes atributos:

    customer_id -> idCustomer
    premise_id -> idPremise
    date_address_from -> dateAddressFrom
    address_type -> addressType
    date_address_to -> dateAddressTo

    -- Tabla Order_Items --

    La tabla se renombró a “customerOrderxproduct” ya que descubrimos que era una tabla transitiva entre customerOrder y product, se eliminó la llave la primaria anterior (“item_id”) y se instauraron idCustomer y idProduct como las nuevas llaves primarias.
    Se cambiaron de nombre los siguientes atributos:

    order_id -> idOrder
    product_id -> idProduct
    item_status_code -> itemStatusCode
    item_delivered_datetime -> itemDeliveredDatetime
    item_order_quantity -> itemOrderQuantity

*/



/*
Equipo: 4
Creador: Equipo Fortuna
Fecha de Creación: 25/11/2018
Objeto: customers_campaigns_ecommerce
Tipo de Objeto:
Instrucción: DML
Descripción: Eliminación de los registros anteriormente 
            guardados.
*/

DELETE FROM Order_Items 
WHERE item_id = 999;

DELETE FROM Customer_Addresses
WHERE customer_id = 999;

DELETE FROM Mailshot_Customers
WHERE mailshot_id = 999;

DELETE FROM Products 
WHERE product_id = 99;

DELETE FROM Premises 
WHERE premise_id = 999;

DELETE FROM Customer_Orders
WHERE order_id = 999;

DELETE FROM Customers 
WHERE customer_id = 999;

DELETE FROM Mailshot_Campaigns
WHERE mailshot_id = 999;

/*
Equipo: 4
Creador: Equipo Fortuna
Fecha de Creación: 25/11/2018
Objeto: customers_campaigns_ecommerce
Tipo de Objeto: TABLE
Instrucción: DDL
Descripción: Eliminación de los CONSTRAINT que referencian las tablas a eliminar.  
*/

ALTER TABLE Customers
DROP CONSTRAINT fkCustomersRef_Payment_Methods;

ALTER TABLE Customer_Orders
DROP CONSTRAINT fkCustomer_OrdersRef_Order_Status,
DROP CONSTRAINT fkCustomer_OrdersRef_Shipping_Methods;

ALTER TABLE Premises
DROP CONSTRAINT fkPremisesRef_Premises_Type;

ALTER TABLE Products
DROP CONSTRAINT fkProductsRef_Product_Categories;

ALTER TABLE Mailshot_Customers
DROP CONSTRAINT fkMailshot_CustomersRef_Outcome_Codes;

ALTER TABLE Customer_Addresses
DROP CONSTRAINT fkCustomer_AddressesRef_Address_Types;

ALTER TABLE Order_Items
DROP CONSTRAINT fkOrder_ItemsRef_Order_Item_Status;

/*
Equipo: 4
Creador: Equipo Fortuna
Fecha de Creación: 25/11/2018
Objeto: customers_campaigns_ecommerce
Tipo de Objeto: TABLE
Instrucción: DDL
Descripción: Eliminación de las llaves foráneas proveniente de las tablas a eliminar y sustitución por atributos que cumplen
            funciones similares.
*/

ALTER TABLE Customers
DROP COLUMN payment_method_code,
ADD COLUMN payment_method CHAR(2) NULL;

ALTER TABLE Customer_Orders
DROP COLUMN order_status_code,
ADD COLUMN order_status CHAR(1) NULL;

ALTER TABLE Customer_Orders
DROP COLUMN shipping_method_code,
ADD COLUMN shipping_method CHAR(1) NULL;

ALTER TABLE Premises
DROP COLUMN premises_type_code,
ADD COLUMN premises_type CHAR(1) NULL;

ALTER TABLE Products
DROP COLUMN product_category_code,
ADD COLUMN product_category CHAR(1) NULL;

ALTER TABLE Mailshot_Customers
DROP COLUMN outcome_code,
ADD COLUMN outcome CHAR(2) NULL;

ALTER TABLE Customer_Addresses
DROP COLUMN address_type_code,
ADD COLUMN address_type CHAR(1) NULL;

ALTER TABLE Order_Items
DROP COLUMN order_item_status_code,
DROP COLUMN item_id;

/*
Equipo: 4
Creador: Equipo Fortuna
Fecha de Creación: 25/11/2018
Objeto: customers_campaigns_ecommerce
Tipo de Objeto: TABLE
Instrucción: DDL
Descripción: Eliminación de tablas innecesarias.  
*/

DROP TABLE Ref_Outcome_Codes;
DROP TABLE Ref_Address_Types;
DROP TABLE Ref_Premises_Type;
DROP TABLE Ref_Payment_Methods;
DROP TABLE Ref_Order_Status;
DROP TABLE Ref_Shipping_Methods;
DROP TABLE Ref_Order_Item_Status;
DROP TABLE Ref_Product_Categories;

/*
Equipo: 4
Creador: Equipo Fortuna
Fecha de Creación: 25/11/2018
Objeto: customers_campaigns_ecommerce
Tipo de Objeto: TABLE
Instrucción: DDL
Descripción: Renombramiento de tablas.  
*/

ALTER TABLE Mailshot_Campaigns
RENAME TO mailshotCampaign;

ALTER TABLE Customers
RENAME TO customer;

ALTER TABLE Customer_Orders
RENAME TO customerOrder;

ALTER TABLE Premises
RENAME TO premise;

ALTER TABLE Products
RENAME TO product;

ALTER TABLE Mailshot_Customers
RENAME TO mailshotxcustomer;

ALTER TABLE Customer_Addresses
RENAME TO customerxpremise;

ALTER TABLE Order_Items
RENAME TO customerOrderxproduct;

/*
Equipo: 4
Creador: Equipo Fortuna
Fecha de Creación: 25/11/2018
Objeto: customers_campaigns_ecommerce
Tipo de Objeto: TABLE
Instrucción: DDL
Descripción: Renombramiento de atributos.
*/

-- Tabla mailshotCampaign
ALTER TABLE mailshotCampaign
RENAME COLUMN mailshot_id TO idMailshot;

ALTER TABLE mailshotCampaign
RENAME COLUMN product_category_code TO productCategoryCode;

ALTER TABLE mailshotCampaign
RENAME COLUMN mailshot_name TO mailshotName;

ALTER TABLE mailshotCampaign
RENAME COLUMN mailshot_start_date TO mailshotStartDate;

ALTER TABLE mailshotCampaign
RENAME COLUMN mailshot_end_date TO mailshotEndDate;

ALTER TABLE mailshotCampaign
RENAME COLUMN mailshot_target_population TO mailshotTargetPopulation;

ALTER TABLE mailshotCampaign
RENAME COLUMN mailshot_objectives TO mailshotObjectives;

ALTER TABLE mailshotCampaign
RENAME COLUMN other_mailshot_details TO otherMailshotDetails;

-- Tabla customer

ALTER TABLE customer
RENAME COLUMN customer_id TO idCustomer;

ALTER TABLE customer
RENAME COLUMN payment_method TO paymentMethod;

ALTER TABLE customer
RENAME COLUMN customer_name TO customerName;

ALTER TABLE customer
RENAME COLUMN customer_phone TO customerPhone;

ALTER TABLE customer
RENAME COLUMN customer_email TO customerEmail;

ALTER TABLE customer
RENAME COLUMN customer_address TO customerAddress;

ALTER TABLE customer
RENAME COLUMN customer_login TO customerLogin;

ALTER TABLE customer
RENAME COLUMN customer_password TO customerPassword;

ALTER TABLE customer
RENAME COLUMN other_customer_details TO otherCustomerDetails;

-- Tabla customerOrder

ALTER TABLE customerOrder
RENAME COLUMN order_id TO idOrder;

ALTER TABLE customerOrder
RENAME COLUMN customer_id TO idCustomer;

ALTER TABLE customerOrder
RENAME COLUMN order_status TO orderStatus;

ALTER TABLE customerOrder
RENAME COLUMN shipping_method TO shippingMethod;

ALTER TABLE customerOrder
RENAME COLUMN order_placed_datetime TO orderPlacedDatetime;

ALTER TABLE customerOrder
RENAME COLUMN order_delivered_datetime TO orderDeliveredDatetime;

ALTER TABLE customerOrder
RENAME COLUMN order_shipping_charges TO orderShippingCharges;

ALTER TABLE customerOrder
RENAME COLUMN other_order_details TO otherOrderDetails;

-- Tabla premise

ALTER TABLE premise
RENAME COLUMN premise_id TO idPremise;

ALTER TABLE premise
RENAME COLUMN premises_type TO premiseType;

ALTER TABLE premise
RENAME COLUMN premise_details TO premiseDetails;

-- Tabla product

ALTER TABLE product
RENAME COLUMN product_id to idProduct;

ALTER TABLE product
RENAME COLUMN product_category to productCategory;

ALTER TABLE product
RENAME COLUMN product_name to productName;

ALTER TABLE product
RENAME COLUMN other_product_details to otherProductDetails;

-- Tabla mailshotxcustomer

ALTER TABLE mailshotxcustomer
RENAME COLUMN mailshot_id TO idMailshot;

ALTER TABLE mailshotxcustomer
RENAME COLUMN customer_id TO idCustomer;

ALTER TABLE mailshotxcustomer
RENAME COLUMN mailshot_customer_date TO mailshotCustomerDate;

-- Tabla customerxpremise

ALTER TABLE customerxpremise
RENAME COLUMN customer_id TO idCustomer;

ALTER TABLE customerxpremise
RENAME COLUMN premise_id TO idPremise;

ALTER TABLE customerxpremise
RENAME COLUMN date_address_from TO dateAddressFrom;

ALTER TABLE customerxpremise
RENAME COLUMN address_type TO addressType;

ALTER TABLE customerxpremise
RENAME COLUMN date_address_to TO dateAddressTo;

-- Tabla customerOrderxproduct

ALTER TABLE customerOrderxproduct
RENAME COLUMN order_id TO idOrder;

ALTER TABLE customerOrderxproduct
RENAME COLUMN product_id TO idProduct;

ALTER TABLE customerOrderxproduct
RENAME COLUMN item_status_code TO itemStatusCode;

ALTER TABLE customerOrderxproduct
RENAME COLUMN item_delivered_datetime TO itemDeliveredDatetime;

ALTER TABLE customerOrderxproduct
RENAME COLUMN item_order_quantity TO itemOrderQuantity;

/*
Equipo: 4
Creador: Equipo Fortuna
Fecha de Creación: 25/11/2018
Objeto: customers_campaigns_ecommerce
Tipo de Objeto: TABLE
Instrucción: DDL
Descripción: Actualización de CONSTRAINT de PK y FK de tablas
            renombradas.
*/

ALTER TABLE mailshotCampaign
DROP CONSTRAINT pkMailshot_Campaigns CASCADE,
ADD CONSTRAINT pkMailshotCampaign
    PRIMARY KEY (idMailshot);

ALTER TABLE customer
DROP CONSTRAINT pkCustomers CASCADE,
ADD CONSTRAINT pkCustomer
    PRIMARY KEY(idCustomer);

ALTER TABLE customerOrder
DROP CONSTRAINT pkCustomer_Orders CASCADE,
ADD CONSTRAINT pkCustomerOrder
    PRIMARY KEY(idOrder),

ADD CONSTRAINT fkcustomerOrderCustomer
    FOREIGN KEY(idCustomer)
    REFERENCES customer(idCustomer)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE premise
DROP CONSTRAINT pkPremises CASCADE,
ADD CONSTRAINT pkPremise
    PRIMARY KEY(idPremise);

ALTER TABLE product
DROP CONSTRAINT pkProducts CASCADE,
ADD CONSTRAINT pkProduct
    PRIMARY KEY(idProduct);

ALTER TABLE mailshotxcustomer
DROP CONSTRAINT pkMailshot_Customers,
ADD CONSTRAINT pkMailshotxcustomer
    PRIMARY KEY(idMailshot, idCustomer),

ADD CONSTRAINT fkMailshotxcustomerMailshotCampaign
    FOREIGN KEY(idMailshot)
    REFERENCES mailshotCampaign(idMailshot)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,

ADD CONSTRAINT fkMailshotxcustomerCustomer
    FOREIGN KEY(idCustomer)
    REFERENCES customer(idCustomer)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT;

ALTER TABLE customerxpremise
DROP CONSTRAINT pkCustomer_Addresses,
ADD CONSTRAINT pkCustomerxpremise
    PRIMARY KEY(idCustomer, idPremise),

ADD CONSTRAINT fkCustomerxpremiseCustomer
    FOREIGN KEY(idCustomer)
    REFERENCES customer(idCustomer)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,

ADD CONSTRAINT fkCustomerxpremisePremise
    FOREIGN KEY(idPremise)
    REFERENCES premise(idPremise)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT;

ALTER TABLE customerOrderxproduct
ADD CONSTRAINT pkcustomerOrderxproduct
    PRIMARY KEY(idOrder, idProduct),

ADD CONSTRAINT fkcustomerOrderxproductCustomerOrder
    FOREIGN KEY(idOrder)
    REFERENCES customerOrder(idOrder)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

ADD CONSTRAINT fkcustomerOrderxproductProduct
    FOREIGN KEY(idProduct)
    REFERENCES product(idProduct)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

/*
Equipo: 4
Creador: Equipo Fortuna
Fecha de Creación: 25/11/2018
Objeto: 
Tipo de Objeto: 
Instrucción: DML
Descripción: Inserciones de valores máximos para calcular el tamaño de la base de datos,
*/

--  Cálculo del tamaño de la base de datos

    --mailshotCampaign--

    INSERT INTO mailshotCampaign
    VALUES (999, 9, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', now(), now(), 'xxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    SELECT pg_column_size(row(mailshotCampaign.*))
    FROM mailshotCampaign;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 999
        Row: 378 bytes
        8,102/378 = 21.43 = 22 UPI
        999/22 = 45.40 = 46 páginas
        46*8 = 368 kb de PESO TOTAL  
        */


    --customer--

    INSERT INTO customer
    VALUES (999, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'xx');

    SELECT pg_column_size(row(customer.*))
    FROM customer;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 999
        Row: 319 bytes
        8,102/319 = 25.39 = 26 UPI
        999/26 = 38.42 = 39 páginas
        39*8 = 312 kb de PESO TOTAL  
        */


    --customerOrder--

    INSERT INTO customerOrder
    VALUES (999, 999, now(), now(), 9999.99, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'x', 'x');

    SELECT pg_column_size(row(customerOrder.*))
    FROM customerOrder;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 999
        Row: 131 bytes
        8,102/131 = 61.84 = 62 UPI
        999/62 = 16.11 = 17 páginas
        17*8 = 136 kb de PESO TOTAL 
        */


    --premise--

    INSERT INTO premise
    VALUES (999, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'x');

    SELECT pg_column_size(row(premise.*))
    FROM premise;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 999
        Row: 107 bytes
        8,102/107 = 75.71 = 76 UPI
        999/76 = 13.14 = 14 páginas
        14*8 = 112 kb de PESO TOTAL  
        */


    --product--

    INSERT INTO product
    VALUES (99, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'x');

    SELECT pg_column_size(row(product.*))
    FROM product;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 99
        Row: 208 bytes
        8,102/208 = 38.95 = 39 UPI
        99/39 = 2.53 = 3 páginas
        3*8 = 24 kb de PESO TOTAL  
        */


    --mailshotxcustomer--

    INSERT INTO mailshotxcustomer
    VALUES (999, 999, now(), 'xx');

    SELECT pg_column_size(row(mailshotxcustomer.*))
    FROM mailshotxcustomer;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 998001
        Row: 43 bytes
        8,102/43 = 188.41 = 189 UPI
        998001/189 = 5280.42 = 5281 páginas
        5281*8 = 42248 kb de PESO TOTAL  
        */


    --customerxpremise--

    INSERT INTO customerxpremise
    VALUES (999, 999, now(), now(), 'x');

    SELECT pg_column_size(row(customerxpremise.*))
    FROM customerxpremise;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 998001
        Row: 46 bytes
        8,102/46 = 176.13 = 177 UPI
        998001/177 = 5638.42 = 5639 páginas
        5639*8 = 45112 kb de PESO TOTAL  
        */


    --customerOrderxproduct--

    INSERT INTO customerOrderxproduct
    VALUES (999, 99, 9, now(), 999);

    SELECT pg_column_size(row(customerOrderxproduct.*))
    FROM customerOrderxproduct;

        /*
        Peso de c/pág: 8kb
        Máx. de página: 8,102 bytes
        Máx. de registros: 98901
        Row: 49 bytes
        8,102/49 = 165.34 = 166 UPI
        98901/166 = 595.78 = 596 páginas
        596*8 = 4768 kb de PESO TOTAL  
        */

    --PESO TOTAL DE LAS TABLAS: 93080 kb

    --El peso total de las tablas en la 1° entrega fue de: 95432 kb

    /*
        ¿Cuánto cambia el peso de una versión con respecto a otra?... 2,352 kb.
            Aparenta ser poco el cambio de una versión a otra porque las actuales reglas de negocio
            limitan la longitud de los atributos; sin embargo, consideramos que es una buena mejora
            en la volumetria de la BD ya que se vería mejor reflejado en un futuro si se llega a
            tener una expansión considerable en el negocio.

    */



/*
Proyección de la base de datos:

    - Peso total de las tablas: 93,080 kb.
    - Tiempo prospectado: 3 años.
    - Nivel de riesgo: 50%

    - Aumento por año: 46,540 (93,080 * .50)


    Año:    Peso:
    0       93,080
    1       139,620
    2       186,160
    3       232,700

    - Proyección a 3 años: 232,700 kb

    **Proyección anterior: 238,580 kb
    **Diferencia de versiones: 5,880 kb

*/
;