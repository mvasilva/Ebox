using ELOS.Framework.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Elos.Procedimentos.Model
{
    public class Documento
    {

        public int Codigo { get; set; }
        public int NumDownloads { get; set; }

        public Categoria Categoria { get; set; }

        public string Titulo { get; set; }

        public string Descricao { get; set; }
        
        public string Tags { get; set; }
        
        public DocumentoTipo Tipo { get; set; }

        public string PerfilStr { get; set; }

        private List<int> _perfilSelected = new List<int>();

        public List<int> PerfilSelected { get { return _perfilSelected; } set { _perfilSelected = value; } }

        public string Nome { get; set; }

        public string Caminho { get; set; }

        public int IsPublicar { get; set; }

        public DateTime DataCriacao { get; set; }

        public DocumentoHistorico Historico { get; set; }

        public DocumentoArquivo Arquivo { get; set; }

        private List<DocumentoHistorico> _historicos = new List<DocumentoHistorico>();

        public List<DocumentoHistorico> Historicos { get { return _historicos; } set { _historicos = value; } }

        private List<DocumentoArquivo> _documentosApagados = new List<DocumentoArquivo>();

        public List<DocumentoArquivo> DocumentosApagados { get { return _documentosApagados; } set { _documentosApagados = value; } }


        private List<DocumentoArquivo> _arquivos = new List<DocumentoArquivo>();

        public List<DocumentoArquivo> Arquivos { get { return _arquivos; } set { _arquivos = value; } }


        private List<DocumentoTag> _tagsList = new List<DocumentoTag>();

        public List<DocumentoTag> TagsList { get { return _tagsList; } set { _tagsList = value; } }


        public Usuario Usuario { get; set; }

        public int IsUpload { get; set; }



    }


    public class DocumentoTag
    {
        public int Codigo { get; set; }
        public string Nome { get; set; }
    }


    public class DocumentoArquivo
    {
        public int Codigo { get; set; }
        public int Versao { get; set; }

        public string Nome { get; set; }
        public string Caminho { get; set; }


        public int IsEmUso { get; set; }


        public DocumentoTipo Tipo { get; set; }

      
        


    }


    public class DocumentoHistorico
    {
        public int Codigo { get; set; }
        public Documento Documento { get; set; }
        public Usuario Usuario { get; set; }
        public DateTime DataAtualizacao { get; set; }
        public bool IsUltimo { get; set; }
        public string Novidade { get; set; }
    }



    public class DocumentoTipo
    {
        public int Codigo { get; set; }

        public string Nome { get; set; }

        public string Icone { get; set; }


    }
}
