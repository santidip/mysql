# TRABAJO PRACTICO FINAL
create database tienda_de_ropa;
use tienda_de_ropa;

#CREACION DE TABLAS

create table if not exists horarios(
    IDhorario int not null primary key auto_increment,
    horarios varchar (200)
);

create table if not exists nacionalidad(
     IDnacionalidad int not null primary key auto_increment,
     nacionalidad varchar(100) not null
);

create table if not exists dias_de_trabajo(
	 IDdiasdetrabajo int not null primary key auto_increment,
     dias varchar(100) not null
);

create table if not exists cargos(
      IDcargo int not null primary key auto_increment,
      cargo varchar(100)
);

create table if not exists sueldos(
	   IDsueldos int not null primary key auto_increment,
       sueldos float(10,5) not null,
       tiposueldo varchar(100)
);

create table if not exists marca(
      IDmarca int not null primary key auto_increment,
      marca varchar(100)
);

create table if not exists tipodeprenda(
      IDtipodeprenda int not null primary key auto_increment,
      prendas varchar(100)
);

create table if not exists gastos(
      IDgastos int not null primary key auto_increment,
      gastos varchar(100),
      saldo int default 0
);

create table if not exists  trabajadores(
      IDtrabajador int not null primary key auto_increment,
      nombre varchar(100),
      apellido varchar(100),
      genero enum('masculino','femenino','no binario','S/D'),
      dni int(8) not null,
      mail varchar(200) unique,
      fechanacimiento date not null,
      edad int not null,
      IDhorarios int not null,
      IDdiasdetrabajo int not null,
      IDnacionalidad int not null,
      IDsueldos int not null,
      IDcargos int not null,
      
      foreign KEY (IDhorarios) references horarios(IDhorario),
      FOREIGN KEY (IDdiasdetrabajo) references dias_de_trabajo(IDdiasdetrabajo),
      foreign key (IDnacionalidad) references nacionalidad(IDnacionalidad),
      foreign key (IDsueldos) references sueldos(IDsueldos),
      foreign key (IDcargos) references cargos(IDcargo)
);

create table if not exists compra(
	  IDcompra int not null primary key auto_increment,
      fechacompra datetime not null,
      IDmarca int not null,
      IDtipodeprenda int not null,
      
      foreign key (IDmarca) references marca(IDmarca),
      foreign key (IDtipodeprenda) references tipodeprenda(IDtipodeprenda)
);

create table if not exists clientes(
      IDclientes int not null primary key auto_increment,
      nombre varchar(100) not null,
      apellido varchar(100),
      telefono int unique,
      mail varchar(200) unique,
      direccion varchar(255),
      IDcompra int not null,
      
      foreign key (IDcompra) references compra(IDcompra)
);

create table if not exists stock(
      cantidad int not null default 0,
      fechadeentrada datetime not null,
      precios int not null default 0,
      IDmarca int not null,
      IDtipodeprenda int not null,
      
      foreign key (IDmarca) references marca(IDmarca),
      foreign key (IDtipodeprenda) references tipodeprenda(IDtipodeprenda)
);

create table if not exists factura(
       IDfactura int not null primary key auto_increment,
       fecha datetime not null,
       IDclientes  int not null,
       IDtrabajadores int not null,
       
       foreign key (IDclientes) references clientes (IDclientes),
       foreign key (IDtrabajadores) references trabajadores(IDtrabajador)
);

create table if not exists detalle_factura(
       IDdetallefacura int not null primary key auto_increment,
       IDfactura int not null,
       IDcompra int not null,
       cantidad int not null,
       precio_compra int not null,

       foreign key (IDfactura) references factura(IDfactura),
       foreign key (IDcompra) references compra(IDcompra)
);

create table if not exists historico_clientes_log(
       id int not null primary key auto_increment,
       nombre varchar(100),
       apellido varchar(100),
       IDcliente int not null,
       fecha datetime,
       usuario varchar (100),
       accion varchar(100)
);

#DATOS INGRESADOS EN LAS TABLAS 
select *
from nacionalidad;
insert into nacionalidad (nacionalidad) values ( 'españa');
insert into nacionalidad (nacionalidad) values ( 'argentina');
insert into nacionalidad (nacionalidad) values ( 'uruguay');
insert into nacionalidad (nacionalidad) values ( 'chile');
insert into nacionalidad (nacionalidad) values ( 'paraguay');
insert into nacionalidad (nacionalidad) values ( 'bolivia');
insert into nacionalidad (nacionalidad) values ( 'peru');

