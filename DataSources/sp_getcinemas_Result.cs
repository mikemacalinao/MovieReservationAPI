//------------------------------------------------------------------------------
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
    
    public partial class sp_getcinemas_Result
    {
        public int cinema_id { get; set; }
        public string description { get; set; }
        public int seat_count { get; set; }
        public decimal default_price { get; set; }
        public Nullable<int> schedule_count { get; set; }
        public int reserved { get; set; }
    }
}