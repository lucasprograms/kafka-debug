CREATE TABLE customers (
    id serial PRIMARY KEY
    , name text
    , age int
);

INSERT INTO customers (name , age)
    VALUES ('sue' , 25) , ('bill' , 51) , ('fred' , 34);

