/*
 * TODO(Студент): Опишите процесс создания базы данных
 * 1. Создайте все таблицы, согласно предложенной диаграмме.
 * 2. Опишите все необходимые отношения между таблицами.
 * 3. Добавьте в каждую таблицу минимум три записи.
 */
create table UserInfo
(
    ID int generated always as identity(start with 1, increment by 1) not null primary key,
    name varchar(255),
    surname varchar(255)
);

create table Roles
(
    ID int generated always as identity(start with 1, increment by 1) unique not null,
    name varchar(255) not null primary key
);

create table Users
(
    ID int generated always as identity(start with 1, increment by 1) unique,
    email varchar(255) not null primary key,
    password varchar(255) not null,
    info int unique references UserInfo(ID) not null,
    role int references Roles(ID) not null
);

create table Orders
(
    ID int generated always as identity(start with 1, increment by 1) primary key not null,
    userID int references Users(ID) not null,
    created timestamp
);

create table Suppliers
(
    ID int generated always as identity(start with 1, increment by 1) unique not null,
    name varchar(255) primary key not null,
    address varchar(255),
    phone varchar(255) not null,
    representative varchar(255)
);

create table Products
(
    ID int generated always as identity(start with 1, increment by 1) unique not null,
    code varchar(255) primary key not null,
    title varchar(255) not null,
    supplier int references Suppliers(ID) not null,
    initial_price double not null,
    retail_price double not null
);

create table Order2Product
(
    orderID int references Orders(ID) not null,
    product int references Products(ID) not null,
    constraint o2p primary key(orderID, product)
);


insert into UserInfo(name, surname)
values('Boris', 'Orlov'), ('Roman', 'Almazov'), ('Vitalik', 'Buterin');

insert into Roles(name)
values('Admin'), ('Customer'), ('Visitor');

insert into Users(email, password, info, role)
values('borlov@mail.ru', 'bor87', 2, 2), ('almaz07@gmail.com', 'qwerty', 3, 2), ('vitalya@mail.ru', '7Jkbdy65', 4, 1);

insert into Orders(userID, created)
values(1, '2019-05-12 14:55:40'), (2, '2019-05-12 15:01:30'), (1, '2019-05-12 15:05:12');

insert into Suppliers(name, address, phone, representative)
values('The Boeing Company', 'United States, Chicago', '312-544-2000', 'Dennis A. Muilenburg'),
('Baltika Breweries', 'Russia, St.Petersburg', '+7(812)3299101', 'Pastushka Jazek Kshishtof'),
('Patek Philippe SA', 'Switzerland, Geneve', '+41 22 884 20 20', 'Tierry Stern');

insert into products(code, title, supplier, initial_price, retail_price)
values('185425455588', 'Boeing 737', 1, 50000000, 65000000), ('457854364678', 'Baltika 9', 2, 0.5, 1.2), ('879845362098', 'pp5205g', 3, 19500, 51300);

insert into Order2Product(orderID, product)
values(2, 2), (3, 2), (4, 1);

# delete from Orders where ID = 1;
