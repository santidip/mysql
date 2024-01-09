#CREACION DE BASE DE DATOS Y EL USE
create database examen_tecno_3f;
use examen_tecno_3f;

#CREACION DE TABLAS

create table if not exists categoria(
        id int not null primary key auto_increment,
        nombre varchar (100)
);


create table if not exists producto(
		id  int primary key not null auto_increment,
		categoria_id int not null,
		nombre varchar(100) not null,
        cantidad int not null,
        precio float  not null,
        
        foreign key producto(categoria_id) references categoria(id)
);

#DATOS

insert into categoria (nombre) values ('electronico'); 
insert into categoria (nombre) values ('hogar'); 
insert into categoria (nombre) values ('bazar'); 
insert into categoria (nombre) values ('decoracion'); 



insert into  producto (categoria_id,nombre,cantidad,precio)
values
       (1,'Toshiba',10,700),
       (2,'Cooler',2,100),
       (1,'Teclado Gammer',3,90),
       (2,'Mouse LG',0,200),
       (2,'Monitor Samsung 19"',20,1900.36);

# EJERCICIOS EXAMEN

#1- Muestre nombre y cantidad de los productos que están por acabarse (menos de 5 en cantidad) y ordenar de manera descendente por cantidad.
select nombre, cantidad
from producto
where cantidad<5
order by cantidad desc;

#2- Listar todos los productos que tienen un precio entre $50 y $200
select *
from producto
where precio between 50 and 200;

#3- Muestre los productos con un precio mayor a $100 y a que categoría pertenecen (nombre_producto,nombre_categoria, precio)
select p.nombre as 'nombre_producto', c.nombre as 'nombre_categoria',p.precio
from producto as p 
inner join categoria as c
    on  p.categoria_id=c.id
where p.precio>100;    

#4- Crear una vista que muestre los 5 productos mas caros y su categoría (nombre_producto,nombre_categoria,precio)
create view view_productos as 
select p.nombre as 'nombre_producto', c.nombre as 'nombre_categoria',p.precio
from producto as p
inner join categoria as c
    on p.categoria_id=c.id
order by p.precio desc;

#5- Muestre la cantidad de stock de productos, que han sido ingresados por categoría (nombre_categoria,numero_productos)
SELECT c.nombre as 'Nombre Categoria', SUM(p.cantidad) as 'Cantidad'
 FROM producto as p
RIGHT JOIN categoria as c
 ON p.categoria_id = c.id
GROUP BY c.nombre;

#6- Muestre las categorías en las cuales se han ingresado productos y su cantidad (id, nombre, cantidad)
SELECT c.id as 'id Categoria',c.nombre as 'Nombre Categoria', count(p.cantidad) as 'productos x categoria'
FROM categoria as c
RIGHT JOIN producto as p
ON p.categoria_id = c.id
group by c.nombre;

#7- Muestre las categorías en las cuales aun NO se ha ingresado productos (id, nombre)
SELECT c.id, c.nombre, COUNT(p.cantidad) AS 'cantidad'
 FROM categoria c
LEFT JOIN producto p ON p.categoria_id = c.id
 GROUP BY c.nombre HAVING COUNT(p.cantidad) = 0;
#8- Muestre el porcentaje de productos por categoría (nombre_categoria, porcentaje)
select c.nombre as nombre_categoria , concat(round(((count(p.cantidad)*100)/5)),'%') as 'porcentaje'
from categoria as c
left join producto as p
   on p.categoria_id=c.id
group by c.nombre ;
 
#9- Crear un Stored Procedure que permita ingresar una categoría nueva
 drop procedure  if exists sp_nueva_categoria ;

delimiter //
create procedure sp_nueva_categoria (in p_categoria varchar(100) )
begin
      insert into categoria (nombre) values (p_categoria);
end//; 

 call sp_nueva_categoria('cocina');
 
 select * from categoria;
 
 #10- ingrese un nuevo producto de categoría Oficina, cantidad=10 y precio=$1000
insert into categoria(nombre) values ('oficina');
insert into producto (categoria_id,nombre,cantidad,precio) values (5,'impresora',10,1000);
select * from producto;

 #11- Actualice con cantidad = 30 los productos de categoría Electrónico
 update  producto
 set cantidad=30
 where categoria_id=1; 

#Crear un tabla de logs (log_categoria) en la cual almacene los siguientes datos al momento de eliminar una categoría mediante un TRIGGER:
 #ID de la categoría, nombre de la categoría, USUARIO de quien lo elimino, Fecha y Hora.
 create table if not exists log_categoria(
       id INT NOT NULL primary key auto_increment,
       id_categoria int not null,
       nombre varchar (200) not null,
       usuario varchar(200) not null,
       fecha_hora datetime
 );
 
 
 delimiter //
 create trigger eliminar_categoria
 after delete on categoria
 for each row
 begin
      insert into log_categoria (id_categoria,nombre,usuario,fecha_hora) values (old.id,old.nombre, user(),NOW() );
	
 end //
 
select * from log_categoria;
SELECT * FROM CATEGORIA;
 
 DELETE FROM categoria WHERE id=4;
 
