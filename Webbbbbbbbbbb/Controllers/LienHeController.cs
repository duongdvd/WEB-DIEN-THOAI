using Common;
using Model.DAO;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Webbbbbbbbbbb.Controllers
{
    public class LienHeController : Controller
    {
        // GET: LienHe
        public ActionResult Index()
        {
            return View();
        }



        [HttpPost]
        public ActionResult Index(string ten, string sdt, string email, string ghichu)
        {
            var dao = new LienHeDAO();
            var model = dao.add(ten, sdt, email, ghichu);



            string content = System.IO.File.ReadAllText(Server.MapPath("~/assets/client/template/phanhoi.html"));

            content = content.Replace("{{CustomerName}}", ten);
            content = content.Replace("{{Phone}}", sdt);
            content = content.Replace("{{Email}}", email);
            content = content.Replace("{{message}}", ghichu);

            var toEmail = ConfigurationManager.AppSettings["ToEmailAddress"].ToString();

            
            new GuiMail().SendMail(toEmail, "Liên hệ từ khách hàng  mobileShop:  ", content);



            return View();
        }
    }
}