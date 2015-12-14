using Elos.Procedimentos.DAO;
using Elos.Procedimentos.Model;
using ELOS.Framework.BLL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Elos.Procedimentos.BLL
{
    public class DocumentoBLL
    {

        public static List<DocumentoTipo> ListTipo()
        {
            return DocumentoDAO.ListTipo();
        }

        public static List<Documento> List(Documento objParametro)
        {
            return DocumentoDAO.List(objParametro);
        }
        public static List<Documento> ListByBuscar(Documento objParametro)
        {
            return DocumentoDAO.ListByBuscar(objParametro);
        }

        public static List<Documento> ListAtualizados(Documento objParametro)
        {
            return DocumentoDAO.ListAtualizados(objParametro);
        }

        public static List<Documento> ListDownload(Documento objParametro)
        {

            return DocumentoDAO.ListDownload(objParametro);
        }

        public static int Insert(Documento objParametro)
        {

            objParametro.PerfilStr = string.Join<int>(",", objParametro.PerfilSelected.Count > 0 ? objParametro.PerfilSelected : PerfilBLL.ListEbox().Select(p => p.Codigo));


            objParametro.Tipo = DocumentoBLL.SelectTipo(Path.GetExtension(objParametro.Nome));

            return DocumentoDAO.Insert(objParametro);
        }
        
        public static Documento Select(Documento objParametro)
        {

            objParametro = DocumentoDAO.Select(objParametro);


            objParametro.PerfilStr = string.Join<int>(",", objParametro.PerfilSelected);

            objParametro.Tags = string.Join<string>(",", from t in objParametro.TagsList select t.Nome);


            return objParametro;
        }

        public static DocumentoArquivo SelectArquivo(Documento objParametro)
        {
            return DocumentoDAO.SelectArquivo(objParametro);
        }


        public static void UpdateArquivo(Documento objParametro)
        {
            DocumentoDAO.UpdateArquivo(objParametro);
        }


        public static DocumentoTipo SelectTipo(string objParametro)
        {


            return DocumentoDAO.SelectTipo(objParametro);
        }


        public static int Delete(Documento objParametro)
        {
            return DocumentoDAO.Delete(objParametro);
        }

        public static bool StatusUpdate(Documento objParametro)
        {
            return DocumentoDAO.StatusUpdate(objParametro);
        }

        public static void InsertLog(Documento objParametro)
        {
            DocumentoDAO.InsertLog(objParametro);
        }
    }
}
