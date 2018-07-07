using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Model.EF;
using Model.DAO;
using Webbbbbbbbbbb.Common;


namespace Webbbbbbbbbbb.Areas.Admin.Controllers
{
    public class UserController : BaseController
    {
        // GET: Admin/User
        public ActionResult Index(string searchString, int page = 1, int pageSize = 5)
        {
            var dao = new UserDAO();
            var model = dao.ListAllPaging(searchString, page, pageSize);

            ViewBag.SearchString = searchString;

            return View(model);
        }

        public ActionResult Edit(int id)
        {
            var user = new UserDAO().ViewDetail(id);
            return View(user);
        }
        [HttpPost]
        public ActionResult Edit(User user)
        {
            if (ModelState.IsValid)
            {
                var dao = new UserDAO();
                if (!string.IsNullOrEmpty(user.Pass))
                {
                    var encryptedMd5Pas = MHMD5.MD5Hash(user.Pass);
                    user.Pass = encryptedMd5Pas;
                }

  
                var result = dao.Update(user);
                if (result)
                {
                    SetAlert("Sửa user thành công", "success");
                    return RedirectToAction("Index", "User");
                }
                else
                {
                    ModelState.AddModelError("", "Cập nhật user không thành công");
                }
            }
            return View("Index");
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpDelete]
     
        public ActionResult Delete(int id)
        {
            new UserDAO().Delete(id);
            SetAlert("Xóa thành công", "success");
            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult Create(User user)
        {
            if (ModelState.IsValid)
            {
                var dao = new UserDAO();

                var Md5Pas = MHMD5.MD5Hash(user.Pass);
                user.Pass = Md5Pas;

                long id = dao.Insert(user);
                if (id > 0)
                {
                    SetAlert("Thêm user thành công", "success");
                    return RedirectToAction("Index", "User");
                }
                else
                {
                    ModelState.AddModelError("", "Thêm user không thành công");
                }
            }
            return View("Index");
        }

    }
}