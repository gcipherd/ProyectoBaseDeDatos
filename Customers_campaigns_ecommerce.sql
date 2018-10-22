/*
Equipo: Fortuna
Creador: Equipo Fortuna
Fecha de Creación: <Fecha>
Objeto: Customer_Campaigns_eCommerce
Tipo de Objeto: DATABASE
Instrucción: DDL
Descripción: Creación de la base de datos
*/


CREATE DATABASE Customers_Campaigns_eCommerce;

/*
Equipo: Fortuna
Creador: Equipo Fortuna
Fecha de Creación: <Fecha>
Objeto: Ref_Order_Status, Ref_Payment_Methods, Mailshot_Campaigns,Ref_Outcome_Codes, Ref_Address_Types, Ref_Premises_Type,
		Ref_Order_Item_Status, Ref_Product_Categories, Ref_Shipping_Methods, Customer_Orders, Customers, Premises, Products, 
		Mailshot_Customers, Customer_Addresses, Order_Items.
Tipo de Objeto: TABLE
Instrucción: DDL
Descripción: Creación de las tablas de la base de datos.
*/

/*
Tablas más importantes: Customers, Customer_Orders

Tablas:

    Padres: Ref_Order_Status, Ref_Payment_Methods, Mailshot_Campaigns, Ref_Outcome_Codes, Ref_Address_Types, Ref_Premises_Type,
           Ref_Order_Item_Status, Ref_Product_Categories, Ref_Shipping_Methods.
   
    Padres/hijas: Customer_Orders, Customers, Premises, Products.
   
    Hijas: Mailshot_Customers, Customer_Addresses, Order_Items.
   
*/

CREATE TABLE Ref_Order_Status(

    order_status_code NUMERIC(,0) NOT NULL,
    order_status_description VARCHAR NULL,

    CONSTRAINT pkRef_Order_Status
    PRIMARY KEY(order_status_code)

);

CREATE TABLE Ref_Payment_Methods(

    payment_method_code NUMERIC(,0) NOT NULL,
    payment_method_description VARCHAR() NULL,

    CONSTRAINT pkRef_Payment_Methods
    PRIMARY KEY(payment_method_code)

);

CREATE TABLE Mailshot_Campaigns(
	mailshot_id NUMERIC(,0) NOT NULL,
	product_category_code NUMERIC(,0) NULL,
	mailshot_name VARCHAR() NULL,
	mailshot_start_date DATE NULL,
	mailshot_end_date DATE NULL,
	mailshot_target_population VARCHAR() NULL,
	mailshot_objectives VARCHAR() NULL,
	other_mailshot_details VARCHAR() NULL,

	CONSTRAINT pkMailshot_Campaigns
	PRIMARY KEY(mailshot_id)

);

CREATE TABLE Ref_Outcome_Codes(
	outcome_code NUMERIC(,0) NOT NULL,
	outcome_description VARCHAR() NULL,

	CONSTRAINT pkRef_Outcome_Codes
	PRIMARY KEY(outcome_code)

);

CREATE TABLE Ref_Address_Types(
	address_type_code NUMERIC(,0) NOT NULL,
	addres_type_description VARCHAR() NULL,

	CONSTRAINT pkRef_Address_Types
	PRIMARY KEY(address_type_code)

);

CREATE TABLE Ref_Premises_Type(
	premises_type_code NUMERIC(,0) NOT NULL,
	premises_type_description VARCHAR() NULL,

	CONSTRAINT pkRef_Premises_Type
	PRIMARY KEY(premises_type_code)

);

CREATE TABLE Ref_Order_Item_Status(
	order_item_status_code NUMERIC(,0) NOT NULL,
	order_item_status_description VARCHAR() NULL,

	CONSTRAINT pkRef_Order_Item_Status
	PRIMARY KEY(order_status_code)

);

CREATE TABLE Ref_Product_Categories(
	product_category_code NUMERIC(,0) NOT NULL,
	product_category_description VARCHAR() NULL,

	CONSTRAINT pkRef_Product_Categories
	PRIMARY KEY(product_category_code)

);

CREATE TABLE Ref_Shipping_Methods(
	shipping_method_code NUMERIC(,0) NOT NULL,
	shipping_method_description VARCHAR NULL,

	CONSTRAINT pkRef_Shipping_Methods
	PRIMARY KEY(shipping_method_code)

);

CREATE TABLE Customer_Orders(
	order_id NUMERIC(,0) NOT NULL,
	customer_id NUMERIC(,0) NOT NULL,
	order_status_code NUMERIC(,0) NOT NULL,
	shipping_method_code NUMERIC(,0) NULL,
	order_placed_datetime DATE NOT NULL,
	order_delivered_datetime DATE NULL,
	order_shipping_charges NUMERIC(,) NULL,
	other_order_details VARCHAR() NULL,

	CONSTRAINT pkCustomer_Orders
	PRIMARY KEY(order_id)

);

CREATE TABLE Customers(
	customer_id NUMERIC(,0) NOT NULL,
	payment_method_code NUMERIC(,0) NOT NULL,
	customer_name VARCHAR() NULL,
	customer_phone
	customer_email
	customer_address
	customer_login
	customer_password
	other_customer_details

	CONSTRAINT pkCustomers
	PRIMARY KEY(customer_id)

);

CREATE TABLE Premises(
	premise_id NUMERIC(,0) NOT NULL,
	premises_type_code NUMERIC(,0) NOT NULL,
	premise_details VARCHAR() NULL,

	CONSTRAINT pkPremises
	PRIMARY KEY(premise_id)
);

CREATE TABLE Products(
	product_id NUMERIC(,0) NOT NULL,
	product_category_code NUMERIC(,0) NOT NULL,
	product_name VARCHAR() NULL,
	other_product_details VARCHAR() NULL,

	CONSTRAINT pkProducts
	PRIMARY KEY(product_id)

);

CREATE TABLE Mailshot_Customers(
	mailshot_id NUMERIC(,0) NOT NULL,
	customer_id NUMERIC(,0) NOT NULL,
	outcome_code NUMERIC(,0) NOT NULL,
	mailshot_customer_date DATE NULL,

	CONSTRAINT pkMailshot_Customers
	PRIMARY KEY(mailshot_id, customer_id),


);

CREATE TABLE Customer_Addresses(
	customer_id NUMERIC(,0) NOT NULL,
	premise_id NUMERIC(,0) NOT NULL,
	date_address_from DATE NOT NULL,
	address_type_code NUMERIC(,0) NOT NULL,
	date_address_to DATE NULL,

	CONSTRAINT pkCustomer_Addresses
	PRIMARY KEY(customer_id, premise_id) --duda: checar date_address_from 

);

CREATE TABLE Order_Items(
	item_id NUMERIC(,0) NOT NULL,
	order_item_status_code NUMERIC(,0) NOT NULL,
	order_id NUMERIC(,0) NOT NULL,
	product_id NUMERIC(,0) NOT NULL,
	item_status_code NUMERIC(,0) NULL,
	item_delivered_datetime DATE NULL,
	item_order_quantity NUMERIC(,0) NULL,

	CONSTRAINT pkOrder_Items
	PRIMARY KEY(item_id)

);

/*
Cuestionario al cliente:

*/

/*
Cálculo del tamaño de la base de datos:

*/

/*
Proyección de la base de datos:

*/