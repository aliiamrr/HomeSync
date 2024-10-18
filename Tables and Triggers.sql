-- THIS IS THE SQL SCRIPT FOR THE DATABASE TABLE DESIGN OF THE HOME SYNC APPLICATION

CREATE DATABASE HomeSyncDB;
USE HomeSyncDB;

CREATE TABLE Room (
    room_id int PRIMARY KEY IDENTITY,
    floor int,
    type varchar(30),
    status varchar(40)
);

CREATE TABLE Users (
    id int PRIMARY KEY IDENTITY,
    f_name varchar(20),
    l_name varchar(20),
    password varchar(10),
    email varchar(50),
    preference varchar(70),
    room int,
    type varchar(20),
    birth_date datetime,
    age AS (YEAR(CURRENT_TIMESTAMP) - YEAR(birth_date)),
    FOREIGN KEY(room) REFERENCES Room ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Admin (
    admin_id int,
    no_of_guests_allowed int,
    salary DECIMAL(10,2),
    PRIMARY KEY(admin_id),
    FOREIGN KEY(admin_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Guest (
    guest_id int,
    guest_of int,
    address varchar(30),
    arrival_date datetime,
    departure_date datetime,
    residential varchar(50),
    PRIMARY KEY(guest_id),
    FOREIGN KEY(guest_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(guest_of) REFERENCES Admin
);

-- GUEST TRIGGERS

-- ON DELETE GUEST_OF
GO
CREATE TRIGGER delete_guest_of
ON Guest
AFTER DELETE
AS
BEGIN
    DELETE FROM g
    FROM Guest g
    INNER JOIN deleted d ON g.guest_of = d.guest_of
    INNER JOIN Users u ON d.guest_of = u.id;
END;

-- ON UPDATE GUEST_OF
GO
CREATE TRIGGER update_guest_of
ON Guest
AFTER UPDATE
AS
BEGIN
    IF UPDATE(guest_of)
    BEGIN
        UPDATE g
        SET guest_of = i.guest_of
        FROM Guest g
        INNER JOIN inserted i ON g.guest_ID = i.guest_id;
    END;
END;

-- END OF GUEST TRIGGERS

CREATE TABLE Task (
    Task_id int PRIMARY KEY IDENTITY,
    name varchar(50),
    creation_date datetime,
    due_date datetime,
    category varchar(20),
    creator int,
    status varchar(20),
    reminder_date datetime,
    priority int,
    FOREIGN KEY(creator) REFERENCES Admin ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Assigned_to (
    admin_id int,
    task_id int,
    users_id int,
    PRIMARY KEY(users_id, task_id, admin_id),
    FOREIGN KEY(admin_id) REFERENCES Admin,
    FOREIGN KEY(users_id) REFERENCES Users,
    FOREIGN KEY(task_id) REFERENCES Task ON DELETE CASCADE ON UPDATE CASCADE
);

-- ASSIGNED TO TRIGGERS

-- ON DELETE ADMIN AND USER
GO
CREATE TRIGGER delete_assigned_to
ON Assigned_to
AFTER DELETE
AS
BEGIN
    DELETE FROM a
    FROM Assigned_to a
    INNER JOIN deleted d ON a.admin_id = d.admin_id OR a.users_id = d.users_id;
END;

-- ON UPDATE ADMIN AND USER
GO
CREATE TRIGGER update_assigned_to
ON Assigned_to
AFTER UPDATE
AS
BEGIN
    IF UPDATE(admin_id) OR UPDATE(users_id)
    BEGIN
        UPDATE a
        SET admin_id = i.admin_id,
            users_id = i.users_id
        FROM Assigned_to a
        INNER JOIN inserted i ON a.admin_id = i.admin_id AND a.task_id = i.task_id;
    END;
END;

-- END OF ASSIGNED TO TRIGGERS

CREATE TABLE Calender (
    event_id int,
    user_assigned_to int,
    name varchar(20),
    description varchar(200),
    location varchar(40),
    reminder_date datetime,
    PRIMARY KEY(user_assigned_to, event_id),
    FOREIGN KEY(user_assigned_to) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Notes (
    id int PRIMARY KEY,
    user_id int,
    content varchar(500),
    title varchar(50),
    creation_date datetime,
    FOREIGN KEY(user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Travel (
    trip_no int PRIMARY KEY,
    ingoing_flight_num int,
    outgoing_flight_num int,
    hotel_name varchar(30),
    destination varchar(40),
    ingoing_flight_date datetime,
    outgoing_flight_date datetime,
    ingoing_flight_airport varchar(100),
    ougoing_flight_airport varchar(100),
    transport varchar(30)
);

CREATE TABLE User_trip (
    trip_no int,
    user_id int,
    in_going_flight_seat_number int,
    out_going_flight_seat_number int,
    hotel_room_no int,
    PRIMARY KEY(user_id, trip_no),
    FOREIGN KEY(user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(trip_no) REFERENCES Travel ON DELETE CASCADE ON UPDATE CASCADE
);

-- USER TRIP TRIGGERS

-- ON DELETE USER_IF
GO
CREATE TRIGGER delete_user_trip
ON User_trip
AFTER DELETE
AS
BEGIN
    DELETE FROM ut
    FROM User_trip ut
    INNER JOIN deleted d ON ut.user_id = d.user_id;
END;

-- UPDATE USER_ID
GO
CREATE TRIGGER update_user_trip
ON User_trip
AFTER UPDATE
AS
BEGIN
    IF UPDATE(user_id)
    BEGIN
        UPDATE ut
        SET user_id = i.user_id
        FROM User_trip ut
        INNER JOIN inserted i ON ut.trip_no = i.trip_no;
    END;
END;

-- END OF USER TRIP TRIGGERS

CREATE TABLE Finance (
    payment_id int PRIMARY KEY IDENTITY,
    user_id int,
    type varchar(30),
    amount int,
    currency varchar(40),
    method varchar(50),
    status varchar(10),
    receipt_no int,
    date datetime,
    deadline datetime,
    penalty int,
    FOREIGN KEY(user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Health (
    activity varchar(30),
    date datetime,
    user_id int,
    hours_slept int,
    food varchar(80),
    PRIMARY KEY(activity, date),
    FOREIGN KEY(user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Communication (
    message_id int PRIMARY KEY IDENTITY,
    sender_id int,
    receiver_id int,
    time_sent time,
    time_received time,
    time_read time,
    content varchar(200),
    title varchar(30),
    FOREIGN KEY(sender_id) REFERENCES Users,
    FOREIGN KEY(receiver_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

-- COMMUNICATION TRIGGERS

-- ON DELETE SENDER ID
GO
CREATE TRIGGER delete_communication
ON Communication
AFTER DELETE
AS
BEGIN
    DELETE FROM c
    FROM Communication c
    INNER JOIN deleted d ON c.sender_id = d.sender_id;
END;

-- ON UPDATE SENDER ID
GO
CREATE TRIGGER update_communication
ON Communication
AFTER UPDATE
AS
BEGIN
    IF UPDATE(sender_id)
    BEGIN
        UPDATE c
        SET sender_id = i.sender_id
        FROM Communication c
        INNER JOIN inserted i ON c.message_id = i.message_id;
    END;
END;

-- END OF COMMUNICATION TRIGGERS

CREATE TABLE Device (
    device_id int PRIMARY KEY IDENTITY,
    room int,
    type varchar(20),
    status varchar(20),
    battery_status int,
    FOREIGN KEY(room) REFERENCES Room ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE RoomSchedule (
    creator_id int,
    action varchar(20),
    room int,
    start_time datetime,
    end_time datetime,
    PRIMARY KEY(creator_id, start_time),
    FOREIGN KEY(creator_id) REFERENCES Users,
    FOREIGN KEY(room) REFERENCES Room ON DELETE CASCADE ON UPDATE CASCADE
);

-- ROOM SCHEDULE TRIGGERS

-- ON DELETE CREATOR ID
GO
CREATE TRIGGER delete_room_schedule
ON RoomSchedule
AFTER DELETE
AS
BEGIN
    DELETE FROM rs
    FROM RoomSchedule rs
    INNER JOIN deleted d ON rs.creator_id = d.creator_id;
END;

-- ON UPDATE CREATOR ID
GO
CREATE TRIGGER update_room_schedule
ON RoomSchedule
AFTER UPDATE
AS
BEGIN
    IF UPDATE(creator_id)
    BEGIN
        UPDATE rs
        SET creator_id = i.creator_id
        FROM RoomSchedule rs
        INNER JOIN inserted i ON rs.start_time = i.start_time;
    END;
END;

-- END OF ROOM SCHEDULE TRIGGERS

CREATE TABLE Log (
    room_id int,
    device_id int,
    user_id int,
    activity varchar(20),
    date datetime,
    duration int,
    PRIMARY KEY(user_id, device_id, room_id, date),
    FOREIGN KEY(user_id) REFERENCES Users,
    FOREIGN KEY(device_id) REFERENCES Device,
    FOREIGN KEY(room_id) REFERENCES Room ON DELETE CASCADE ON UPDATE CASCADE
);

-- LOG TRIGGERS

-- ON DELETE USER ID/DEVICE ID
GO
CREATE TRIGGER delete_log
ON Log
AFTER DELETE
AS
BEGIN
    DELETE FROM l
    FROM Log l
    INNER JOIN deleted d ON l.user_id = d.user_id OR l.device_id = d.device_id OR l.date = d.date;
END;

-- ON UPDATE USER ID/DEVICE ID
GO
CREATE TRIGGER update_log
ON Log
AFTER UPDATE
AS
BEGIN
    IF UPDATE(user_id) OR UPDATE(device_id)
    BEGIN
        UPDATE l
        SET user_id = i.user_id,
            device_id = i.device_id
        FROM Log l
        INNER JOIN inserted i ON l.user_id = i.user_id AND l.device_id = i.device_id AND l.date = i.date;
    END;
END;

-- END OF LOG TRIGGERS

CREATE TABLE Consumption (
    device_id int,
    consumption int,
    date datetime,
    PRIMARY KEY(device_id, date),
    FOREIGN KEY(device_id) REFERENCES Device ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Preferences (
    user_ID int,
    preferences_no int,
    content varchar(30),
    category varchar(30),
    PRIMARY KEY(user_ID, preferences_no),
    FOREIGN KEY(user_ID) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Recommendation (
    recommendation_ID int PRIMARY KEY,
    user_id int,
    preferences_no int,
    content varchar(100),
    category varchar(30),
    FOREIGN KEY(user_id, preferences_no) REFERENCES Preferences(user_id, preferences_no) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Inventory (
    supply_id int PRIMARY KEY,
    quantity int,
    name varchar(30),
    price DECIMAL(10,2),
    manufacturer varchar(30),
    category varchar(20),
    expiry_date datetime
);

CREATE TABLE Camera (
    monitor_ID int PRIMARY KEY,
    camera_ID int,
    room_ID int,
    status varchar(30),
    FOREIGN KEY(room_ID) REFERENCES Room ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(monitor_ID) REFERENCES Users
);

-- CAMERA TRIGGERS

-- DELETE
GO
CREATE TRIGGER delete_camera
ON Camera
AFTER DELETE
AS
BEGIN
    DELETE FROM c
    FROM Camera c
    INNER JOIN deleted d ON c.monitor_ID = d.monitor_ID;
END;

-- UPDATE
GO
CREATE TRIGGER update_camera
ON Camera
AFTER UPDATE
AS
BEGIN
    IF UPDATE(monitor_ID)
    BEGIN
        UPDATE c
        SET monitor_ID = i.monitor_ID
        FROM Camera c
        INNER JOIN inserted i ON c.room_ID = i.room_ID;
    END;
END;

-- END OF CAMERA TRIGGERS
