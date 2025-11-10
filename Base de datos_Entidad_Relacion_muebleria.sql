-- ========================================================================================
-- Creacion y uso de la base de datos: Muebleria
-- ========================================================================================

create database muebleria;
use muebleria;

create table roles(
 id_rol bigint primary key auto_increment,
    nombre_rol varchar(50) unique key not null
);

create table usuarios(
 id_usuario bigint primary key auto_increment,
    id_rol bigint not null,
    nombre varchar(150) not null,
    apellidos varchar(150) not null,
    password_hash varchar(500) not null,
    telefono varchar(100) not null,
    correo varchar(200) unique key,
    activo boolean default true,
    fecha_registro datetime default current_timestamp,
    fecha_actualizacion datetime default current_timestamp,
    foreign key (id_rol) references Roles(id_rol)
);

create table direcciones(
 id_direccion bigint primary key auto_increment,
    id_usuario bigint not null,
    tipo_direccion enum('envio', 'facturacion','envio y facturacion') not null,

    alias varchar(150) not null,
    direccion varchar(300) not null,
    ciudad varchar(150) not null,
    Estado varchar(200) not null,
    municipio varchar(200) not null,
    codigo_postal int not null,
    es_predeterminada boolean default false,
    foreign key (id_usuario) references Usuarios(id_usuario)
);
create table categorias(
 id_categoria bigint primary key auto_increment,
    nombre_categoria varchar(100) unique key,
    id_categoria_padre bigint null,
    activo boolean default true,
    foreign key (id_categoria_padre) references Categorias(id_categoria)
);

create table proveedores(
 id_proveedor bigint primary key auto_increment,
    nombre_empresa varchar(200) not null,
    nombre varchar(200) not null,
    telefono varchar(100) not null,
    correo varchar(200) not null,
    direccion varchar(200) not null,
    acivo boolean default true,
    fecha_registro datetime default current_timestamp,
    fecha_actualizacion datetime default current_timestamp
);

create table productos(
 id_producto bigint primary key auto_increment,
    id_categoria bigint not null,
    id_proveedor bigint not null,
    producto varchar(200) not null,
    sku varchar(200) unique key not null,
    descripcion text,
    precio_actual decimal(10,2) not null,
    stock_disponible int default 0,
    alto decimal not null,
    ancho decimal not null,
    profundidad decimal not null,
    peso decimal not null,
    activo boolean default true,
    fecha_pedido datetime default current_timestamp,
    fecha_actualizacion datetime default current_timestamp,
    foreign key (id_categoria) references Categorias(id_categoria),
    foreign key (id_proveedor) references Proveedores(id_proveedor)
); 
create table pedidos(
 id_pedido bigint primary key auto_increment,
    id_usuario bigint not null,
    id_direccion bigint not null,
    estado_pedido enum('Preparando', 'enviado','en camino','entregado'),
    total decimal(10,2) not null,
    costo_envio decimal not null,
    numero_guia varchar(150) not null,
    fecha_pedido datetime default current_timestamp,
    fecha_actualizacion datetime default current_timestamp,
    foreign key (id_usuario) references Usuarios(id_usuario),
    foreign key (id_direccion) references Direcciones(id_direccion)
);

create table detalles_pedido(
 id_detalle bigint primary key auto_increment,
    id_pedido bigint not null,
    id_producto bigint not null,
    cantidad int not null,
    precio_unitario decimal(10,2) not null,
    subtotal decimal(10,2) not null,
    foreign key (id_pedido) references Pedidos(id_pedido),
    foreign key (id_producto) references Productos(id_producto)
);

create table facturas(
 id_factura bigint primary key auto_increment,
    id_pedido bigint unique key,
    rfc varchar(15) not null,
    razon_social varchar(150) not null,
    subtotal decimal (10,2) not null,
    iva decimal (10,2) not null,
    total decimal (10,2) not null,
    estado_factura enum ('pendiente', 'generada','enviada'),
    fecha_emision datetime default current_timestamp,
	fecha_actualizacion datetime default current_timestamp on update current_timestamp,
    foreign key (id_pedido) references Pedidos(id_pedido)
);


create table reseñas(
 id_reseña bigint primary key auto_increment,
    id_usuario bigint not null,
    id_producto bigint not null,
    id_pedido bigint not null,
    calificacion int not null,
    comentario text,
    reseña_visible boolean default true,
    fecha_reseña datetime default current_timestamp,
    foreign key (id_usuario) references Usuarios(id_usuario),
    foreign key (id_producto) references Productos(id_producto),
    foreign key (id_pedido) references Pedidos(id_pedido)
);

create table imagenes_producto(
 id_imagen bigint primary key auto_increment,
    id_producto bigint not null,
    url_imagen varchar(500) not null,
    foreign key (id_producto) references Productos(id_producto)
);