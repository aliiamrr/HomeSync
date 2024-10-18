/* FROM 1-1 UNTIL 2-13 Mohamed Gad 10001181 */

-- Number: 1-1
-- Description: Register on the website with a unique email along with the needed information. Choose which type of user you will be using @usertype (Admin).
-- Name: UserRegister

GO
CREATE PROC UserRegister
    @usertype VARCHAR(20),
    @email VARCHAR(50),
    @first_name VARCHAR(20),
    @last_name VARCHAR(20),
    @birth_date DATETIME,
    @password VARCHAR(10),
    @user_id INT OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Users WHERE email = @email)
    BEGIN
        INSERT INTO Users(type, f_name, l_name, email, birth_date, password)
        VALUES (@usertype, @first_name, @last_name, @email, @birth_date, @password);
    END
    ELSE
    BEGIN
        SET @user_id = -1;
        PRINT('error');
    END
END;

-- Number: 2-1
-- Name: UserLogin
-- Description: Login using email and password. If the user is not registered, the @user_id value will be (-1).

GO
CREATE PROC UserLogin
    @email VARCHAR(50),
    @password VARCHAR(10),
    @success BIT OUTPUT,
    @user_id INT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE email = @email AND password = @password)
    BEGIN
        SET @success = 1;
        SET @user_id = (SELECT id FROM Users WHERE email = @email);
    END
    ELSE
    BEGIN
        SET @success = 0;
        SET @user_id = -1;
    END
END;

-- Number: 2-2
-- Name: ViewProfile
-- Description: View all details of the user's profile.

GO
CREATE PROC ViewProfile
    @user_id INT
AS
    SELECT * FROM Users WHERE id = @user_id;

-- Number: 2-4
-- Name: ViewMyTask
-- Description: View their task. (You should check if the deadline has passed or not if it passed set the status to done).

GO
CREATE PROC ViewMyTask
    @user_id INT
AS
BEGIN
    UPDATE Task
    SET status = 'done'
    WHERE CURRENT_TIMESTAMP > due_date;
    
    SELECT T.*
    FROM Task T
    INNER JOIN Assigned_to A ON T.Task_id = A.task_id
    WHERE A.users_id = @user_id;
END;

-- Number: 2-5
-- Name: FinishMyTask
-- Description: Finish their task.

GO
CREATE PROC FinishMyTask
    @user_id INT,
    @title VARCHAR(30)
AS
BEGIN
    UPDATE Task
    SET status = 'Done'
    FROM Task t
    INNER JOIN Assigned_to ast ON t.Task_id = ast.task_id
    INNER JOIN Users u ON u.id = ast.users_id
    WHERE u.id = @user_id AND t.name = @title;
END;

-- Number: 2-6
-- Name: ViewTask
-- Description: View task status given the @user_id and the @creator of the task. Recently created reports should be shown first.

GO
CREATE PROC ViewTask
    @user_id INT,
    @creator INT
AS
BEGIN
    SELECT t.*
    FROM Task t
    INNER JOIN Assigned_to ast ON t.Task_id = ast.task_id
    WHERE t.creator = @creator AND ast.users_id = @user_id
    ORDER BY t.due_date DESC;
END;

-- Number: 2-7
-- Name: ViewMyDeviceCharge
-- Description: View device charge.

GO
CREATE PROC ViewMyDeviceCharge
    @device_id INT,
    @charge INT OUTPUT,
    @location INT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Device d WHERE device_id = @device_id)
    BEGIN
        SET @location = (SELECT room FROM Device WHERE device_id = @device_id);
        SET @charge = (SELECT battery_status FROM Device WHERE device_id = @device_id);
    END
    ELSE
    BEGIN
        SET @location = -1;
        SET @charge = -1;
        PRINT('Cannot find the device');
    END
END;

-- Number: 2-8
-- Name: AssignRoom
-- Description: Book a room with other users.

GO
CREATE PROC AssignRoom
    @user_id INT,
    @room_id INT
