-- show databases;
-- drop database DBMSAssign;
CREATE DATABASE DBMSAssign;
use DBMSAssign;
-- show tables;
-- desc Note;
-- drop table Note;    
-- delete from  usernote;
-- delete from  Notereminder;
-- delete from NoteCategory;
-- delete from Note;
-- delete from User;
-- select * from usernote;
 
/*Create the tables for Note, Category, Reminder, User, UserNote, NoteReminder and NoteCategory.*/
/*1. User table fields: user_id, user_name, user_added_date, user_password, user_mobile*/
-- start transaction;
CREATE TABLE User(user_id int(11) NOT NULL auto_increment,
user_name VARCHAR(20),user_added_date DATE, user_password VARCHAR(20),
user_mobile VARCHAR(20), PRIMARY KEY  (`user_id`));
/*2. Note table fields: note_id, note_title, note_content, note_status, note_creation_date*/
CREATE TABLE Note(note_id int(11) NOT NULL auto_increment,
note_title VARCHAR(20),note_content VARCHAR(20),note_status VARCHAR(20),
note_creation_date DATE, 
 PRIMARY KEY  (`note_id`));
 /*7. usernote table fields : usernote_id, user_id, note_id*/

CREATE TABLE usernote(usernote_id int(11) NOT NULL auto_increment,
user_id int(11) NOT NULL,note_id int(11) NOT NULL,
foreign key fk_note2(note_id) references Note(note_id) on update cascade on delete no action,
foreign key fk_User(user_id) references User(user_id) on update cascade on delete no action,
 PRIMARY KEY  (`usernote_id`));
 
-- commit;
/*3.Category table fields : category_id, category_name, category_descr, category_creation_date, category_creator*/
CREATE TABLE Category(category_id int(11) NOT NULL auto_increment,
category_name VARCHAR(20),category_descr VARCHAR(500),
category_creation_date DATE, category_creator VARCHAR(20),
 PRIMARY KEY  (`category_id`));

/*5. NoteCategory table fields : notecategory_id, note_id, category_id*/

CREATE TABLE NoteCategory(notecategory_id int(11) NOT NULL auto_increment,
note_id int(11) NOT NULL,category_id int(11) NOT NULL,
foreign key fk_note(note_id) references Note(note_id) on update cascade on delete no action,
foreign key fk_Category(category_id) references Category(category_id) on update cascade on delete no action,
 PRIMARY KEY  (`notecategory_id`));
 
/*4.Reminder table fields : reminder_id, reminder_name, reminder_descr, reminder_type, reminder_creation_date, reminder_creator*/

CREATE TABLE Reminder(reminder_id int(11) NOT NULL auto_increment,
reminder_name VARCHAR(20),reminder_descr VARCHAR(500),reminder_type VARCHAR(20),
reminder_creation_date DATE, reminder_creator VARCHAR(20),
 PRIMARY KEY  (`reminder_id`));
  
/*6. Notereminder table fields : notereminder_id, note_id, reminder_id*/

CREATE TABLE Notereminder(notereminder_id int(11) NOT NULL auto_increment,
note_id int(11) NOT NULL,reminder_id int(11) NOT NULL,
foreign key fk_note1(note_id) references Note(note_id) on update cascade on delete no action,
foreign key fk_Reminder(reminder_id) references Reminder(reminder_id) on update cascade on delete no action,
 PRIMARY KEY  (`notereminder_id`));
 

/*Insert the rows into the created tables (Note, Category, Reminder, User, UserNote, NoteReminder and NoteCategory).*/
/*User*/
--  start transaction;
-- <Insert STATEMENT>--
insert into User(user_name,user_added_date,user_password,user_mobile) values('karthik','2018-12-03','Shastha','9962876600');
set @userid=LAST_INSERT_ID();
-- select @userid;
-- Note
insert into Note(note_title,note_creation_date,note_status,note_content) values('java','2018-12-03','yes','Java OPS');
set @noteid=LAST_INSERT_ID();
-- select @noteid;
-- UserNote
insert into usernote(user_id,note_id) values(@userid,@noteid);
-- commit; 
-- Category
insert into Category(category_name,category_creation_date,category_descr,category_creator) values('Software','2018-12-03','Information Technology','karthik');
set @CategoryId=LAST_INSERT_ID();
-- NoteCategory
insert into NoteCategory(note_id,category_id) values(@noteid,@CategoryId);
-- Reminder
insert  into Reminder(reminder_name,reminder_creation_date,reminder_descr,reminder_type,reminder_creator) values('Updates','2018-12-03','Information Technology','Email','Admin');
set @Remainderid=LAST_INSERT_ID();
-- NOteReminder
insert into Notereminder(note_id,reminder_id) values(@noteid,@Remainderid);
-- <Insert STATEMENT>--
-- <Select  statement>
-- Fetch the row from User table based on Id and Password.
 select * from User where user_id=1 and user_password='Shastha' ;

-- Fetch all the rows from Note table based on the field note_creation_date.
select * from Note where note_creation_date='2018-12-03';

