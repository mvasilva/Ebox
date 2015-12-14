using Elos.Procedimentos.Model;
using ELOS.Framework.DAO;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using ELOS.Framework.Model;

namespace Elos.Procedimentos.DAO
{
    public class DocumentoDAO
    {

        public static int Insert(Documento objParametro)
        {
            SqlDatabase db = ConfigDAO.CreateDB();

            int objReturn = 0;

            using (DbConnection connection = db.CreateConnection())
            {
                connection.Open();
                DbTransaction transaction = connection.BeginTransaction();
                try
                {
                    DbCommand dbCommand = db.GetStoredProcCommand("PR_BOX_Documento_INS_UPD");
                    db.AddInParameter(dbCommand, "@cod_Documento", SqlDbType.Int, objParametro.Codigo);
                    db.AddInParameter(dbCommand, "@cod_Categoria", SqlDbType.Int, objParametro.Categoria.Codigo);
                    db.AddInParameter(dbCommand, "@nom_Titulo ", SqlDbType.VarChar, objParametro.Titulo);
                    db.AddInParameter(dbCommand, "@dsc_Documento ", SqlDbType.VarChar, objParametro.Descricao);
                    db.AddInParameter(dbCommand, "@nom_Tag", SqlDbType.VarChar, objParametro.Tags);
                    db.AddInParameter(dbCommand, "@cod_DocumentoTipo", SqlDbType.Int, objParametro.Tipo.Codigo);
                    db.AddInParameter(dbCommand, "@cod_Perfil", SqlDbType.VarChar, objParametro.PerfilStr);
                    db.AddInParameter(dbCommand, "@nom_Arquivo", SqlDbType.VarChar, objParametro.Nome);
                    db.AddInParameter(dbCommand, "@nom_Caminho", SqlDbType.VarChar, objParametro.Caminho);
                    db.AddInParameter(dbCommand, "@ind_Publicar", SqlDbType.Int, objParametro.IsPublicar);
                    db.AddInParameter(dbCommand, "@dsc_Novidade", SqlDbType.VarChar, objParametro.Historico.Novidade);
                    db.AddInParameter(dbCommand, "@cod_Usuario", SqlDbType.Int, objParametro.Usuario.Codigo);
                    db.AddInParameter(dbCommand, "@ind_FileUpload", SqlDbType.Int, objParametro.IsUpload);

                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    using (DataSet dsRetorno = db.ExecuteDataSet(dbCommand, transaction))
                    {
                        foreach (DataRow dr in dsRetorno.Tables[0].Rows)
                        {
                            objReturn = Convert.ToInt32(dr["cod_Status"]);
                        }

                        foreach (DataRow dr in dsRetorno.Tables[1].Rows)
                        {
                            DocumentoArquivo obj = new DocumentoArquivo();

                            obj.Nome = Convert.ToString(dr["nom_Arquivo"]);
                            obj.Caminho = Convert.ToString(dr["nom_Caminho"]);

                            objParametro.DocumentosApagados.Add(obj);
                        }


                    }

                    if (objReturn > 0)
                    {

                        foreach (DocumentoArquivo item in objParametro.DocumentosApagados)
                        {
                            File.Delete(Path.Combine(item.Caminho, item.Nome));
                        }

                        transaction.Commit();
                    }
                    else
                    {
                        transaction.Rollback();
                    }

                }
                catch
                {
                    transaction.Rollback();

                }
                finally
                {
                    connection.Close();
                }
            }
            return objReturn;
        }