select *
from cargos;

insert into cargos (cargo) values ('cajero');
insert into cargos (cargo) values ('encargado');
insert into cargos (cargo) values ('vendedor');
insert into cargos (cargo) values ('repositor');

select *
from marca;

insert into marca (marca) values ('nike');
insert into marca (marca) values ('adidas');
insert into marca (marca) values ('puma');
insert into marca (marca) values ('new balance');
insert into marca (marca) values ('umbro');
insert into marca (marca) values ('rebook');

select *
from dias_de_trabajo;

insert into dias_de_trabajo (dias) values ('lunes');
insert into dias_de_trabajo (dias) values ('martes');
insert into dias_de_trabajo (dias) values ('miercoles');
insert into dias_de_trabajo (dias) values ('jueves');
insert into dias_de_trabajo (dias) values ('viernes');
insert into dias_de_trabajo (dias) values ('sabado');

select *
from gastos;

insert into gastos (gastos,saldo)
 values 
		('luz',500),		 
		('internet',1000),
        ('sueldos',50000),
		('ropa',300000);

select *
from tipodeprenda;

insert into tipodeprenda (prendas) values ('remera');
insert into tipodeprenda (prendas) values ('zapatilla');
insert into tipodeprenda (prendas) values ('pantalones');
insert into tipodeprenda (prendas) values ('campera');
insert into tipodeprenda (prendas) values ('botines');

select *
from horarios;
#tuve que modificar el tipo de dato
alter table horarios
modify horarios varchar(200) ;
#aca lo puse mal
#insert into horarios (horarios) values (8.00-13.00);
#insert into horarios (horarios) values (13.0020.00);
#aca lo modifique 
update horarios
set horarios='07:00hs a 13:00hs '
where  IDhorario=1;

update horarios
set horarios='13:00hs a 20:00hs '
where  IDhorario=2;

select *
from sueldos;
#modifico el tipo de dato
alter table sueldos 
modify sueldos int;
insert into sueldos (sueldos,tiposueldo)
values    
		(20000,'sueldo alto'),
        (5000,'sueldo bajo'),   
		(10000,'sueldo medio');       

select *
from stock;

insert into stock (cantidad,fechadeentrada,precios,IDmarca,IDtipodeprenda)
values
       (10,20230810,15000,1,2),
       (10,20230805120000,10000,2,5),
	   (10,20230805120000,1000,1,1), 
		(20,20230806070000,2000,3,4);

select *
from compra;

insert into compra (fechacompra, IDmarca, IDtipodeprenda)
values
         (20230922170000,1,2),
         (20230925120000,2,5),
         (20230930160000,3,4),
         (20231005080000,1,1);
         
select *
from clientes;         
         
insert into clientes (nombre,apellido,telefono,mail,direccion,IDcompra)
values
        ('santiago','diaz',1135682389,'santiagodiaz@gmail.com','AV.balbin 2456',1),       
		('juan','ramirez',1157820987,'juan11@hotmail.com','matadero 7658',2),
		('maria','martinez',1156789868,'marimartinez@gmail.com','gral.roca 4583',3),
		('sebastian','maldonado',1134875690,'sebastian55@gmail.com','urquiza 4579',4);
        
select *
from trabajadores;        

insert into trabajadores (nombre,apellido,genero,dni,mail,fechanacimiento,edad,IDhorarios,IDdiasdetrabajo,IDnacionalidad,IDsueldos,IDcargos)        
values        
       ('esteban','cabrera','masculino',42098234,'esteban541@gmail.com',20020422,23,2,1,2,2,3 ),
       ('omar','almada','masculino',43457124,'omaralmada@gmail.com',20031013,20,1,2,2,1,2),
       ('joel','rodriguez','masculino',40234100,'rodriguezms@gmail.com',19990617,24,1,3,1,3,1),
       ('agustin','clemente','masculino',45234069,'agustinclemen@gmail.com',20040722,19,1,4,2,3,4);
       
select *
from factura;       
       
insert into factura (fecha,IDclientes,IDtrabajadores)
values
       (20230922170000,1,3),
       (20230925120000,2,2),
       (20230930160000,3,3),
       (20231005080000,4,3);

select *
from detalle_factura;

insert into detalle_factura (IDfactura,IDcompra,cantidad,precio_compra)
values
       (1,1,2,30000),
       (2,2,3,30000),
       (3,3,2,4000),
       (4,4,1,1000);
       
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS = 0;
              