AS
BEGIN
    IF (EXISTS (SELECT 1 FROM Users WHERE id = @user_id)) AND (EXISTS (SELECT 1 FROM Room WHERE room_id = @room_id))
    BEGIN
        INSERT INTO RoomSchedule (creator_id, room, start_time)
        VALUES (@user_id, @room_id, GETDATE());
    END
    ELSE
    BEGIN
        PRINT('Invalid user ID or room ID');
    END
END;

-- Number: 2-9
-- Name: CreateEvent
-- Description: Create events on the system.

GO
CREATE PROC CreateEvent
    @event_id INT,
    @user_id INT,
    @name VARCHAR(50),
    @description VARCHAR(200),
    @location VARCHAR(40),
    @reminder_date DATETIME,
    @other_user_id INT
AS
BEGIN
    IF EXISTS (SELECT * FROM Users U WHERE U.id = @user_id)
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Calender WHERE event_id = @event_id)
        BEGIN
            INSERT INTO Calender (event_id, user_assigned_to, name, description, location, reminder_date)
            VALUES (@event_id, @user_id, @name, @description, @location, @reminder_date);
            
            INSERT INTO Calender (event_id, user_assigned_to, name, description, location, reminder_date)
            VALUES (@event_id, @other_user_id, @name, @description, @location, @reminder_date);
        END
        ELSE
            RAISERROR('EVENT ALREADY EXISTS', 16, 1);
    END
    ELSE
        RAISERROR('USER DOES NOT EXIST', 16, 1);
END;

-- Number: 2-10
-- Name: AssignUser
-- Description: Assign a user to attend an event.

GO
CREATE PROC AssignUser
    @user_id INT,
    @event_id INT,
    @users_id INT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT * FROM Calender C WHERE C.event_id = @event_id)
    BEGIN
        INSERT INTO Calender (event_id, user_assigned_to)
        VALUES (@event_id, @user_id);
        
        UPDATE Calender
        SET
            name = (SELECT DISTINCT name FROM Calender WHERE event_id = @event_id AND user_assigned_to != @user_id),
            description = (SELECT DISTINCT description FROM Calender WHERE event_id = @event_id AND user_assigned_to != @user_id),
            location = (SELECT DISTINCT location FROM Calender WHERE event_id = @event_id AND user_assigned_to != @user_id),
            reminder_date = (SELECT DISTINCT reminder_date FROM Calender WHERE event_id = @event_id AND user_assigned_to != @user_id)
        WHERE event_id = @event_id AND user_assigned_to = @user_id;

        SET @users_id = @user_id;

        SELECT * FROM Calender C WHERE C.event_id = @event_id;
    END
    ELSE
        RAISERROR('NON EXISTENT EVENT OR USER', 16, 1);
END;

-- Number: 2-11
-- Name: AddReminder
-- Description: Add a reminder to a task.

GO
CREATE PROC AddReminder
    @task_id INT,
    @reminder DATETIME
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Task WHERE task_id = @task_id)
    BEGIN
        UPDATE Task
        SET reminder_date = @reminder
        WHERE task_id = @task_id;
    END
    ELSE
        PRINT('Invalid task ID');
END;

-- Number: 2-12
-- Name: Uninvited
-- Description: Uninvite a specific user to an event.

GO
CREATE PROC Uninvited
    @event_id INT,
    @user_id INT
AS
BEGIN
    IF EXISTS (SELECT * FROM Calender WHERE event_id = @event_id AND user_assigned_to = @user_id)
        DELETE FROM Calender WHERE event_id = @event_id AND user_assigned_to = @user_id;
    ELSE
        RAISERROR('INVALID USER ID OR EVENT ID', 16, 1);
END;

-- Number: 2-13
-- Name: UpdateTaskDeadline
-- Description: Update the deadline of a specific task.

