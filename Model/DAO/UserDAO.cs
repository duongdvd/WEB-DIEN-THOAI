using Model.EF;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace Model.DAO
{
    public class UserDAO
    {
        private ShopDBContext db = null;

        public UserDAO()
        {
            db = new ShopDBContext();
        }

        public User GetById(string userName)
        {
            return db.Users.SingleOrDefault(x => x.Name == userName);
        }

        public int Insert(User entity)
        {
            db.Users.Add(entity);
            db.SaveChanges();
            return entity.ID;
        }

        public User ViewDetail(int id)
        {
            return db.Users.Find(id);
        }

        public bool Update(User entity)
        {
            try
            {
                var user = db.Users.Find(entity.ID);
                user.Name = entity.Name;
                if (!string.IsNullOrEmpty(entity.Pass))
                {
                    user.Pass = entity.Pass;
                }
                user.HoTen = entity.HoTen;
                user.Address = entity.Address;
                user.Email = entity.Email;
                //user.NguoiUpdate = entity.NguoiUpdate;
                //user.NgayUpdate = DateTime.Now;
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool Delete(int id)
        {
            try
            {
                var user = db.Users.Find(id);
                user.TrangThai = false;

                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool Login(string userName, string passWord)
        {
            var result = db.Users.SingleOrDefault(x => x.Name == userName && x.Pass == passWord);
            if (result != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static string TachDau(string s)
        {
            Regex regex = new Regex("\\p{IsCombiningDiacriticalMarks}+");
            string temp = s.Normalize(NormalizationForm.FormD);
            return regex.Replace(temp, String.Empty).Replace('\u0111', 'd').Replace('\u0110', 'D');
        }

        public IEnumerable<User> ListAllPaging(string searchString, int page, int pageSize)
        {
            IQueryable<User> model = db.Users.Where(x => x.TrangThai == true);
            if (!string.IsNullOrEmpty(searchString))
            {
                model = model.Where(x => x.Name.Contains(searchString) || x.HoTen.Contains(searchString));
            }

            return model.OrderByDescending(x => x.NgayTao).ToPagedList(page, pageSize);
        }
    }
}