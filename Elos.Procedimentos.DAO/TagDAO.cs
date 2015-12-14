using Elos.Procedimentos.Model;
using ELOS.Framework.DAO;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Elos.Procedimentos.DAO
{
   public class TagDAO
    {

       public static List<Tag> List(Tag objParametro)
       {
           SqlDatabase db = ConfigDAO.CreateDB();
           IDataReader dr = null;

           List<Tag> objReturn = new List<Tag>();

           using (DbConnection connection = db.CreateConnection())
           {
               connection.Open();
               try
               {
                   DbCommand dbCommand = db.GetStoredProcCommand("PR_BOX_Tag_LST");
                   dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;
                   db.AddInParameter(dbCommand, "@nom_Tag", SqlDbType.VarChar, objParametro.Nome);
                   


                   dr = db.ExecuteReader(dbCommand);

                   while (dr.Read())
                   {

                       Tag obj = new Tag();

                       obj.Codigo = dr.GetInt32(0);
                       
                       obj.Nome = dr.GetString(1);

                       objReturn.Add(obj);
                       
                   }
                   

               }
               catch
               {

                 

               }
               finally
               {
                   if (dr != null && !dr.IsClosed)
                   {
                       dr.Close();
                       dr.Dispose();
                   }

                   connection.Close();
               }
           }
           return objReturn;
       }

    }
}
