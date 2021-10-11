using MovieReservationAPI.DataSources;
using MovieReservationAPI.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace MovieReservationAPI.Controllers
{
    public class CinemasController : ApiController
    {
        [AcceptVerbs("GET")]
        [Route("cinemas")]
        public IEnumerable<sp_getcinemas_Result> GetCinemas(int cinema_id = 0)
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                return _entity.sp_getcinemas(cinema_id).ToList();
            }
        }

        [AcceptVerbs("GET")]
        [Route("cinemas/check")]
        public bool CheckCinema(int cinema_id = 0, string description = "")
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                // Checks if Description conflicts with other Cinemas
                var _checkSchedule = _entity.sp_checkcinema((byte)cinema_id, description).FirstOrDefault();

                return _checkSchedule == null;
            }
        }

        [AcceptVerbs("POST")]
        [Route("cinemas/save")]
        public int SaveCinema(SaveCinema param)
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                param.description = HttpUtility.UrlDecode(param.description);

                var _cinema = _entity.sp_savecinema(param.cinema_id, param.description, param.seats, param.default_price).FirstOrDefault();

                int _cinema_id = (int)_cinema.cinema_id;
                int _row = _cinema.row == 0 ? 1 : (int)_cinema.row;
                int _col = (int)_cinema.col;
                int _seats_per_row = 5;

                int _seats = param.seats - ((_row - 1) * _seats_per_row) - _col;

                for (int i = 0; i < _seats; i++)
                {
                    if (_col == _seats_per_row)
                    {
                        _row++;
                        _col = 1;
                    }
                    else
                    {
                        _col++;
                    }

                    _entity.sp_saveseat(0, (byte)_cinema_id, (byte)_row, (byte)_col);
                }

                return _cinema_id;
            }
        }
    }
}
