using Elos.Procedimentos.BLL;
using Elos.Procedimentos.Model;
using ELOS.Framework.BLL;
using ELOS.Framework.BLL.Filters;
using ELOS.Framework.Model;
using ELOS.Framework.Util;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Elos.Procedimentos.Web.Controllers
{
    public class DocumentoController : ElosControllerBase
    {

        public Documento ssParametros
        {
            get { return Session["ssDocumentoParametro"] as Documento; }
            set { Session["ssDocumentoParametro"] = value; }
        }


        [PermissaoActionFilter(PermissaoTipo = 2, ValPermissao = 1)]
        public ActionResult Index()
        {
            LoadIndex();
            return View();
        }

        private void LoadIndex()
        {
            LoadPermissao();

            ViewBag.Categoria = ssParametros != null ? string.IsNullOrEmpty(ssParametros.Titulo) ? ssParametros.Categoria.Codigo.ToString() : ssParametros.Titulo : string.Empty;


            ViewBag.Buscar = ssParametros != null ? ssParametros.Titulo : string.Empty;

        }

        [PermissaoActionFilter(PermissaoTipo = 2, ValPermissao = 2)]
        public ActionResult Create()
        {
            LoadDados();

            ViewBag.IsCreate = "true";
            return View(ssParametros);
        }


        [PermissaoActionFilter(PermissaoTipo = 2, ValPermissao = 2)]
        public ActionResult Edit(int Documento)
        {

            Documento objReturn = new Documento();

            objReturn.Usuario = Util.UsuarioLogado;
            objReturn.Codigo = Documento;

            objReturn = DocumentoBLL.Select(objReturn);


            if (objReturn.Codigo < 1)
            {
                LoadIndex();
                return View("Index");
            }
            else
            {
                LoadDados();
                ViewBag.IsCreate = "false";
                return View("Create", objReturn);
            }


        }


        [HttpPost]
        [PermissaoActionFilter(PermissaoTipo = 1, ValPermissao = 2)]
        public ActionResult Upload(Documento objParametro, HttpPostedFileBase file)
        {
            int IsSave = 0;
            int objReturn = 0;
            string fullPath = string.Empty;


            if (file != null)
            {

                try
                {
                    string fileName = string.Format("{0:ddMMyyyyHHmmss}_{1}", DateTime.Now, file.FileName);

                    objParametro.Caminho = ConfigurationManager.AppSettings["DocumentosPath"];

                    objParametro.Nome = fileName;

                    fullPath = Path.Combine(objParametro.Caminho, objParametro.Nome);

                    file.SaveAs(fullPath);

                    IsSave = 1;

                    objParametro.IsUpload = 1;


                }
                catch (Exception)
                {


                }
            }
            else
            {
                objParametro.IsUpload = 0;
                IsSave = 1;
            }

            if (IsSave > 0)
            {

                objParametro.Usuario = Util.UsuarioLogado;

                objReturn = DocumentoBLL.Insert(objParametro);


                if (objReturn < 1)
                {
                    if (file != null)
                    {
                        System.IO.File.Delete(fullPath);
                    }

                }


            }

            ViewBag.objReturn = objReturn;
            LoadDados();

            if (objParametro.Codigo != 0)
            {
                ViewBag.IsCreate = "false";

                objParametro = DocumentoBLL.Select(objParametro);

            }
            else
            {
                ViewBag.IsCreate = "true";
            }

            return View("Create", objParametro);
        }


        [HttpPost]
        [PermissaoActionFilter(PermissaoTipo = 3, ValPermissao = 1)]
        public PartialViewResult GetDocumentos(Documento objParametro)
        {

            ssParametros = objParametro;

            objParametro.Usuario = Util.UsuarioLogado;

            objParametro.IsPublicar = (Util.PermissaoAtual.Valor & 15) == 15 ? -1 : 1;

            return PartialView("_Grid", DocumentoBLL.List(objParametro));
        }


       



        [HttpPost]
        [PermissaoActionFilter(PermissaoTipo = 3, ValPermissao = 1)]
        public PartialViewResult Buscar(Documento objParametro)
        {

            ssParametros = objParametro;

            objParametro.Usuario = Util.UsuarioLogado;

            objParametro.IsPublicar = (Util.PermissaoAtual.Valor & 15) == 15 ? -1 : 1;

            return PartialView("_Grid", DocumentoBLL.ListByBuscar(objParametro));
        }



        [HttpPost]
        [PermissaoActionFilter(PermissaoTipo = 3, ValPermissao = 1)]
        public PartialViewResult GetHistorico(Documento objParametro)
        {

            objParametro.Usuario = Util.UsuarioLogado;

            return PartialView("_GridModal", DocumentoBLL.Select(objParametro));
        }


        private void LoadDados()
        {

            List<Tipo> listPublicar = new List<Tipo> { new Tipo { Codigo = 0, Nome = "Não" }, new Tipo { Codigo = 1, Nome = "Sim" } };

            ViewBag.Perfil = new MultiSelectList(PerfilBLL.ListEbox(), "Codigo", "Nome");

            ViewBag.TipoDoc = new SelectList(DocumentoBLL.ListTipo(), "Codigo", "Nome");

            ViewBag.Publicar = new SelectList(listPublicar, "Codigo", "Nome");

            LoadPermissao();

        }

        private void LoadPermissao()
        {
            ViewBag.ControleAcesso = (Util.PermissaoAtual.Valor & 15) == 15;
        }

        [PermissaoActionFilter(PermissaoTipo = 4, ValPermissao = 1)]
        public JsonResult GetTags(string id)
        {
            return Json(TagBLL.List(new Tag { Nome = id }), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [PermissaoActionFilter(PermissaoTipo = 4, ValPermissao = 1)]
        public JsonResult GetCategorias()
        {

            List<string> listPlugins = new List<string>();

            Categoria catPublicar = new Categoria();

            listPlugins.Add("search");


            if ((Util.PermissaoAtual.Valor & 15) == 15)
            {

                listPlugins.Add("dnd");
            }
            else
            {
                catPublicar.IsPublicar = 1;
            }


            return Json(new { Categorias = CategoriaBLL.List(catPublicar), Plugins = listPlugins });
        }

        [HttpPost]
        [PermissaoActionFilter(PermissaoTipo = 4, ValPermissao = 2)]
        public JsonResult CriarCategoria(CategoriaViewModel objParametro)
        {
            return Json(new { Result = CategoriaBLL.InsertUpdate(objParametro) });
        }

        [HttpPost]
        [PermissaoActionFilter(PermissaoTipo = 4, ValPermissao = 4)]
        public JsonResult PublicarCategoria(CategoriaViewModel objParametro)
        {
            return Json(new { Result = CategoriaBLL.StatusUpdate(objParametro) });
        }

        [HttpPost]
        [PermissaoActionFilter(PermissaoTipo = 4, ValPermissao = 8)]
        public JsonResult DeletarCategoria(Categoria objParametro)
        {
            return Json(new { Result = CategoriaBLL.Delete(objParametro) });
        }

        [PermissaoActionFilter(PermissaoTipo = 2, ValPermissao = 1)]
        public ActionResult DownloadFile(int Documento)
        {

            Documento obj = new Documento();


            obj.Codigo = Documento;

            obj.Usuario = Util.UsuarioLogado;

            DocumentoArquivo objReturn = DocumentoBLL.SelectArquivo(obj);


            if (objReturn.Codigo < 1)
            {
                LoadIndex();
                return View("Index");
            }
            else
            {
                DocumentoBLL.InsertLog(obj);


                return File(Path.Combine(objReturn.Caminho, objReturn.Nome), MimeMapping.GetMimeMapping(objReturn.Nome), objReturn.Nome);
            }


        }

        
        [HttpPost]
        [PermissaoActionFilter(PermissaoTipo = 3, ValPermissao = 4)]
        public PartialViewResult AtualizarArquivo(Documento objParametro)
        {

            objParametro.Usuario = Util.UsuarioLogado;

            DocumentoBLL.UpdateArquivo(objParametro);


            objParametro = DocumentoBLL.Select(objParametro);

            return PartialView("_GridArquivos", objParametro);
        }


        [HttpPost]
        [PermissaoActionFilter(PermissaoTipo = 4, ValPermissao = 8)]
        public JsonResult DeletarDocumento(Documento objParametro)
        {
            return Json(new { Result = DocumentoBLL.Delete(objParametro), Categoria = ssParametros != null ? string.IsNullOrEmpty(ssParametros.Titulo) ? ssParametros.Categoria.Codigo.ToString() : ssParametros.Titulo : string.Empty });
        }


        [HttpPost]
        [PermissaoActionFilter(PermissaoTipo = 4, ValPermissao = 4)]
        public JsonResult PublicarDocumento(Documento objParametro)
        {
            return Json(new { Result = DocumentoBLL.StatusUpdate(objParametro) });
        }


    }
}