GO
CREATE PROC UpdateTaskDeadline
    @task_id INT,
    @deadline DATETIME
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Task WHERE task_id = @task_id)
    BEGIN
        UPDATE Task
        SET due_date = @deadline
        WHERE Task_id = @task_id;
    END
    ELSE
        PRINT('Invalid task ID');
END;

/*FROM 2-14 UNTIL 3-3 Adam khaled 10001535 */

/* 2-14 */
-- Name: ViewEvent
-- Description: View events given the @user_id and @event_id. If @event_id is empty, view all events belonging to the user, ordered by date.

GO
CREATE PROCEDURE ViewEvent
    @User_id INT,
    @Event_id INT
AS
BEGIN
    IF @Event_id = 0
    BEGIN
        IF EXISTS (SELECT * FROM Calender C WHERE C.user_assigned_to = @User_id)
        BEGIN
            SELECT *
            FROM Calender C
            WHERE C.user_assigned_to = @User_id;
        END
        ELSE
            RAISERROR('INVALID USER ID', 16, 1);
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT * FROM Calender C WHERE C.user_assigned_to = @User_id AND C.event_id = @Event_id)
        BEGIN
            SELECT *
            FROM Calender C
            WHERE C.user_assigned_to = @User_id AND C.event_id = @Event_id;
        END
        ELSE
            RAISERROR('INVALID USER ID OR EVENT ID', 16, 1);
    END
END

/* 2-15 */
-- Name: ViewRecommendation
-- Description: View users that have no recommendations.

GO
CREATE PROCEDURE ViewRecommendation
AS
BEGIN
    SELECT U.f_name, U.l_name
    FROM Users U
    LEFT OUTER JOIN Recommendation R ON U.id = R.user_id
    WHERE R.recommendation_id IS NULL;
END

/* 2-16 */
-- Name: CreateNote
-- Description: Create a new note.

GO
CREATE PROCEDURE CreateNote
    @User_id INT,
    @note_id INT,
    @title VARCHAR(50),
    @Content VARCHAR(500),
    @creation_date DATETIME
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Notes WHERE id = @note_id)
    BEGIN
        INSERT INTO Notes (id, user_id, content, creation_date, title)
        VALUES (@note_id, @User_id, @Content, @creation_date, @title);
    END
    ELSE
        PRINT 'A note with this ID already exists!';
END

/* 2-17 */
-- Name: ReceiveMoney
-- Description: Receive a transaction.

GO
CREATE PROCEDURE ReceiveMoney
    @receiver_id INT,
    @type VARCHAR(30),
    @amount DECIMAL(13, 2),
    @status VARCHAR(10),
    @date DATETIME
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Users WHERE id = @receiver_id)
    BEGIN
        RAISERROR('SENDER ID DOES NOT EXIST', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO Finance (user_id, type, amount, status, date)
        VALUES (@receiver_id, @type, @amount, @status, @date);
    END
END

/* 2-18 */
-- Name: PlanPayment
-- Description: Create a payment on a specific date from one user to the other, each with their separate records.

GO
CREATE PROCEDURE PlanPayment
    @sender_id INT,
    @receiver_id INT,
    @amount DECIMAL(13, 2),
    @status VARCHAR(10),
    @deadline DATETIME
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Users WHERE id = @sender_id)
    BEGIN
        RAISERROR('SENDER ID DOES NOT EXIST', 16, 1);
    END
    ELSE IF NOT EXISTS (SELECT 1 FROM Users WHERE id = @receiver_id)
    BEGIN
        RAISERROR('RECEIVER ID DOES NOT EXIST', 16, 1);
    END
    ELSE
    BEGIN
        -- Insert outgoing transaction for sender
        INSERT INTO Finance (user_id, type, amount, status, deadline)
        VALUES (@sender_id, 'outgoing', @amount, @status, @deadline);

        -- Insert incoming transaction for receiver
        INSERT INTO Finance (user_id, type, amount, status, deadline)
        VALUES (@receiver_id, 'incoming', @amount, @status, @deadline);
    END
END

/* 2-19 */
-- Name: SendMessage
-- Description: Send a message to a user.

