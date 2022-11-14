--10
--select model, count(seat_no) as ' ол_во мест' from aircrafts_data
--join seats on seats.aircraft_code = aircrafts_data.aircraft_code
--group by model

--11
--select airport_name, COUNT(arrival_airport) as 'кол-во прин€тых рейсов' from airports_data
--join flights 
--on flights.arrival_airport = airports_data.airport_code
--group by airport_name
--having COUNT(arrival_airport) > 500

--16
--select model from aircrafts_data
--join flights
--on flights.aircraft_code = aircrafts_data.aircraft_code
--where DATEDIFF(hour, actual_departure, actual_arrival) >6
--group by  model

--17
--select flight_no from flights
--where DATEDIFF(hour, scheduled_departure, actual_departure) >4

--20
--create view z20
--as
--select count(flight_no) as 'кол-во', actual_arrival as 'день' from flights
--where arrival_airport = 'BAX' 
--group by actual_arrival

--4
--select passenger_name, departure_airport, arrival_airport,actual_arrival,seat_no from tickets
--join ticket_flights
--on tickets.ticket_no = ticket_flights.ticket_no
--join flights
--on flights.flight_id = ticket_flights.flight_id
--join seats
--on flights.aircraft_code = seats.aircraft_code
--where actual_departure < GETDATE()

--5
--select passenger_name from tickets
--join ticket_flights
--on tickets.ticket_no = ticket_flights.ticket_no
--join flights
--on ticket_flights.flight_id = flights.flight_id
--where tickets.ticket_no not in (select ticket_no from boarding_passes) and
--DATePART(day, scheduled_departure) = DATEPART(day,GETDATE())

--6
--select seat_no from seats
--join aircrafts_data
--on seats.aircraft_code = aircrafts_data.aircraft_code
--join flights
--on aircrafts_data.aircraft_code = flights.aircraft_code
--where departure_airport = 'asf' and 
--arrival_airport= 'svo' and
--seat_no not in (select seat_no from boarding_passes)

--12
--insert into bookings values
--('123342',getdate(),30000)
--insert into tickets values
--('34656575675','123342','1','BVANOV ARTEM','89999999999')
--insert into ticket_flights values
--('346565756752',9923,'Economy',15000)
--insert into ticket_flights values
--('34656575675',5555,'Business',15000)