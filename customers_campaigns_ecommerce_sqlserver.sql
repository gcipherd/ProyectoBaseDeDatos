/*
Nombre del equipo: Fortuna
*/

/*
Equipo: 4
Creador: Equipo Fortuna
Fecha de Creación: 25/10/2018
Objeto: customers_campaigns_ecommerces_sqlserver
Tipo de Objeto: DATABASE
Instrucción: DDL
Descripción: Creación de la base de datos en SQL Server
*/

USE master;
GO

CREATE DATABASE customers_campaigns_ecommerce;
GO

USE customers_campaigns_ecommerce;


/*
Equipo: 4
Creador: Equipo Fortuna
Fecha de Creación: 25/10/2018
Objeto: Ref_Order_Status, Ref_Payment_Methods, Mailshot_Campaigns, Ref_Outcome_Codes, Ref_Address_Types, Ref_Premises_Type, Ref_Order_Item_Status, Ref_Product_Categories, Ref_Shipping_Methods, Customer_Orders, Customers, Premises, Products, Mailshot_Customers, Customer_Addresses, Order_Items.
Tipo de Objeto: TABLE
Instrucción: DDL
Descripción: Creación de las tablas de la base de datos en SQL Server.
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
    ON DELETE NO ACTION
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
    ON DELETE NO ACTION
    ON UPDATE CASCADE,

    CONSTRAINT fkCustomer_OrdersRef_Shipping_Methods
    FOREIGN KEY(shipping_method_code)
    REFERENCES Ref_Shipping_Methods(shipping_method_code)
    ON DELETE NO ACTION
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
    ON UPDATE NO ACTION

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
    ON DELETE NO ACTION
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

    CONSTRAINT fkMailshot_CustomersCustomers
    FOREIGN KEY(customer_id)
    REFERENCES Customers(customer_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

    CONSTRAINT fkMailshot_CustomersRef_Outcome_Codes
    FOREIGN KEY(outcome_code)
    REFERENCES Ref_Outcome_Codes(outcome_code)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

    CONSTRAINT fkCustomer_AddressesPremises
    FOREIGN KEY(premise_id)
    REFERENCES Premises(premise_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

    CONSTRAINT fkCustomer_AddressesRef_Address_Types
    FOREIGN KEY(address_type_code)
    REFERENCES Ref_Address_Types(address_type_code)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
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
    ON DELETE NO ACTION
    ON UPDATE CASCADE,

    CONSTRAINT fkOrder_ItemsCustomer_Orders
    FOREIGN KEY(order_id)
    REFERENCES Customer_Orders(order_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT fkOrder_ItemsProducts
    FOREIGN KEY(product_id)
    REFERENCES Products(product_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);