GO
CREATE PROCEDURE SendMessage
    @sender_id INT,
    @receiver_id INT,
    @title VARCHAR(30),
    @content VARCHAR(200),
    @timesent TIME,
    @timereceived TIME
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Users WHERE id = @sender_id)
    BEGIN
        RAISERROR('SENDER ID DOES NOT EXIST', 16, 1);
    END
    ELSE IF NOT EXISTS (SELECT 1 FROM Users WHERE id = @receiver_id)
    BEGIN
        RAISERROR('RECEIVER ID DOES NOT EXIST', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO Communication (sender_id, receiver_id, content, time_sent, time_received, title)
        VALUES (@sender_id, @receiver_id, @content, @timesent, @timereceived, @title);
    END
END

/* 2-20 */
-- Name: NoteTitle
-- Description: Change note title for all notes user created.

GO
CREATE PROCEDURE NoteTitle
    @user_id INT,
    @note_title VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT * FROM Notes WHERE user_id = @user_id)
    BEGIN
        UPDATE Notes
        SET title = @note_title
        WHERE user_id = @user_id;
    END
    ELSE
        PRINT 'This user ID has no Notes!';
END

/* 2-21 */
-- Name: ShowMessages
-- Description: Show all messages received from a specific user.

GO
CREATE PROCEDURE ShowMessages
    @user_id INT,
    @sender_id INT
AS
BEGIN
    IF EXISTS (SELECT * FROM Communication WHERE sender_id = @sender_id AND receiver_id = @user_id)
    BEGIN
        SELECT *
        FROM Communication
        WHERE sender_id = @sender_id AND receiver_id = @user_id;
    END
    ELSE
        RAISERROR('THERE IS NO MESSAGE WITH THIS SENDER AND RECEIVER', 16, 1);
END

/* 3-1 */
-- Name: ViewUsers
-- Description: See details of all users and filter them by @user_type.

GO
CREATE PROCEDURE ViewUsers
    @user_type VARCHAR(20)
AS
BEGIN
    IF @user_type = 'admin'
    BEGIN
        SELECT *
        FROM Users U
        INNER JOIN Admin A ON U.id = A.admin_id;
    END
    ELSE
    BEGIN
        SELECT *
        FROM Users U
        INNER JOIN Guest G ON U.id = G.guest_id;
    END
END

/* 3-2 */
-- Name: RemoveEvent
-- Description: Remove an event from the system.

GO
CREATE PROCEDURE RemoveEvent
    @event_id INT,
    @user_id INT
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Calender WHERE event_id = @event_id)
        RAISERROR('EVENT ID OR USER ID NOT FOUND', 16, 1);
    ELSE
        IF EXISTS (SELECT * FROM Admin WHERE admin_id = @user_id)
        BEGIN
            DELETE FROM Calender
            WHERE event_id = @event_id;
        END
        ELSE
            RAISERROR('THIS USER ID DOES NOT HAVE PERMISSION TO REMOVE EVENTS', 16, 1);
END

/* 3-3 */
-- Name: CreateSchedule
-- Description: Create schedule for the rooms.

GO
CREATE PROCEDURE CreateSchedule
    @creator_id INT,
    @room_id INT,
    @start_time DATETIME,
    @end_time DATETIME,
    @action VARCHAR(20)
AS
BEGIN
    IF EXISTS (SELECT * FROM RoomSchedule WHERE creator_id = @creator_id AND room = @room_id AND start_time = @start_time)
        PRINT 'This room has already been scheduled for this time';
    ELSE
    BEGIN
        INSERT INTO RoomSchedule (creator_id, action, room, start_time, end_time)
        VALUES (@creator_id, @action, @room_id, @start_time, @end_time);
    END
END

 /*FROM 3-4 UNTIL 3-14 Hussein Mansour 10005024 */
 /* Number: 3-4
   Name: GuestRemove
   Description: Remove a guest from the system. */