#VIEW       
       
# primera view       
select *
from trabajadores;
create view informacion_trabajadores as
select nombre, apellido,dni,mail,fechanacimiento,edad
from trabajadores;

#select * from informacion_trabajadores;

#segunda view


create view informacion_clientes as 
select nombre,apellido,telefono,mail,direccion
from clientes;

#select * from informacion_clientes;       
       
#tercera view con join       
              
create view clientes_y_compra as 
select concat(c.nombre,' ',c.apellido) as 'clientes',mar.marca, tprenda.prendas as 'prenda', dfactura.cantidad,dfactura.precio_compra as precio      
from clientes as c
inner join compra as com       
    on c.IDcompra=com.IDcompra
inner join marca as mar  
    ON com.IDmarca=mar.IDmarca
inner join tipodeprenda as tprenda   
    on com.IDtipodeprenda=tprenda.IDtipodeprenda
inner join detalle_factura as dfactura
	on c.IDcompra=dfactura.IDcompra;
    
#select * from clientes_y_compra;    
    
# cuarta view con join
create view cliente_trabajador as
select concat(c.nombre,' ',c.apellido) as 'cliente', concat(t.nombre,' ',t.apellido,'-',car.cargo) as 'trabajador' ,f.fecha as 'fecha de atencion'
from clientes as c
inner join factura as f
    on c.IDclientes=f.IDclientes
inner join trabajadores as t
    on f.IDtrabajadores=t.IDtrabajador
inner join cargos as car
	on t.IDcargos=car.IDcargo;
    
 #select * from cliente_trabajador;   
 
#FUNCIONES

#1
delimiter //
create function traer_datos (p_IDsueldos int)
returns varchar(200)
reads sql data
begin
       declare resultado int;
       set resultado=(select sueldos from sueldos where IDsueldos=p_IDsueldos);
       return resultado;
end; //
#select nombre,apellido,traer_datos(IDsueldos) AS sueldo from trabajadores;   

#2
delimiter //
create function cliente_factura (p_cliente int)
returns varchar (200)
reads sql data
begin
       declare resultado varchar(200);
       set resultado= (select concat(nombre,' ',apellido) from clientes where IDclientes=p_cliente);
       return resultado;
end;//
#select fecha, cliente_factura(IDclientes) as 'cliente' from factura;

#STORED PROCEDURES

#1
drop procedure sp_update_gastos ;
delimiter //
create procedure sp_update_gastos (in p_gastos varchar (100), in p_saldo int, in p_id int)
begin
     
      update gastos 
      set gastos=p_gastos,saldo=p_saldo
      where idgastos=p_id;
end; //

#call sp_update_gastos ('luz',5000,1) ;
#select * FROM GASTOS;

#2
drop procedure sp_ordenar_tabla;
delimiter //
create procedure sp_ordenar_tabla (in p_tabla varchar(100), in p_columna varchar(100), in p_ordenamiento enum('asc','desc','') )
begin
    declare ordenar varchar(200);
    declare tipo varchar(10);
    set ordenar = '';

    if p_columna != '' then
        set ordenar = concat('order by ', p_columna);
    end if;

    if p_ordenamiento != '' then
        set tipo = concat(' ', p_ordenamiento);
    end if;

    set @comando = concat('select * from ', p_tabla, ' ', ordenar, tipo);

    prepare ejecutar from @comando;
    execute ejecutar;
    deallocate prepare ejecutar;
end //

#call sp_ordenar_tabla('trabajadores','nombre','desc');

#TRIGGERS

#1
delimiter //
create trigger eliminar_dato_cliente
after delete on clientes
for each row
begin
    insert into historico_clientes_log(nombre,apellido,IDcliente,fecha,usuario,accion)
    values (old.nombre,old.apellido,old.idclientes,now(),user(),'eliminacion' );
end//

#delete from clientes where nombre='santiago';
#select * from historico_clientes_log;

#2
delimiter //
create trigger insertar_dato_cliente
after insert on clientes
for each row
begin
    insert into historico_clientes_log(nombre,apellido,IDcliente,fecha,usuario,accion)
    values (new.nombre,new.apellido,new.idclientes,now(),user(),'insertar' );
end//
#select * from historico_clientes_log;
#insert into clientes (nombre,apellido,telefono,mail,direccion,IDcompra) values ('sss','ssgergs',1123456789,'sbfbsdgagsgs','sgdsgdgsdg',3 );