-- Fetch all the Categories created after the particular Date.
select * from Category where category_creation_date between '2018-12-02' and '2018-12-03';

-- Fetch all the Note ID from UserNote table for a given User.
select note_id  from usernote  where user_id=1;

-- Write Update query to modify particular Note for the given note Id.
update Note  set note_content='Object Oriented', note_creation_date='2018-12-03', note_status='yes'  where note_id in(1,2);

-- Fetch all the Notes from the Note table by a particular User.
select note.* 
from Note as note inner join usernote as usernote on note.note_id=usernote.note_id
inner join User as user on user.user_id=usernote.user_id
where user.user_name in('karthik');

-- Fetch all the Notes from the Note table for a particular Category.

select note.*
from 
Note as note inner join NoteCategory as notecategory on note.note_id=notecategory.note_id
inner join Category as category  on notecategory.category_id=category.category_id
where category.category_name in('Software');

-- Fetch all the reminder details for a given note id.

select reminder.* 
from Reminder as reminder 
inner join Notereminder as notereminder on note.note_id=notereminder.note_id
inner join Note as note on note.note_id=notereminder.note_id
where ote.note_id in(1);

-- Fetch the reminder details for a given reminder id.

select * from Reminder where reminder_id in(1);

-- <Select  statement>
-- Write a query to create a new Note from particular User (Use Note and UserNote tables - insert statement).

insert into Note(note_title,note_creation_date,note_status,note_content) values('.NET','2018-12-04','yes','.NET framework');
set @noteUserid=LAST_INSERT_ID();
insert into usernote(user_id,note_id) values((select user_id from User where  user_id in(1)),@noteUserid);

-- Write a query to create a new Note from particular User to particular Category(Use Note and NoteCategory tables - insert statement)

insert into Note(note_title,note_creation_date,note_status,note_content) values('SDFC','2018-12-04','yes','sales forces');
set @notecategoryid=LAST_INSERT_ID();
insert into NoteCategory(note_id,category_id) values((select category_id from Category  
where category_name in('Software')),@notecategoryid);

-- Write a query to set a reminder for a particular note (Use Reminder and NoteReminder tables - insert statement)

insert  into Reminder(reminder_name,reminder_creation_date,reminder_descr,reminder_type,reminder_creator) 
values('News','2018-12-04','Information Technology','Email','Admin');
set @ReminderNoteId=LAST_INSERT_ID();
insert into Notereminder(note_id,reminder_id) values((select  note_id from Note where note_id=1),@ReminderNoteId);

-- Write a query to delete particular Note added by a User(Note and UserNote tables - delete statement)
delete note,usernote,notecategory,notereminder from Note as note
inner join NoteCategory as notecategory on notecategory.note_id=note.note_id
inner join Notereminder as notereminder on notereminder.note_id=note.note_id
inner join usernote as usernote on usernote.note_id=note.note_id
inner join User as user on user.user_id=usernote.user_id
where user.user_id  in(1);

-- where note_id in(select user_id from usernote where user_id in(1));

-- Write a query to delete particular Note from particular Category(Note and NoteCategory tables - delete statement)
delete note,usernote,notecategory,notereminder from Note as note
inner join NoteCategory as notecategory on notecategory.note_id=note.note_id
inner join Notereminder as notereminder on notereminder.note_id=note.note_id
inner join usernote as usernote on usernote.note_id=note.note_id
inner join Category as category on category.user_id=usernote.user_id
where category.category_name in('Software');


/*
Create a trigger to delete all matching records from UserNote, NoteReminder and NoteCategory table 
when : 
1. A particular note is deleted from Note table (all the matching records from UserNote, 
NoteReminder and NoteCategory should be removed automatically) */
DELIMITER //
create trigger note_trigger after delete on Note 
for each row
begin
delete from usernote where usernote.note_id=Note.note_id;
delete  from NoteCategory where NoteCategory.note_id=Note.note_id;
delete from Notereminder where Notereminder.note_id=Note.note_id;

END;
//
DELIMITER;

-- 2.A particular user is deleted from User table (all the matching notes should be removed automatically)

DELIMITER //
create trigger user_trigger after delete on User 
for each row
begin
-- declare  noteid int(11);

delete from Note where note_id in(select note_id  from  usernote where  usernote.user_id=User.user_id);
delete from Category where category_id in(select category_id from NoteCategory where note_id in(select note_id  from  usernote where  usernote.user_id=User.user_id));
delete  from NoteCategory where NoteCategory.note_id in(select note_id  from  usernote where  usernote.user_id=User.user_id);
delete from Reminder where reminder_id in(select reminder_id from Notereminder where note_id in(select note_id  from  usernote where  usernote.user_id=User.user_id));
delete from Notereminder where Notereminder.note_id in(select note_id  from  usernote where  usernote.user_id=User.user_id);
delete from usernote where usernote.note_id in(select note_id  from  usernote where  usernote.user_id=User.user_id);
END;
//
DELIMITER;

