using ELOS.Framework.Util;
using ELOS.Framework.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Elos.Procedimentos.Web.Controllers
{
    public class NotificacaoController : ElosControllerBase
    {
        //
        // GET: /Notificacao/

        public ActionResult Index()
        {
            LoadDaods();
            return View();
        }
        private void LoadDaods()
        {
            ViewBag.Perfil = new MultiSelectList(new List<Tipo> { new Tipo { Codigo = 1, Nome = "TFN User" }, new Tipo { Codigo = 2, Nome = "CDT User" } }, "Codigo", "Nome");
        }

    }
}
