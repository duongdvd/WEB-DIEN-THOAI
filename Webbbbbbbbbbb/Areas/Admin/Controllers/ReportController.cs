using Model.DAO;
using Model.EF;
using Model.ModelView;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Xml.Linq;
using Webbbbbbbbbbb.Common;

namespace Webbbbbbbbbbb.Areas.Admin.Controllers
{
    
    public class ReportController : BaseController
    {
        
        // GET: Admin/Report

        public ActionResult Index(int page = 1, int pageSize = 10)
        {
         
     
            var dao = new ReportDAO();
            var model = dao.ListAllPaging("", page, pageSize);
            return View(model);
    

        }

        [HttpPost]
        public ActionResult Index(String searchString, int page = 1, int pageSize = 10)
        {


            var dao = new ReportDAO();
            var model = dao.ListAllPaging(searchString, page, pageSize);
            return View(model);


        }


        public ActionResult ThongKeNam(int page = 1, int pageSize = 12)
        {


            var dao = new ReportDAO();
            var model = dao.ThongKeNam("");
            return View(model);


        }

        [HttpPost]
        public ActionResult ThongKeNam(String searchString, int page = 1, int pageSize = 12)
        {


            var dao = new ReportDAO();
            var model = dao.ThongKeNam(searchString);
            return View(model);


        }


    }
}