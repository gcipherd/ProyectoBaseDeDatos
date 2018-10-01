/* 
*
* Nombre: Customers_campaigns_ecommerce.sql
* Autor: Equipo Fortuna
* Fecha: now(); averdad prros
* Objetivo: Crear la base de datos del proyecto, así como las tablas con sus atributos. 
*
* Tablas más importantes: Customers, Customer_Orders
*
* Tablas:
*
* 	Padres: Ref_Order_Status, Ref_Payment_Methods, Mailshot_Campaigns, Ref_Outcome_Codes, Ref_Address_Types, Ref_Premises_Type, 
*			Ref_Order_Item_Status, Ref_Product_Categories, Ref_Shipping_Methods.
*	
* 	Padres/hijas: Customer_Orders, Customers, Premises, Products.
*	
* 	Hijas: Mailshot_Customers, Customer_Addresses, Order_Items.
*	
*
*/

CREATE DATABASE Customers_Campaigns_eCommerce;

CREATE TABLE Ref_Order_Status(
	order_status_code NUMERIC(,0) NOT NULL,
	order_status_description VARCHAR NULL,
);

CREATE TABLE Ref_Payment_Methods(
);

CREATE TABLE Mailshot_Campaigns(
);

CREATE TABLE Ref_Outcome_Codes(
);

CREATE TABLE Ref_Address_Types(
);

CREATE TABLE Ref_Premises_Type(
);

CREATE TABLE Ref_Order_Item_Status(
);

CREATE TABLE Ref_Product_Categories(
);

CREATE TABLE Ref_Shipping_Methods(
);

CREATE TABLE Customer_Orders(
);

CREATE TABLE Customers(
);

CREATE TABLE Premises(
);

CREATE TABLE Products(
);

CREATE TABLE Mailshot_Customers(
);

CREATE TABLE Customer_Addresses(
);

CREATE TABLE Order_Items(
);