GO
CREATE PROC GuestRemove 
    @guest_id int,
    @admin_id int,
    @number_of_allowed_guests int OUTPUT
AS
BEGIN
    IF EXISTS (SELECT * FROM Guest WHERE Guest.guest_id = @guest_id)
    BEGIN
        DELETE FROM Users 
        WHERE id = @guest_id;

        UPDATE Admin
        SET Admin.no_of_guests_allowed = Admin.no_of_guests_allowed + 1
        WHERE Admin.admin_id = @admin_id;

        SELECT @number_of_allowed_guests = Admin.no_of_guests_allowed
        FROM Admin
        WHERE Admin.admin_id = @admin_id;
    END
    ELSE 
        RAISERROR('No such guest exists in the database.', 16, 1);
END

SELECT * FROM Users;
SELECT * FROM Guest;

/* Number: 3-5
   Name: RecommendTD
   Description: Recommend travel destinations for guests under certain age. */

GO
CREATE PROC RecommendTD -- 3-5
    @guest_id int,
    @destination varchar(10),
    @age int,
    @preference_no int
AS
BEGIN
    DECLARE @trip_no int;
    DECLARE @guest_age int;

    SET @trip_no = NULL;

    IF EXISTS (SELECT 1 FROM Travel WHERE Travel.destination = @destination)
    BEGIN
        SELECT @trip_no = Travel.trip_no
        FROM Travel
        WHERE Travel.destination = @destination;
    END

    IF @trip_no IS NOT NULL
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Preferences WHERE Preferences.preferences_no = @preference_no)
        BEGIN
            IF EXISTS (SELECT 1 FROM Guest WHERE Guest.guest_id = @guest_id)
            BEGIN
                SELECT u.age
                FROM Guest INNER JOIN Users u ON Guest.guest_id = u.id
                WHERE Guest.guest_id = @guest_id;

                IF @guest_age < @age
                BEGIN
                    INSERT INTO Preferences
                    VALUES (@guest_id, 'Travel', @preference_no, @destination);

                    INSERT INTO Recommendation(user_id, category, preferences_no, content)
                    VALUES (@guest_id, 'Travel', @preference_no, @destination);
                END
                ELSE
                    PRINT 'This guest is over the specified age';
            END
            ELSE
                PRINT 'This guest does not exist!';
        END
        ELSE
            PRINT 'A preference with this preference number already exists!';
    END
    ELSE
        PRINT 'This destination does not exist';
END

/* Number: 3-6
   Name: Servailance
   Description: Access cameras in the house. */

GO
CREATE PROC Servailance
    @user_id int,
    @location int,
    @camera_id int
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE Users.id = @user_id) 
       AND EXISTS (SELECT 1 FROM Camera WHERE Camera.camera_id = @camera_id AND Camera.room_id = @location)
    BEGIN
        UPDATE Camera
        SET Camera.monitor_id = @user_id
        WHERE Camera.camera_id = @camera_id AND Camera.room_id = @location;
    END
    ELSE
        PRINT 'Something is wrong with your inputs.';
END

/* Number: 3-7
   Name: RoomAvailability
   Description: Change status of room. */

GO
CREATE PROC RoomAvailability -- 3-7
    @location int,
    @status varchar(40)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Room WHERE Room.room_id = @location)
    BEGIN
        UPDATE Room
        SET Room.status = @status
        WHERE Room.room_id = @location;
    END
    ELSE
        PRINT 'This room does not exist!';
END

/* Number: 3-8
   Name: Sp_Inventory
   Description: Create an inventory for a specific item. */

GO
CREATE PROC Sp_Inventory
    @item_id int,
    @name varchar(30),
    @quantity int,
    @expirydate datetime,
    @price decimal(10,2),
    @manufacturer varchar(30)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Inventory WHERE Inventory.supply_id = @item_id)
    BEGIN
        INSERT INTO Inventory (supply_id, name, quantity,expiry_date, price, manufacturer)
        VALUES (@item_id, @name, @quantity, @expirydate, @price, @manufacturer);
    END
    ELSE
        PRINT 'An item with this ID already exists.';
