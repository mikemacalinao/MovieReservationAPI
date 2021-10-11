using MovieReservationAPI.DataSources;
using MovieReservationAPI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace MovieReservationAPI.Controllers
{
    public class SchedulesController : ApiController
    {
        [AcceptVerbs("GET")]
        [Route("schedules")]
        public IEnumerable<sp_getschedules_Result> GetSchedules(int schedule_id = 0)
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                return _entity.sp_getschedules(schedule_id).ToList();
            }
        }

        [AcceptVerbs("GET")]
        [Route("schedules/check")]
        public bool CheckSchedule(int schedule_id = 0, int cinema_id = 0, string date_time = "")
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                DateTime _date_time = string.IsNullOrEmpty(date_time) ? Convert.ToDateTime("1/1/1900") : Convert.ToDateTime(date_time);

                // Checks if Date and Time conflicts with other schedules
                var _checkSchedule = _entity.sp_checkschedule(schedule_id, (byte)cinema_id, _date_time).FirstOrDefault();

                return _checkSchedule == null;
            }
        }

        [AcceptVerbs("GET")]
        [Route("schedules/checkschedulecount")]
        public bool CheckScheduleCount(int schedule_id = 0, int cinema_id = 0, string date_time = "")
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                DateTime _date_time = string.IsNullOrEmpty(date_time) ? Convert.ToDateTime("1/1/1900") : Convert.ToDateTime(date_time);

                // 5 schedule per cinema/day
                var _checkSchedule = _entity.sp_checkschedulecount(schedule_id, (byte)cinema_id, _date_time).FirstOrDefault();

                return _checkSchedule < 5;
            }
        }

        [AcceptVerbs("POST")]
        [Route("schedules/save")]
        public int SaveSchedule(SaveSchedule param)
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                return (int)_entity.sp_saveschedule(param.schedule_id, param.movie_id, param.cinema_id,param.price, param.date_time).FirstOrDefault();
            }
        }

        [AcceptVerbs("GET")]
        [Route("schedules/history")]
        public IEnumerable<sp_gethistory_Result> GetScheduleHistory(int schedule_id = 0)
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                // Update Reserved Seats to Used if Schedule already elapsed
                _entity.sp_updateusedreservation(schedule_id);

                var _history = _entity.sp_gethistory(schedule_id).ToList();
                var _historyseats = _entity.sp_gethistoryseats(schedule_id).ToList();
                char[] letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray();

                foreach (sp_gethistory_Result history in _history)
                {
                    var _historyseat = _historyseats.Where(x => x.reservation_id == history.reservation_id).ToList();

                    foreach (sp_gethistoryseats_Result historyseat in _historyseat)
                    {
                        string _seat = letters[historyseat.row - 1].ToString() + historyseat.col;
                        history.seats += _seat + ", ";
                    }

                    history.seats = history.seats.Substring(0, history.seats.Length - 2);
                }

                return _history;
            }
        }
    }
}