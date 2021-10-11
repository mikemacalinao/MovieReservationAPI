using MovieReservationAPI.DataSources;
using MovieReservationAPI.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace MovieReservationAPI.Controllers
{
    public class MoviesController : ApiController
    {
        [AcceptVerbs("GET")]
        [Route("movies")]
        public IEnumerable<sp_getmovies_Result> GetMovies(int movie_id = 0)
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                return _entity.sp_getmovies(movie_id).ToList();
            }
        }

        [AcceptVerbs("GET")]
        [Route("movies/check")]
        public bool CheckMovie(int movie_id = 0, string title = "", string description = "")
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                // Checks if Title and Description conflicts with other Movies
                var _checkSchedule = _entity.sp_checkmovie(movie_id, title, description).FirstOrDefault();

                return _checkSchedule == null;
            }
        }

        [AcceptVerbs("GET")]
        [Route("movies/newid")]
        public int GetMovieNewID()
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                return (int)_entity.sp_getnewmovieid().FirstOrDefault();
            }
        }

        [AcceptVerbs("POST")]
        [Route("movies/save")]
        public int SaveMovie(SaveMovie param)
        {
            using (dbmoviereservationEntities _entity = new dbmoviereservationEntities())
            {
                param.title = HttpUtility.UrlDecode(param.title);
                param.description = HttpUtility.UrlDecode(param.description);

                return (int)_entity.sp_savemovie(param.movie_id, param.title, param.description, param.imgtype, param.default_price).FirstOrDefault();
            }
        }
    }
}