END

 /*FROM 3-15 UNTIL 3-24 Mamdouh Hazem 10001816 */

 -- Number: 3-15
-- Name: ViewRoom
-- Description: View rooms that are not being used

GO
CREATE PROCEDURE ViewRoom
AS 
BEGIN
    SELECT *
    FROM Room
    WHERE status = 'free';
END;

-- Number: 3-16
-- Name: ViewMeeting
-- Description: View the details of the booked rooms given @user_id and @room_id.

GO
CREATE PROCEDURE ViewMeeting
    @room_id int,
    @user_id int
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Room WHERE room_id = @room_id)
    BEGIN
        PRINT 'This room does not exist.';
    END
    ELSE IF EXISTS (SELECT 1 FROM RoomSchedule WHERE creator_id = @user_id AND room = @room_id)
    BEGIN
        SELECT *
        FROM RoomSchedule
        WHERE room = @room_id AND creator_id = @user_id;
    END
    ELSE
    BEGIN
        SELECT *
        FROM RoomSchedule
        WHERE creator_id = @user_id;
    END
END;

-- Number: 3-17
-- Name: AdminAddTask
-- Description: Add to the tasks

GO
CREATE PROCEDURE AdminAddTask
    @user_id INT,
    @creator INT,
    @name VARCHAR(30),
    @category VARCHAR(20),
    @priority INT,
    @status VARCHAR(20),
    @reminder DATETIME,
    @deadline DATETIME,
    @other_user INT
AS
BEGIN
    INSERT INTO Task (name, due_date, category, creator, priority, status, reminder_date)
    VALUES (@name, @deadline, @category, @creator, @priority, @status, @reminder); 

    DECLARE @task_id int;
    SET @task_id = SCOPE_IDENTITY();

    INSERT INTO Assigned_to VALUES (@creator, @task_id, @user_id);
    IF EXISTS(SELECT 1 FROM Users WHERE id = @other_user)
    BEGIN
        INSERT INTO Assigned_to VALUES (@creator, @task_id, @other_user);
    END
    ELSE
    BEGIN
        PRINT 'The other user does not exist';
    END
END;

-- Number: 3-18
-- Name: AddGuest
-- Description: Add Guests to the system, generate passwords for them and reserve rooms under their name.

GO
CREATE PROCEDURE AddGuest
    @email VARCHAR(30),
    @first_name VARCHAR(10),
    @address VARCHAR(30),
    @password VARCHAR(30),
    @guest_of INT,
    @room_id INT,
    @number_of_allowed_guests INT OUTPUT
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Admin WHERE admin_id = @guest_of)
    BEGIN
        RAISERROR('ENTER A VALID ADMIN ID', 16, 1);
    END
    ELSE IF NOT EXISTS(SELECT 1 FROM Room WHERE room_id = @room_id)
    BEGIN
        RAISERROR('ENTER A VALID ROOM ID', 16, 1);
    END
    ELSE IF EXISTS (SELECT 1 FROM Admin WHERE admin_id = @guest_of AND no_of_guests_allowed > 0)
    BEGIN
        DECLARE @Guest_id int;
        INSERT INTO Users(f_name, password, email, room)
        VALUES (@first_name, @password, @email, @room_id);
        SET @Guest_id = SCOPE_IDENTITY();
        
        INSERT INTO Guest (guest_ID, guest_of, address)
        VALUES (@Guest_id, @guest_of, @address);

        UPDATE Admin
        SET no_of_guests_allowed = no_of_guests_allowed - 1
        WHERE admin_id = @guest_of;

        SET @number_of_allowed_guests = (SELECT no_of_guests_allowed FROM Admin WHERE admin_id = @guest_of);
    END
    ELSE
    BEGIN
        RAISERROR ('Number of allowed guests exceeded the limit', 16, 1);
    END
END;

-- Number: 3-19
-- Name: AssignTask
-- Description: Assign task to a specific User

