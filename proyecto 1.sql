#creacion de la base de datos
create database Tienda_en_linea;
use Tienda_en_linea;

#creacion de las tablas 
start transaction;
create table if not exists clientes(
      ID_cliente int not null primary key auto_increment,
      nombre varchar(255) not null,
      apellido varchar(255) not null,
      email varchar(255) unique default 'sin email',
      telefono varchar (255) unique,
      dirrecion varchar(255)
);

create table if not exists producto(
     ID_producto int not null primary key auto_increment,
     nombre varchar(255) not null,
     descripcion varchar (255) not null default 'sin descripcion',
     precio decimal(10,2)  not null,
     stock int not null default '0'
);

create table if not exists categorias(
      ID_categoria int not null primary key auto_increment,
      nombre varchar(255) not null 
);

create table if not exists pedidos(
      ID_pedido int not null primary key auto_increment,
      ID_cliente int not null,
      fecha_pedido datetime  not null,
      estado varchar(255) not null,
      foreign key (ID_cliente) references clientes(ID_cliente)
);

create table if not exists detalle_pedido(
      ID_detalle int not null primary key auto_increment,
      ID_pedido int not null,
      ID_producto int not null,
      ID_categoria int ,
      cantidad int not null,
      precio_unitario int not null,
      foreign key (ID_pedido) references pedidos(ID_pedido),
      foreign key (ID_producto) references producto(ID_producto),
      foreign key (ID_categoria) references categorias(ID_categoria)
      );

CREATE TABLE Empleados (
    ID_Empleado INT not null PRIMARY KEY auto_increment,
    Nombre VARCHAR(50) not null,
    Apellido VARCHAR(50) not null,
    Fecha_Ingreso date
);

CREATE TABLE Proveedores (
    ID_Proveedor INT not null PRIMARY KEY auto_increment,
    Nombre VARCHAR(50) not null,
    Contacto VARCHAR(50) not null unique,
    Email VARCHAR(100) unique default 'sin mail'
);

CREATE TABLE Compras (
    ID_Compra INT not null PRIMARY KEY auto_increment,
    ID_Proveedor INT not null,
    Fecha_Compra DATEtime,
    Total DECIMAL(10, 2),
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedores(ID_Proveedor)
);
savepoint punto1;

#incersion de datos(la mayoria de los datos fueron importados a traves de archivos csv)
insert into producto (nombre,descripcion,precio, stock) 
	values      
                ('computadora','computadora gamer',250000,22),
                ('silla gamer','silla comoda para jugar',50000,34),
                ('auricular','sonido excelente',20000,30),
                ('pantalla 4k','alta resolucion',100000,14);
  
  insert into categorias (nombre) values ('pc'),('perifericos'),('sillas');
  
# actualice algunos datos de la tabla detalle_pedido para que quede correcto junto con las demas tablas.  
update detalle_pedido
set precio_unitario=250000
where ID_producto=1;

update detalle_pedido
set precio_unitario=250000
where ID_producto=1;

update detalle_pedido
set precio_unitario=50000
where ID_producto=2;

update detalle_pedido
set precio_unitario=20000
where ID_producto=3;

update detalle_pedido
set precio_unitario=100000
where ID_producto=4;

savepoint punto2;

#creacion de indices

create index index_clientes on clientes (nombre,apellido);
create unique index index_unique_clientes on clientes (email, telefono,dirrecion);

#creacion de usuarios

use mysql;
select * from user;

create user 'santiago'@'localhost' identified by '0606';
grant all on tienda_en_linea.* to 'santiago'@'localhost';

create user 'nahuel'@'localhost';
grant insert,delete,update on tienda_de_ropa.clientes to 'nahuel'@'localhost';

savepoint punto3;