        public static List<Documento> List(Documento objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();
            List<Documento> objReturn = new List<Documento>();

            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_Documento_LST") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    db.AddInParameter(dbCommand, "@cod_Categoria", SqlDbType.Int, objParametro.Categoria.Codigo);
                    db.AddInParameter(dbCommand, "@cod_Usuario", SqlDbType.Int, objParametro.Usuario.Codigo);
                    db.AddInParameter(dbCommand, "@ind_Publicar", SqlDbType.Int, objParametro.IsPublicar == -1 ? Convert.DBNull : objParametro.IsPublicar);

                    using (DataSet dsRetorno = db.ExecuteDataSet(dbCommand))
                    {
                        foreach (DataRow dr in dsRetorno.Tables[0].Rows)
                        {
                            objReturn.Add(FromDataRowDocumento(dr));
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


        public static List<Documento> ListByBuscar(Documento objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();
            List<Documento> objReturn = new List<Documento>();

            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_Documento_LST_ByBuscar") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    db.AddInParameter(dbCommand, "@nom_Texto", SqlDbType.VarChar, objParametro.Titulo);
                    db.AddInParameter(dbCommand, "@cod_Usuario", SqlDbType.Int, objParametro.Usuario.Codigo);
                    db.AddInParameter(dbCommand, "@ind_Publicar", SqlDbType.Int, objParametro.IsPublicar == -1 ? Convert.DBNull : objParametro.IsPublicar);

                    using (DataSet dsRetorno = db.ExecuteDataSet(dbCommand))
                    {
                        foreach (DataRow dr in dsRetorno.Tables[0].Rows)
                        {
                            objReturn.Add(FromDataRowDocumento(dr));
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


        public static List<Documento> ListAtualizados(Documento objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();
            List<Documento> objReturn = new List<Documento>();

            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_DocumentoAtualizadoRanking_LST") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;
                    
                    db.AddInParameter(dbCommand, "@cod_Usuario", SqlDbType.Int, objParametro.Usuario.Codigo);
                    db.AddInParameter(dbCommand, "@ind_Publicar", SqlDbType.Int, objParametro.IsPublicar == -1 ? Convert.DBNull : objParametro.IsPublicar);

                    using (DataSet dsRetorno = db.ExecuteDataSet(dbCommand))
                    {
                        foreach (DataRow dr in dsRetorno.Tables[0].Rows)
                        {
                            objReturn.Add(FromDataRowDocumento(dr));
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



        public static List<Documento> ListDownload(Documento objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();
            List<Documento> objReturn = new List<Documento>();

            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_DocumentoDownloadRanking_LST") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    db.AddInParameter(dbCommand, "@cod_Usuario", SqlDbType.Int, objParametro.Usuario.Codigo);
                    db.AddInParameter(dbCommand, "@ind_Publicar", SqlDbType.Int, objParametro.IsPublicar == -1 ? Convert.DBNull : objParametro.IsPublicar);

                    using (DataSet dsRetorno = db.ExecuteDataSet(dbCommand))
                    {
                        foreach (DataRow dr in dsRetorno.Tables[0].Rows)
                        {

                            Documento objAux = FromDataRowDocumento(dr);


                            objAux.NumDownloads = Convert.ToInt32(dr["val_Download"]);

                            objReturn.Add(objAux);
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



        private static Documento FromDataRowDocumento(DataRow dr)
        {

            Documento obj = new Documento();

            obj.Codigo = Convert.ToInt32(dr["cod_Documento"]);
            obj.Titulo = Convert.ToString(dr["nom_Titulo"]);
            obj.DataCriacao = Convert.ToDateTime(dr["dat_Criacao"]);

            obj.IsPublicar = Convert.ToInt32(dr["ind_Publicar"]);

            obj.Tipo = new DocumentoTipo();

            obj.Tipo.Codigo = Convert.ToInt32(dr["cod_Tipo"]);

            obj.Tipo.Icone = Convert.ToString(dr["nom_Icone"]);

            obj.Tipo.Nome = Convert.ToString(dr["nom_Tipo"]);

            obj.Historico = new DocumentoHistorico();

            obj.Historico.DataAtualizacao = Convert.ToDateTime(dr["dat_Atualizacao"]);


            return obj;
        }

        public static List<DocumentoTipo> ListTipo()
        {

            SqlDatabase db = ConfigDAO.CreateDB();
            List<DocumentoTipo> objReturn = new List<DocumentoTipo>();

            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_Documento_Tipo_LST") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;



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

        private static DocumentoTipo FromDataRow(DataRow dr)
        {

            DocumentoTipo obj = new DocumentoTipo();
            
            obj.Codigo = Convert.ToInt32(dr["cod_Tipo"]);
            obj.Nome = Convert.ToString(dr["nom_Tipo"]);

            return obj;
        }

        public static Documento Select(Documento objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();


            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_Documento_SEL") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    db.AddInParameter(dbCommand, "@cod_Documento", SqlDbType.Int, objParametro.Codigo);
                    db.AddInParameter(dbCommand, "@cod_Usuario", SqlDbType.Int, objParametro.Usuario.Codigo);


                    using (DataSet dsRetorno = db.ExecuteDataSet(dbCommand))
                    {
                        objParametro.Codigo = 0;
                        foreach (DataRow dr in dsRetorno.Tables[0].Rows)
                        {

                            objParametro = FromDataRowDocumento(dr);

                            objParametro.Categoria = new Categoria();

                            objParametro.Categoria.Codigo = Convert.ToInt32(dr["cod_Categoria"]);

                            objParametro.Descricao = Convert.ToString(dr["dsc_Documento"]);

                            objParametro.Historico = new DocumentoHistorico();

                            objParametro.Historico.Novidade = Convert.IsDBNull(dr["dsc_Novidade"]) ? string.Empty : Convert.ToString(dr["dsc_Novidade"]);


                            objParametro.Nome = Convert.ToString(dr["nom_Arquivo"]);

                            objParametro.Caminho = Convert.ToString(dr["nom_Caminho"]);


                        }

                        foreach (DataRow dr in dsRetorno.Tables[1].Rows)
                        {

                            DocumentoTag obj = new DocumentoTag();

                            obj.Codigo = Convert.ToInt32(dr["cod_Tag"]);
                            obj.Nome = Convert.ToString(dr["nom_Tag"]);

                            objParametro.TagsList.Add(obj);

                        }

                        foreach (DataRow dr in dsRetorno.Tables[2].Rows)
                        {

                            objParametro.PerfilSelected.Add(Convert.ToInt32(dr["cod_Perfil"]));

                        }

                        foreach (DataRow dr in dsRetorno.Tables[3].Rows)
                        {

                            DocumentoArquivo obj = new DocumentoArquivo();


                            obj.Codigo = Convert.ToInt32(dr["cod_Arquivo"]);
                            obj.Versao = Convert.ToInt32(dr["ind_Versao"]);
                            obj.Nome = Convert.ToString(dr["nom_Arquivo"]);
                            obj.Caminho = Convert.ToString(dr["nom_Caminho"]);
                            obj.IsEmUso = Convert.ToInt32(dr["ind_Uso"]);
                            obj.Tipo = new DocumentoTipo();
                            obj.Tipo.Codigo = Convert.ToInt32(dr["cod_Tipo"]);

                            obj.Tipo.Icone = Convert.ToString(dr["nom_Icone"]);

                            obj.Tipo.Nome = Convert.ToString(dr["nom_Tipo"]);



                            objParametro.Arquivos.Add(obj);

                        }

                        foreach (DataRow dr in dsRetorno.Tables[4].Rows)
                        {

                            DocumentoHistorico obj = new DocumentoHistorico();


                            obj.Codigo = Convert.ToInt32(dr["cod_Historico"]);
                            obj.Usuario = new Usuario();
                            obj.Usuario.Codigo = Convert.ToInt32(dr["cod_Usuario"]);
                            obj.Usuario.Nome = Convert.ToString(dr["nom_Usuario"]);
                            obj.DataAtualizacao = Convert.ToDateTime(dr["dat_Registro"]);
                            obj.Novidade = Convert.ToString(dr["dsc_Novidade"]);


                            objParametro.Historicos.Add(obj);

                        }


                    }


                }
                catch { }
                finally
                {
                    connection.Close();
                }
            }
            return objParametro;

        }

        public static DocumentoArquivo SelectArquivo(Documento objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();
            DocumentoArquivo objReturn = new DocumentoArquivo();

            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_DocumentoArquivo_SEL") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    db.AddInParameter(dbCommand, "@cod_Documento", SqlDbType.Int, objParametro.Codigo);
                    db.AddInParameter(dbCommand, "@cod_Usuario", SqlDbType.Int, objParametro.Usuario.Codigo);


                    using (DataSet dsRetorno = db.ExecuteDataSet(dbCommand))
                    {


                        foreach (DataRow dr in dsRetorno.Tables[0].Rows)
                        {

                            objReturn.Codigo = Convert.ToInt32(dr["cod_Arquivo"]);
                            objReturn.Versao = Convert.ToInt32(dr["ind_Versao"]);
                            objReturn.Nome = Convert.ToString(dr["nom_Arquivo"]);
                            objReturn.Caminho = Convert.ToString(dr["nom_Caminho"]);
                            objReturn.Tipo.Codigo = Convert.ToInt32(dr["cod_Tipo"]);
                            objReturn.Tipo.Icone = Convert.ToString(dr["nom_Icone"]);
                            objReturn.Tipo.Nome = Convert.ToString(dr["nom_Tipo"]);

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

        public static void UpdateArquivo(Documento objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();


            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_DocumentoArquivo_UPD") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    db.AddInParameter(dbCommand, "@cod_Arquivo", SqlDbType.Int, objParametro.Arquivo.Codigo);


                    db.ExecuteNonQuery(dbCommand);


                }
                catch { }
                finally
                {
                    connection.Close();
                }
            }


        }

        public static DocumentoTipo SelectTipo(string objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();
            DocumentoTipo objReturn = new DocumentoTipo();

            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_DocumentoTipo_SEL") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    db.AddInParameter(dbCommand, "@nom_Extensao", SqlDbType.VarChar, objParametro);



                    using (DataSet dsRetorno = db.ExecuteDataSet(dbCommand))
                    {


                        foreach (DataRow dr in dsRetorno.Tables[0].Rows)
                        {

                            objReturn.Codigo = Convert.ToInt32(dr["cod_Tipo"]);
                            objReturn.Nome = Convert.ToString(dr["nom_Tipo"]);


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

        public static int Delete(Documento objParametro)
        {
            SqlDatabase db = ConfigDAO.CreateDB();

            int objReturn = 0;


            using (DbConnection connection = db.CreateConnection())
            {
                connection.Open();
                DbTransaction transaction = connection.BeginTransaction();
                try
                {
                    DbCommand dbCommand = db.GetStoredProcCommand("PR_BOX_Documento_DEL");
                    db.AddInParameter(dbCommand, "@cod_Documento", SqlDbType.Int, objParametro.Codigo);


                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;



                    using (DataSet dsRetorno = db.ExecuteDataSet(dbCommand, transaction))
                    {
                        foreach (DataRow dr in dsRetorno.Tables[0].Rows)
                        {
                            objReturn = Convert.ToInt32(dr["cod_Status"]);

                        }


                        foreach (DataRow dr in dsRetorno.Tables[1].Rows)
                        {

                            DocumentoArquivo obj = new DocumentoArquivo();

                            obj.Nome = Convert.ToString(dr["nom_Arquivo"]);
                            obj.Caminho = Convert.ToString(dr["nom_Caminho"]);

                            objParametro.DocumentosApagados.Add(obj);
                        }


                    }

                    if (objReturn > 0)
                    {

                        foreach (DocumentoArquivo item in objParametro.DocumentosApagados)
                        {
                            File.Delete(Path.Combine(item.Caminho, item.Nome));
                        }

                        transaction.Commit();
                    }
                    else
                    {
                        transaction.Rollback();
                    }

                }
                catch
                {
                    transaction.Rollback();

                }
                finally
                {
                    connection.Close();
                }
            }
            return objReturn;
        }


        public static bool StatusUpdate(Documento objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();
            bool objReturn = false;

            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_DocumentoStatus_UPD") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    db.AddInParameter(dbCommand, "@cod_Documento", SqlDbType.Int, objParametro.Codigo);



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



        public static void InsertLog(Documento objParametro)
        {

            SqlDatabase db = ConfigDAO.CreateDB();
            

            using (SqlConnection connection = db.CreateConnection() as SqlConnection)
            {
                connection.Open();
                try
                {
                    SqlCommand dbCommand = db.GetStoredProcCommand("PR_BOX_Documento_Log_INS") as SqlCommand;
                    dbCommand.CommandTimeout = ConfigDAO.CommmandTimeout;

                    db.AddInParameter(dbCommand, "@cod_Documento", SqlDbType.Int, objParametro.Codigo);

                    db.AddInParameter(dbCommand, "@cod_Usuario", SqlDbType.Int, objParametro.Usuario.Codigo);


                    db.ExecuteNonQuery(dbCommand);


                }
                catch { }
                finally
                {
                    connection.Close();
                }
            }
           

        }



    }
}
