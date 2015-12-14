using ELOS.Framework.BLL;
using ELOS.Framework.Model;
using ELOS.Framework.Util;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Elos.Procedimentos.Web.Controllers
{
    public class PublicController : ElosControllerBase
    {
        public ActionResult Index()
        {
            string strCookie = SingleSignOn.GetCookie();
            string[] strDadosLogin = null;
            if (!string.IsNullOrEmpty(strCookie))
            {
                strDadosLogin = strCookie.Split('|');
            }

            return strDadosLogin != null ? Login(new Usuario { Email = strDadosLogin[0], Senha = strDadosLogin[1], IsEncripty = true }) : View();
        }

        [HttpPost]
        public ActionResult Login(Usuario objUsuario)
        {
            try
            {
                bool IsPermanecerLogado = objUsuario.IsPermanecerLogado;


                if (!objUsuario.IsEncripty)
                {
                    objUsuario.Senha = objUsuario.Senha.GetHashSHA1();
                }

                if (IsPermanecerLogado)
                {
                    SingleSignOn.SetCookie(string.Join("|", objUsuario.Email, objUsuario.Senha));
                }

                objUsuario = UsuarioBLL.LoginELOS(objUsuario);

                if (objUsuario.Codigo == -1)
                {
                    objUsuario.Senha = string.Empty;

                    return View("Index", objUsuario);
                }

                Util.UsuarioLogado = objUsuario;

                return RedirectToAction("Index", "Home");

            }
            catch
            {
                objUsuario.Codigo = -1;

                return View("Index", objUsuario);
            }
        }

        //public ActionResult Index()
        //{
        //    string strCookie = Util.GetCookie();
        //    string[] strDadosLogin = null;
        //    if (!string.IsNullOrEmpty(strCookie))
        //    {
        //        strDadosLogin = strCookie.Split('|');
        //    }

        //    return Util.UsuarioLogado != null ? RedirectToAction("Index", "Home") : strDadosLogin != null ? Login(new Usuario { Email = strDadosLogin[0], Senha = strDadosLogin[1], IsEncripty = true }) : View();
        //}

        //[HttpPost]
        //public ActionResult Login(Usuario objUsuario)
        //{
        //    try
        //    {
        //        bool IsPermanecerLogado = objUsuario.IsPermanecerLogado;


        //        if (!objUsuario.IsEncripty)
        //        {
        //            objUsuario.Senha = objUsuario.Senha.GetHashSHA1();
        //        }

        //        if (IsPermanecerLogado)
        //        {
        //            Util.SetCookie(string.Join("|", objUsuario.Email, objUsuario.Senha));
        //        }

        //        objUsuario = UsuarioBLL.Login(objUsuario);

        //        if (objUsuario.Codigo == -1)
        //        {
        //            objUsuario.Senha = string.Empty;

        //            return View("Index", objUsuario);
        //        }



        //        Util.UsuarioLogado = objUsuario;

        //        return RedirectToAction("Index", "Home");

        //    }
        //    catch
        //    {
        //        objUsuario.Codigo = -1;

        //        return View("Index", objUsuario);
        //    }
        //}



        public ActionResult LogOut()
        {

            return Convert.ToBoolean(ConfigurationManager.AppSettings["debug"]) ? new RedirectResult(ConfigurationManager.AppSettings["debugLoginPath"]) : SingleSignOn.LogOut();
        }

    }
}
