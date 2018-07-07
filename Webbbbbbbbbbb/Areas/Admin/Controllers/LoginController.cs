using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


using Model.DAO;
using Webbbbbbbbbbb.Areas.Admin.Models;
using Webbbbbbbbbbb.Common;
namespace Webbbbbbbbbbb.Areas.Admin.Controllers
{
    public class LoginController : Controller
    {
        

        // GET: Admin/Login
        public ActionResult Index()
        {
            Session.Remove("USER_SESSION");
            return View();
        }
        public ActionResult Login(LoginModel model)
        {
           
            if (ModelState.IsValid)
            {
                var user = new UserDAO();
                var kq = user.Login(model.UserName,MHMD5.MD5Hash(model.Password));
                if (kq)
                {
                    //var name = user.GetById(model.UserName);
                     var name = user.GetById(model.UserName);
                    var nameSession = new UserLogin();
                    nameSession.UserName = name.Name;
                    nameSession.UserID = name.ID;

                    Session.Add(CommonConstants.USER_SESSION, nameSession);
                    return RedirectToAction("Index", "Home");


                }
                else
                {

                    ModelState.AddModelError("", "Đăng nhập thất bại");
                }

            }
            
                return View("Index");
            

        }
    }
}