using Elos.Procedimentos.DAO;
using Elos.Procedimentos.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Elos.Procedimentos.BLL
{
    public class CategoriaBLL
    {

        public static List<CategoriaViewModel> List(Categoria objParametro)
        {
            return CategoriaDAO.List(objParametro);
        }

        public static int InsertUpdate(CategoriaViewModel objParametro)
        {
            return CategoriaDAO.InsertUpdate(objParametro);
        }

        public static bool StatusUpdate(CategoriaViewModel objParametro)
        {
            return CategoriaDAO.StatusUpdate(objParametro);
        }


        public static int Delete(Categoria objParametro)
        {
            return CategoriaDAO.Delete(objParametro);
        }

    }
}
