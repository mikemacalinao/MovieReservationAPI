using System;

namespace MovieReservationAPI.Models
{
    #region ***** CINEMAS *****
    public class SaveCinema
    {
        public byte cinema_id { get; set; }
        public string description { get; set; }
        public int seats { get; set; }
        public decimal default_price { get; set; }
    }

    public class Seat
    {
        public byte seat_id { get; set; }
        public byte row { get; set; }
        public byte col { get; set; }
    }

    #endregion

    #region ***** MOVIES *****

    public class SaveMovie
    {
        public int movie_id { get; set; }
        public string title { get; set; }
        public string description { get; set; }
        public string imgtype { get; set; }
        public decimal default_price { get; set; }
    }

    #endregion

    #region ***** SCHEDULES *****

    public class SaveSchedule
    {
        public int schedule_id { get; set; }
        public int movie_id { get; set; }
        public byte cinema_id { get; set; }
        public decimal price { get; set; }
        public DateTime date_time { get; set; }
    }

    #endregion

    #region ***** RESERVATIONS *****

    public class SaveReservation
    {
        public int schedule_id { get; set; }
        public string customer_name { get; set; }
        public string reservation_details { get; set; }
        public decimal total { get; set; }
    }

    public class ReservationDetail
    {
        public int seat_id { get; set; }
    }

    public class CancelReservations
    {
        public string cancel_reservation { get; set; }
    }

    public class Reservation
    {
        public int reservation_id { get; set; }
    }

    public class CancelAllReservations
    {
        public int schedule_id { get; set; }
    }

    #endregion
}