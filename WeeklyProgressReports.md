# Weekly Progress Reports - Week 5-6 (22.10.2012-04.11.2012) #

In Week 5-6 (Note that two weeks are combined in the weekly progress report due to the bayram holiday), our target milestone is completed.

A basic login page is created, since a detailed registration and login operation will be done later, according to our plan. After login operation, user reaches his/her profile page, which can be seen below in its first version.

http://cmpe352spring2012group2.googlecode.com/files/ProfilePageVersion1.JPG

From there, offer a service page is implemented, which takes service title, service description, time interval for the service and tags from user. Additionally, as our client demands, user can select address from the map and the radius from the given address. Furthermore, user can select multiple addresses. This page can be seen below.

http://cmpe352spring2012group2.googlecode.com/files/OfferServicePageVersion1.JPG

In addition to these, offered services can be accessible from the profile page. This is accomplished with the implementation of Offered Services page. Additionally, offered services can be updated from here. Snapshot from this page can be seen below.

http://cmpe352spring2012group2.googlecode.com/files/OfferedServicesVersion1.JPG


# Weekly Progress Reports - Week 4 (15.10.2012-21.10.2012) #

We have completed the "Preparing the Development Environment" step in our project plan. Last week, we installed Tomcat, established connections between Tomcat and Eclipse and with the sql server that is provided.

We have created our database design in this week.  We decided to have 7 tables, named as
  * User
  * Appliers
  * Categories
  * OpenServices
  * CompletedServices
  * Place
  * Tags

Throughout this stage, we took the database design principles into account. Additionally, tables are related to each other by using referential constraints like Foreign Keys.

After completing the design, we constructed our database, which can be seen below:

http://cmpe352spring2012group2.googlecode.com/files/Database_Tables.JPG

Content of the User Table can be seen below:

http://cmpe352spring2012group2.googlecode.com/files/User_Table.JPG

Created a simple page and deployed it to the server to check database connection is working.

  * **Our Project Web Page can be accessible from:**

> http://titan.cmpe.boun.edu.tr:8081/InitialProjectGroup2/