GO
CREATE PROCEDURE AssignTask
    @user_id INT,
    @task_id INT,
    @creator_id INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Users WHERE id = @user_id)
    BEGIN
        PRINT 'User does not exist';
    END
    ELSE IF NOT EXISTS (SELECT 1 FROM Admin WHERE admin_id = @creator_id)
    BEGIN
        PRINT 'Admin does not exist';
    END
    ELSE IF NOT EXISTS (SELECT 1 FROM Task WHERE Task_id = @task_id)
    BEGIN
        PRINT 'Task does not exist';
    END
    ELSE IF EXISTS (SELECT 1 FROM Task WHERE Task_id = @task_id AND creator = @creator_id)
    BEGIN
        INSERT INTO Assigned_to (admin_id, Task_id, users_id)
        VALUES (@creator_id, @task_id, @user_id);
    END
    ELSE
    BEGIN
        PRINT 'The task does not exist for the specified user';
    END
END;

-- Number: 3-20
-- Name: DeleteMsg
-- Description: Delete last message sent

GO
CREATE PROCEDURE DeleteMsg
AS
BEGIN
    IF (SELECT COUNT(*) FROM Communication) = 0
    BEGIN
        RAISERROR ('THERE ARE NO EXISTING MESSAGES TO BE DELETED', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM Communication
        WHERE message_id = (
            SELECT TOP 1 message_id
            FROM Communication
            ORDER BY time_sent DESC
        );
    END
END;

-- Number: 3-21
-- Name: AddItinerary
-- Description: Add outgoing flight itinerary for a specific flight

GO
CREATE PROCEDURE AddItinerary
    @trip_no INT,
    @flight_num VARCHAR(30),
    @flight_date DATETIME,
    @destination VARCHAR(40)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Travel WHERE trip_no = @trip_no)
    BEGIN
        UPDATE TRAVEL 
        SET outgoing_flight_date = @flight_date, outgoing_flight_num = @flight_num, destination = @destination
        WHERE trip_no = @trip_no;
    END
    ELSE
    BEGIN
        PRINT 'This flight does not exist';
    END
END;

-- Number: 3-22
-- Name: ChangeFlight
-- Description: Change flight date to next year for all flights in the current year

GO
CREATE PROCEDURE ChangeFlight
AS 
BEGIN
    UPDATE Travel
    SET ingoing_flight_date = DATEADD(YEAR, 1, ingoing_flight_date)
    WHERE YEAR(ingoing_flight_date) = YEAR(GETDATE());
END;

/* FROM 3-26 UNTIL 3-34 Ali Amr 10000652 */

 -- Number: 3-26
-- Name: Charging
-- Description: Set the status of all devices out of battery to charging

GO
CREATE PROC Charging
AS
BEGIN
    UPDATE Device
    SET status = 'charging'
    WHERE battery_status = 0
END

-- Number: 3-27
-- Name: GuestsAllowed
-- Description: Set the number of allowed guests for an admin

GO
CREATE PROC GuestsAllowed
    @admin_id int,
    @number_of_guests int
AS
BEGIN
    UPDATE Admin
    SET no_of_guests_allowed = @number_of_guests
    WHERE admin_id = @admin_id
END

-- Number: 3-28
-- Name: Penalize
-- Description: Add a penalty for all unpaid transactions where the deadline has passed.

GO
CREATE PROC Penalize
    @Penalty_amount int
AS 
BEGIN
    UPDATE Finance
    SET penalty = @Penalty_amount
    WHERE date > deadline
END

-- Number: 3-29
-- Name: GuestNumber
-- Description: Get the number of all guests currently present for a certain admin

GO
CREATE PROC GuestNumber
    @admin_id int,
    @no_of_guests int OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Admin WHERE admin_id = @admin_id)
    BEGIN
        SELECT @no_of_guests = COUNT(G.guest_of) 
        FROM Admin A 
        INNER JOIN Guest G ON A.admin_id = G.guest_of
        WHERE A.admin_id = @admin_id;
        PRINT @no_of_guests;
    END
    ELSE 
    BEGIN
        RAISERROR('ADMIN ID IS INVALID', 16, 1)
    END
