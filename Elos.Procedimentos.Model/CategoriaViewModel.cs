using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Elos.Procedimentos.Model
{
    public class CategoriaViewModel
    {
        public string id { get; set; }
        public string parent { get; set; }
        public string text { get; set; }
        public string icon { get; set; }
        public int position { get; set; }

        public CategoriaStateViewModel state { get; set; }
    }

    public class CategoriaStateViewModel
    {
        public bool disabled { get; set; }
        public bool selected { get; set; }
        public bool opened { get; set; }
    }




    public class Categoria
    {
        public int Codigo { get; set; }

        public string Nome { get; set; }

        public Categoria CategoriaPai { get; set; }

        public string Descricao { get; set; }

        public int? IsPublicar { get; set; }

        public int Ordem { get; set; }
    }
}
