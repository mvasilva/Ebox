using Elos.Procedimentos.DAO;
using Elos.Procedimentos.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Elos.Procedimentos.BLL
{
   public class TagBLL
    {

       public static List<Tag> List(Tag objParametro)
       {
           return TagDAO.List(objParametro);
       }

    }
}
