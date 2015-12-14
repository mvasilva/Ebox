using Elos.Procedimentos.BLL;
using Elos.Procedimentos.Model;
using ELOS.Framework.BLL.Filters;
using ELOS.Framework.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Elos.Procedimentos.Web.Controllers
{
    public class HomeController : ElosControllerBase
    {
        //
        // GET: /Home/

        [PermissaoActionFilter(PermissaoTipo = 2, ValPermissao = 1)]
        public ActionResult Index()
        {
            LoadPermissao();
            return View();
        }


        private void LoadPermissao()
        {
            ViewBag.ControleAcesso = (Util.PermissaoAtual.Valor & 15) == 15;
        }


        [HttpPost]
        [PermissaoActionFilter(PermissaoTipo = 3, ValPermissao = 1)]
        public PartialViewResult GetDocumentosAtualizados()
        {

            Documento objParametro = new Documento();


            objParametro.Usuario = Util.UsuarioLogado;

            objParametro.IsPublicar = (Util.PermissaoAtual.Valor & 15) == 15 ? -1 : 1;

            return PartialView("_GridAtualizados", DocumentoBLL.ListAtualizados(objParametro));
        }


        [HttpPost]
        [PermissaoActionFilter(PermissaoTipo = 3, ValPermissao = 1)]
        public PartialViewResult GetDocumentosDownload()
        {

            Documento objParametro = new Documento();


            objParametro.Usuario = Util.UsuarioLogado;

            objParametro.IsPublicar = (Util.PermissaoAtual.Valor & 15) == 15 ? -1 : 1;

            return PartialView("_GridDownloads", DocumentoBLL.ListDownload(objParametro));
        }


    }
}
