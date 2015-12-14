using Elos.Procedimentos.Model;
using ELOS.Framework.DAO;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Elos.Procedimentos.DAO
{
    public class CategoriaDAO
    {

        public static List<CategoriaViewModel> List(Categoria objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();
            List<CategoriaViewModel> objReturn = new List<CategoriaViewModel>();

            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_Categoria_LST") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    db.AddInParameter(dbCommand, "@ind_Publicar", SqlDbType.Int, objParametro.IsPublicar.HasValue ? objParametro.IsPublicar.Value : Convert.DBNull);


                    using (DataSet dsRetorno = db.ExecuteDataSet(dbCommand))
                    {
                        foreach (DataRow dr in dsRetorno.Tables[0].Rows)
                        {
                            objReturn.Add(FromDataRow(dr));
                        }


                    }


                }
                catch { }
                finally
                {
                    connection.Close();
                }
            }
            return objReturn;

        }

        public static int InsertUpdate(CategoriaViewModel objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();
            int objReturn = 0;

            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_Categoria_INS_UPD") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    db.AddInParameter(dbCommand, "@cod_Categoria", SqlDbType.Int, Convert.ToInt32(objParametro.id));
                    db.AddInParameter(dbCommand, "@cod_Categoria_Pai", SqlDbType.Int, objParametro.parent != "#" ? Convert.ToInt32(objParametro.parent) : Convert.DBNull);
                    db.AddInParameter(dbCommand, "@nom_Categoria", SqlDbType.VarChar, !string.IsNullOrEmpty(objParametro.text) ? objParametro.text : Convert.DBNull);
                    db.AddInParameter(dbCommand, "@ind_Ordem", SqlDbType.Int,  objParametro.position );


                    objReturn = Convert.ToInt32(db.ExecuteScalar(dbCommand));


                }
                catch { }
                finally
                {
                    connection.Close();
                }
            }
            return objReturn;

        }
        
        private static CategoriaViewModel FromDataRow(DataRow dr)
        {

            CategoriaViewModel obj = new CategoriaViewModel();


            obj.id = Convert.ToString(dr["cod_Categoria"]);

            obj.parent = Convert.IsDBNull(dr["cod_Categoria_Pai"]) ? "#" : Convert.ToString(dr["cod_Categoria_Pai"]);

            obj.text = Convert.ToString(dr["nom_Categoria"]);

            obj.icon = Convert.ToBoolean(dr["ind_Publicar"]) ? "glyphicon glyphicon-folder-open text-success" : "glyphicon glyphicon-folder-close text-danger";

            obj.state = new CategoriaStateViewModel();

           // obj.state.disabled = true;

            return obj;
        }

        public static bool StatusUpdate(CategoriaViewModel objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();
            bool objReturn = false;

            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_CategoriaStatus_UPD") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    db.AddInParameter(dbCommand, "@cod_Categoria", SqlDbType.Int, Convert.ToInt32(objParametro.id));



                    objReturn = Convert.ToBoolean(db.ExecuteScalar(dbCommand));


                }
                catch { }
                finally
                {
                    connection.Close();
                }
            }
            return objReturn;

        }
        
        public static int Delete(Categoria objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();
            int objReturn = 0;

            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_Categoria_DEL") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    db.AddInParameter(dbCommand, "@cod_Categoria", SqlDbType.Int, objParametro.Codigo);
                    //db.AddInParameter(dbCommand, "@cod_Categoria_Pai", SqlDbType.Int, objParametro.parent != "#" ? Convert.ToInt32(objParametro.parent) : Convert.DBNull);
                    //db.AddInParameter(dbCommand, "@nom_Categoria", SqlDbType.VarChar, !string.IsNullOrEmpty(objParametro.text) ? objParametro.text : Convert.DBNull);
                    //db.AddInParameter(dbCommand, "@ind_Ordem", SqlDbType.Int, objParametro.position);


                    objReturn = Convert.ToInt32(db.ExecuteScalar(dbCommand));


                }
                catch { }
                finally
                {
                    connection.Close();
                }
            }
            return objReturn;

        }


    }
}
