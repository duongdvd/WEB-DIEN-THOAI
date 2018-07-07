using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PagedList;
namespace Model.DAO
{
    public class SlideDAO
    {

        ShopDBContext db = null;
        public SlideDAO()
        {
            db = new ShopDBContext();
        }

        public List<Slide> ListAll()
        {
            List<Slide> sl = db.Slides.Where(x => x.Trangthai == true).OrderBy(y => y.STT).ToList();
            return sl;
        }

        public IEnumerable<Slide> ListAllPaging(string searchString, int page, int pageSize)
        {
            IQueryable<Slide> model = db.Slides.Where(x => x.Trangthai == true);
            if (!string.IsNullOrEmpty(searchString))
            {
                model = model.Where(x => x.Name.Contains(searchString));
            }

            return model.OrderBy(x => x.STT).ToPagedList(page, pageSize);
        }

        public int Create(Slide slide)
        {
            db.Slides.Add(slide);
            db.SaveChanges();

            return slide.ID;
        }

        public bool Delete(int id)
        {
            try
            {
                var user = db.Slides.Find(id);
                user.Trangthai = false;

                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        public Slide GetByID(long id)
        {
            return db.Slides.Find(id);
        }


        public bool Edit(Slide entity)
        {
            try
            {
                var user = db.Slides.Find(entity.ID);
                user.Name = entity.Name;
                user.Image = entity.Image;
                user.url = entity.url;
                user.STT = entity.STT;
                user.Trangthai = entity.Trangthai;
                user.NoiDung = entity.NoiDung;
                user.btn = entity.btn;

             
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

    }
}
