using MovieReservationAPI.DataSources;
using MovieReservationAPI.Models;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace MovieReservationAPI.Controllers
{
    public class ReservationsController : ApiController
    {
        [AcceptVerbs("GET")]
        [Route("nowshowing")]
        public IEnumerable<sp_getnowshowing_Result> GetNowShowing()
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                return _entity.sp_getnowshowing().ToList();
            }
        }

        [AcceptVerbs("GET")]
        [Route("reservations/schedules")]
        public IEnumerable<sp_getcinemaschedules_Result> GetCinemaSchedules(int cinema_id = 0)
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                return _entity.sp_getcinemaschedules(cinema_id).ToList();
            }
        }

        [AcceptVerbs("GET")]
        [Route("reservations/seats")]
        public IEnumerable<sp_getcinemaseats_Result> GetCinemaSeats(int schedule_id = 0)
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                return _entity.sp_getcinemaseats(schedule_id).ToList();
            }
        }

        [AcceptVerbs("POST")]
        [Route("reservations/save")]
        public int SaveReservation(SaveReservation param)
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                List<ReservationDetail> reservationDetails = JsonConvert.DeserializeObject<List<ReservationDetail>>(param.reservation_details);

                int reservation_id = (int)_entity.sp_savereservation(param.schedule_id, HttpUtility.UrlDecode(param.customer_name), param.total).FirstOrDefault();

                foreach (ReservationDetail reservationDetail in reservationDetails)
                {
                    _entity.sp_savereservationdetail(reservation_id, reservationDetail.seat_id, param.schedule_id);
                }

                return reservation_id;
            }
        }

        [AcceptVerbs("POST")]
        [Route("reservations/cancel")]
        public bool CancelReservations(CancelReservations param)
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                List<Reservation> reservations = JsonConvert.DeserializeObject<List<Reservation>>(param.cancel_reservation);

                foreach (Reservation reservation in reservations)
                {
                    _entity.sp_cancelreservation(reservation.reservation_id);
                }

                return true;
            }
        }

        [AcceptVerbs("POST")]
        [Route("reservations/cancelall")]
        public bool CancelAllReservations(CancelAllReservations param)
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                _entity.sp_cancelallreservation(param.schedule_id);

                return true;
            }
        }
    }
}