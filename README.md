# Event-managment-sql
Simple Event Management system using PL/SQL stored procedures
Description

You are to provide a management system where customers book events in a specific hotel. Events are birthdays, weddings, conferences, etc. A customer making a reservation can reserve one hall, however, the same customer can make multiple reservations if needed (e.g. a conference event that requires 3 small halls, and 1 large hall results in 4 reservations).

Assumptions
                                                                     
Room type	Capacity	Price
Small Hall	100	$500
Medium Hall	250	$1000
Large Hall	500	$2000

1.	The daily rates of each room type and their capacities (max number of people) are as follows:  

2.	You should make event reservations for consecutive days for a specific room type.
3.	If a reservation is made 2 months in advance or more, the customer gets a 10% discount on the rate. Otherwise, the customer has to pay full rate.
4.	There are no taxes charged to customers. ERU made a deal with the IRS not to collect taxes from guests (to make things easier for the implementation) 
5.	Event Room hall types: small hall, medium hall, large hall.
6.	Customers pay their invoices when the event is over.
7.	A guest can reserve and stay in multiple rooms at the same time (e.g. a large family) and must pay for all reserved rooms. 
8.	The services that are offered by all ERU events are the same. They include:
Service Type	Amount
Breakfast 	$10 per person
Lunch 	$20 per person
DJ 	$500 per event
Singer 	$2000 per event
Pop band 	$10000 per event

The actual tasks for the event management system are given below. 

1.	Add a new hotel: Create a new hotel with appropriate information about the hotel as input parameters. Minimum parameters are Address, Phone, Event Room Types available etc. Have in mind that you will need more parameters.
2.	Find a hotel: Provide as input the address of the hotel and return its hotel ID
3.	Display hotel info: Given a hotel ID, display all information about that hotel
4.	Add Event Room: Given a hotel ID, add a new room for a specific event to that hotel. The room types are: Small Hall, Medium hall, Large hall.
5.	Report Hotels and Event Rooms In State: Given a state, display event room information of all hotels in that particular state. Include total capacity per event room type per hotel. 
6.	Show available rooms by type: Given a hotel ID, display the count of all available rooms by room type. 
7.	Make an event reservation: Input parameters: Hotel ID, guest’s name, start date, end date, event type, date of reservation, number of people attending, etc. Output: event reservation ID (this is called confirmation code in real-life). NOTE: Only one person can make an event reservation. However, the same person can make multiple reservations. Event types: Birthday, Wedding, Conference, Workshop, Hackathon, University Admission, etc. Also make sure that the reserved hall has capacity that can hold the number of people attending. For example, for a conference of 500 people, a customer must reserve 2 medium halls and a large hall for each day of the conference, usually 3 consecutive days.
8.	Find an event reservation: Input is a person’s name and date, hotel ID. Output is event reservation ID
9.	Cancel an event: Input the event reservationID and mark the reservation as cancelled (do NOT delete it)
10.	ShowCancelations: Print all canceled events in the event management system. Show event reservation ID, hotel name, location, event type, room type, dates.
11.	 Change an event Date: Input the event reservation ID and change event start and end date, if there is availability in the same or larger room type for the new date interval
12.	Change an event RoomType: Input the reservation ID and change reservation room type if there is availability for the new room type during the reservation’s date interval
13.	Show specific event: Given an event type (Birthday, Wedding, etc.) display all events of that type in all hotels along with the address of the hotel and the date of the event.
14.	Show events by person: Given a person’s name, find all events under that name
15.	Total Monthly Income Report: Calculate and display total income from all sources of all hotels. Totals must be printed by month, and for each month by event and service type. Include discounts. 
16.	Event Invoice: Input: Event reservationID  Output: 
	Name of person that reserved the event
	Event room number(s), rate per day and possibly multiple rooms (if someone reserved several rooms) 
	Services rendered per date, type, and amount
	Discounts applied (if any)
	Total amount to be paid 
17.	Add a service to an event: Input: Event reservationID, specific service. Add the service to the event for a particular date. Multiple services are allowed on a reservation for the same date. For meals make sure to multiply the amount by the number of people attending the event.
18.	Reservation Services Report: Input the event reservation ID and display all services on this reservation. Also print the number of attendees of the event. Print “no services for this reservation” if none exists.
19.	Show Specific Service Report: Input the service name, and display information on all reservations that have this service in all hotels
20.	Services Income Report: Given a hotelID, calculate and display income from all services in all reservations in that hotel.
21.	Income by State Report: Input is a specific state. Print total income from all events as follows: Each output line should contain information of a specific event ID (income from room type, income from services, total income of this event). At the end a grand total of all events income. Include discounts.
