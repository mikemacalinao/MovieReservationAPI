﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MovieReservationAPI.DataSources
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class dbmoviereservationEntities : DbContext
    {
        public dbmoviereservationEntities()
            : base("name=dbmoviereservationEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
    
        public virtual int sp_cancelallreservation(Nullable<int> schedule_id)
        {
            var schedule_idParameter = schedule_id.HasValue ?
                new ObjectParameter("schedule_id", schedule_id) :
                new ObjectParameter("schedule_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_cancelallreservation", schedule_idParameter);
        }
    
        public virtual int sp_cancelreservation(Nullable<int> reservation_id)
        {
            var reservation_idParameter = reservation_id.HasValue ?
                new ObjectParameter("reservation_id", reservation_id) :
                new ObjectParameter("reservation_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_cancelreservation", reservation_idParameter);
        }
    
        public virtual ObjectResult<Nullable<int>> sp_checkcinema(Nullable<byte> cinema_id, string description)
        {
            var cinema_idParameter = cinema_id.HasValue ?
                new ObjectParameter("cinema_id", cinema_id) :
                new ObjectParameter("cinema_id", typeof(byte));
    
            var descriptionParameter = description != null ?
                new ObjectParameter("description", description) :
                new ObjectParameter("description", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<int>>("sp_checkcinema", cinema_idParameter, descriptionParameter);
        }
    
        public virtual ObjectResult<Nullable<int>> sp_checkmovie(Nullable<int> movie_id, string title, string description)
        {
            var movie_idParameter = movie_id.HasValue ?
                new ObjectParameter("movie_id", movie_id) :
                new ObjectParameter("movie_id", typeof(int));
    
            var titleParameter = title != null ?
                new ObjectParameter("title", title) :
                new ObjectParameter("title", typeof(string));
    
            var descriptionParameter = description != null ?
                new ObjectParameter("description", description) :
                new ObjectParameter("description", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<int>>("sp_checkmovie", movie_idParameter, titleParameter, descriptionParameter);
        }
    
        public virtual ObjectResult<Nullable<int>> sp_checkschedule(Nullable<int> schedule_id, Nullable<byte> cinema_id, Nullable<System.DateTime> date_time)
        {
            var schedule_idParameter = schedule_id.HasValue ?
                new ObjectParameter("schedule_id", schedule_id) :
                new ObjectParameter("schedule_id", typeof(int));
    
            var cinema_idParameter = cinema_id.HasValue ?
                new ObjectParameter("cinema_id", cinema_id) :
                new ObjectParameter("cinema_id", typeof(byte));
    
            var date_timeParameter = date_time.HasValue ?
                new ObjectParameter("date_time", date_time) :
                new ObjectParameter("date_time", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<int>>("sp_checkschedule", schedule_idParameter, cinema_idParameter, date_timeParameter);
        }
    
        public virtual ObjectResult<sp_getcinemas_Result> sp_getcinemas(Nullable<int> cinema_id)
        {
            var cinema_idParameter = cinema_id.HasValue ?
                new ObjectParameter("cinema_id", cinema_id) :
                new ObjectParameter("cinema_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_getcinemas_Result>("sp_getcinemas", cinema_idParameter);
        }
    
        public virtual ObjectResult<sp_getcinemaschedules_Result> sp_getcinemaschedules(Nullable<int> cinema_id)
        {
            var cinema_idParameter = cinema_id.HasValue ?
                new ObjectParameter("cinema_id", cinema_id) :
                new ObjectParameter("cinema_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_getcinemaschedules_Result>("sp_getcinemaschedules", cinema_idParameter);
        }
    
        public virtual ObjectResult<sp_getcinemaseats_Result> sp_getcinemaseats(Nullable<int> schedule_id)
        {
            var schedule_idParameter = schedule_id.HasValue ?
                new ObjectParameter("schedule_id", schedule_id) :
                new ObjectParameter("schedule_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_getcinemaseats_Result>("sp_getcinemaseats", schedule_idParameter);
        }
    
        public virtual ObjectResult<sp_gethistory_Result> sp_gethistory(Nullable<int> schedule_id)
        {
            var schedule_idParameter = schedule_id.HasValue ?
                new ObjectParameter("schedule_id", schedule_id) :
                new ObjectParameter("schedule_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_gethistory_Result>("sp_gethistory", schedule_idParameter);
        }
    
        public virtual ObjectResult<sp_gethistoryseats_Result> sp_gethistoryseats(Nullable<int> schedule_id)
        {
            var schedule_idParameter = schedule_id.HasValue ?
                new ObjectParameter("schedule_id", schedule_id) :
                new ObjectParameter("schedule_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_gethistoryseats_Result>("sp_gethistoryseats", schedule_idParameter);
        }
    
        public virtual ObjectResult<sp_getmovies_Result> sp_getmovies(Nullable<int> movie_id)
        {
            var movie_idParameter = movie_id.HasValue ?
                new ObjectParameter("movie_id", movie_id) :
                new ObjectParameter("movie_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_getmovies_Result>("sp_getmovies", movie_idParameter);
        }
    
        public virtual ObjectResult<Nullable<int>> sp_getnewmovieid()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<int>>("sp_getnewmovieid");
        }
    
        public virtual ObjectResult<sp_getnowshowing_Result> sp_getnowshowing()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_getnowshowing_Result>("sp_getnowshowing");
        }
    
        public virtual ObjectResult<sp_getschedules_Result> sp_getschedules(Nullable<int> schedule_id)
        {
            var schedule_idParameter = schedule_id.HasValue ?
                new ObjectParameter("schedule_id", schedule_id) :
                new ObjectParameter("schedule_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_getschedules_Result>("sp_getschedules", schedule_idParameter);
        }
    
        public virtual ObjectResult<sp_savecinema_Result> sp_savecinema(Nullable<int> cinema_id, string description, Nullable<int> seat_count, Nullable<decimal> default_price)
        {
            var cinema_idParameter = cinema_id.HasValue ?
                new ObjectParameter("cinema_id", cinema_id) :
                new ObjectParameter("cinema_id", typeof(int));
    
            var descriptionParameter = description != null ?
                new ObjectParameter("description", description) :
                new ObjectParameter("description", typeof(string));
    
            var seat_countParameter = seat_count.HasValue ?
                new ObjectParameter("seat_count", seat_count) :
                new ObjectParameter("seat_count", typeof(int));
    
            var default_priceParameter = default_price.HasValue ?
                new ObjectParameter("default_price", default_price) :
                new ObjectParameter("default_price", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_savecinema_Result>("sp_savecinema", cinema_idParameter, descriptionParameter, seat_countParameter, default_priceParameter);
        }
    
        public virtual ObjectResult<Nullable<int>> sp_savemovie(Nullable<int> movie_id, string title, string description, string imgtype, Nullable<decimal> default_price)
        {
            var movie_idParameter = movie_id.HasValue ?
                new ObjectParameter("movie_id", movie_id) :
                new ObjectParameter("movie_id", typeof(int));
    
            var titleParameter = title != null ?
                new ObjectParameter("title", title) :
                new ObjectParameter("title", typeof(string));
    
            var descriptionParameter = description != null ?
                new ObjectParameter("description", description) :
                new ObjectParameter("description", typeof(string));
    
            var imgtypeParameter = imgtype != null ?
                new ObjectParameter("imgtype", imgtype) :
                new ObjectParameter("imgtype", typeof(string));
    
            var default_priceParameter = default_price.HasValue ?
                new ObjectParameter("default_price", default_price) :
                new ObjectParameter("default_price", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<int>>("sp_savemovie", movie_idParameter, titleParameter, descriptionParameter, imgtypeParameter, default_priceParameter);
        }
    
        public virtual ObjectResult<Nullable<int>> sp_savereservation(Nullable<int> schedule_id, string customer_name, Nullable<decimal> total)
        {
            var schedule_idParameter = schedule_id.HasValue ?
                new ObjectParameter("schedule_id", schedule_id) :
                new ObjectParameter("schedule_id", typeof(int));
    
            var customer_nameParameter = customer_name != null ?
                new ObjectParameter("customer_name", customer_name) :
                new ObjectParameter("customer_name", typeof(string));
    
            var totalParameter = total.HasValue ?
                new ObjectParameter("total", total) :
                new ObjectParameter("total", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<int>>("sp_savereservation", schedule_idParameter, customer_nameParameter, totalParameter);
        }
    
        public virtual ObjectResult<Nullable<int>> sp_saveschedule(Nullable<int> schedule_id, Nullable<int> movie_id, Nullable<byte> cinema_id, Nullable<decimal> price, Nullable<System.DateTime> date_time)
        {
            var schedule_idParameter = schedule_id.HasValue ?
                new ObjectParameter("schedule_id", schedule_id) :
                new ObjectParameter("schedule_id", typeof(int));
    
            var movie_idParameter = movie_id.HasValue ?
                new ObjectParameter("movie_id", movie_id) :
                new ObjectParameter("movie_id", typeof(int));
    
            var cinema_idParameter = cinema_id.HasValue ?
                new ObjectParameter("cinema_id", cinema_id) :
                new ObjectParameter("cinema_id", typeof(byte));
    
            var priceParameter = price.HasValue ?
                new ObjectParameter("price", price) :
                new ObjectParameter("price", typeof(decimal));
    
            var date_timeParameter = date_time.HasValue ?
                new ObjectParameter("date_time", date_time) :
                new ObjectParameter("date_time", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<int>>("sp_saveschedule", schedule_idParameter, movie_idParameter, cinema_idParameter, priceParameter, date_timeParameter);
        }
    
        public virtual ObjectResult<Nullable<int>> sp_saveseat(Nullable<int> seat_id, Nullable<byte> cinema_id, Nullable<byte> row, Nullable<byte> col)
        {
            var seat_idParameter = seat_id.HasValue ?
                new ObjectParameter("seat_id", seat_id) :
                new ObjectParameter("seat_id", typeof(int));
    
            var cinema_idParameter = cinema_id.HasValue ?
                new ObjectParameter("cinema_id", cinema_id) :
                new ObjectParameter("cinema_id", typeof(byte));
    
            var rowParameter = row.HasValue ?
                new ObjectParameter("row", row) :
                new ObjectParameter("row", typeof(byte));
    
            var colParameter = col.HasValue ?
                new ObjectParameter("col", col) :
                new ObjectParameter("col", typeof(byte));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<int>>("sp_saveseat", seat_idParameter, cinema_idParameter, rowParameter, colParameter);
        }
    
        public virtual int sp_updateusedreservation(Nullable<int> schedule_id)
        {
            var schedule_idParameter = schedule_id.HasValue ?
                new ObjectParameter("schedule_id", schedule_id) :
                new ObjectParameter("schedule_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_updateusedreservation", schedule_idParameter);
        }
    
        public virtual ObjectResult<Nullable<int>> sp_checkschedulecount(Nullable<int> schedule_id, Nullable<byte> cinema_id, Nullable<System.DateTime> date_time)
        {
            var schedule_idParameter = schedule_id.HasValue ?
                new ObjectParameter("schedule_id", schedule_id) :
                new ObjectParameter("schedule_id", typeof(int));
    
            var cinema_idParameter = cinema_id.HasValue ?
                new ObjectParameter("cinema_id", cinema_id) :
                new ObjectParameter("cinema_id", typeof(byte));
    
            var date_timeParameter = date_time.HasValue ?
                new ObjectParameter("date_time", date_time) :
                new ObjectParameter("date_time", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<int>>("sp_checkschedulecount", schedule_idParameter, cinema_idParameter, date_timeParameter);
        }
    
        public virtual ObjectResult<Nullable<int>> sp_savereservationdetail(Nullable<int> reservation_id, Nullable<int> seat_id, Nullable<int> schedule_id)
        {
            var reservation_idParameter = reservation_id.HasValue ?
                new ObjectParameter("reservation_id", reservation_id) :
                new ObjectParameter("reservation_id", typeof(int));
    
            var seat_idParameter = seat_id.HasValue ?
                new ObjectParameter("seat_id", seat_id) :
                new ObjectParameter("seat_id", typeof(int));
    
            var schedule_idParameter = schedule_id.HasValue ?
                new ObjectParameter("schedule_id", schedule_id) :
                new ObjectParameter("schedule_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<int>>("sp_savereservationdetail", reservation_idParameter, seat_idParameter, schedule_idParameter);
        }
    }
}
