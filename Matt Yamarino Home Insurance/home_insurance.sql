CREATE TABLE user1 (
user_id int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
user_name varchar(50) NOT NULL UNIQUE,
password varchar(20) NOT NULL UNIQUE,
admin_role char(10) NOT NULL
);

CREATE TABLE homeowner (
user_id int PRIMARY KEY,
first_name varchar(50) NOT NULL,
last_name varchar(50) NOT NULL,
dob date NOT NULL,
retired_status varchar(3) NOT NULL check(retired_status ='yes' or retired_status = 'no'),
ssn int NOT NULL,
email varchar(50) NOT NULL,
CONSTRAINT fk FOREIGN Key (user_id) REFERENCES user1(user_id)
);

CREATE TABLE location (
location_id int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
user_id int NOT NULL,
residence_type varchar(25) NOT NULL,
address_line_1 varchar(50) NOT NULL,
address_line_2 varchar(50),
city varchar(25) NOT NULL,
location_state varchar(25) NOT NULL,
zip_code int NOT NULL,
residence_use char(20) NOT NULL,
CONSTRAINT fk1 FOREIGN Key (user_id) REFERENCES user1(user_id)
);


CREATE TABLE properties(
location_id int PRIMARY KEY,
market_value float NOT NULL,
year_built int NOT NULL,
square_footage int NOT NULL,
dwelling_type varchar(10) NOT NULL,
roof_material varchar(10) NOT NULL,
garage_type varchar(15) NOT NULL,
full_baths int NOT NULL,
half_baths int NOT NULL,
pool varchar(3) NOT NULL check(pool ='yes' or pool = 'no'),
CONSTRAINT fk2 FOREIGN Key (location_id) REFERENCES location(location_id)
);

CREATE TABLE quote(
quote_id int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1)PRIMARY KEY,
location_id int NOT NULL,
monthly_premium float NOT NULL,
dwelling_coverage float NOT NULL,
detatched_structures float NOT NULL,
personal_property float NOT NULL,
add_living_exp float NOT NULL,
medical_expenses float NOT NULL,
deductable float NOT NULL,
CONSTRAINT fk3 FOREIGN Key (location_id) REFERENCES location(location_id)
);

CREATE TABLE policy(
policy_id int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1)PRIMARY KEY,
quote_id int NOT NULL,
user_id int NOT NULL,
effective_date date NOT NULL,
end_date date NOT NULL,
term int NOT NULL,
policy_status varchar(10) DEFAULT 'ACTIVE',
CONSTRAINT fk4 FOREIGN KEY (quote_id) REFERENCES quote(quote_id),
CONSTRAINT fk5  FOREIGN KEY (user_id) REFERENCES user1(user_id)
);

commit;