END

-- Number: 3-30
-- Name: Youngest
-- Description: Get the youngest user in the system

GO
CREATE PROC Youngest
AS
BEGIN
    SELECT *
    FROM Users
    WHERE birth_date = (SELECT MAX(birth_date) FROM Users);
END

-- Number: 3-31
-- Name: AveragePayment
-- Description: Get the users whose average income per month is greater than a specific amount

GO
CREATE PROC AveragePayment
    @amount decimal(10, 2)
AS
BEGIN
    SELECT U.f_Name, U.l_Name 
    FROM Users U 
    INNER JOIN Admin A ON A.admin_id = U.id
    WHERE A.salary > @amount
END

-- Number: 3-32
-- Name: Purchase
-- Description: Get the sum of all purchases needed in the home inventory (assuming you need only 1 of each missing item)

GO
CREATE PROC Purchase
    @amount int OUTPUT 
AS
BEGIN 
    SELECT @amount = SUM(price)
    FROM Inventory
    WHERE quantity = 0
    PRINT @amount
END

-- Number: 3-33
-- Name: NeedCharge
-- Description: Get the location where more than two devices have a dead battery

GO
CREATE PROC NeedCharge
AS
BEGIN
    SELECT room
    FROM (
        SELECT room, COUNT(device_id) AS device_count
        FROM Device
        WHERE battery_status = 0
        GROUP BY room
        HAVING COUNT(device_id) > 1
    ) AS S
END

-- Number: 3-34
-- Name: Admins
-- Description: Get the admin with more than 2 guests

GO
CREATE PROC Admins
AS 
BEGIN
    SELECT U.f_name, U.l_name
    FROM Admin A 
    INNER JOIN Guest G ON A.admin_ID = G.guest_of
    INNER JOIN Guest G2 ON G.guest_of = G2.guest_of 
    INNER JOIN Guest G3 ON G3.guest_of = G2.guest_of
    INNER JOIN Users U ON A.admin_ID = U.iD
    WHERE G.guest_ID > G2.guest_ID AND G3.guest_ID < G2.guest_ID
END

-- Number: 3-35
-- Name: addAdmin
-- Description: Add a new admin to the system

GO
CREATE PROC addAdmin
    @admin_id int,
    @no_of_guests_allowed int,
    @salary decimal(10, 2)
AS
BEGIN
    INSERT INTO Admin VALUES (@admin_id, @no_of_guests_allowed, @salary)
END

-- Number: 3-36
-- Name: addGuestInput
-- Description: Add a guest to the system after validating against allowed guests

GO
CREATE PROC addGuestInput
    @guest_id int,
    @guest_of int,
    @adress VARCHAR(30),
    @arrival_date DATETIME,
    @departure_date DATETIME,
    @residential VARCHAR(50),
    @isValid BIT OUTPUT
AS 
BEGIN
    DECLARE @allowedGuests int
    EXEC GuestsAllowed @guest_of, @allowedGuests OUTPUT;
    
    DECLARE @totalGuests int
    EXEC GuestNumber @guest_of, @allowedGuests OUTPUT;

    IF (@totalGuests < @allowedGuests)
    BEGIN
        INSERT INTO Guest VALUES (@guest_id, @guest_of, @adress, @arrival_date, @departure_date, @residential)
        SET @isValid = 1;
    END
    ELSE
    BEGIN
        SET @isValid = 0;
    END
END;

-- Number: 3-37
-- Name: getUserType
-- Description: Get the user type based on email and password

GO
CREATE PROC getUserType
    @email varchar(50),
    @password varchar(10),
    @usertype varchar(20) OUTPUT
AS
BEGIN
    SELECT @usertype = u.type
    FROM Users u
    WHERE u.email = @email AND u.password = @password
END


