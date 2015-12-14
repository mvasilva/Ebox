var actionCarregar = '';
var actionCriar = '';
var actionPublicar = '';
var actionDeletar = '';
var actionDocumentos = '';
var actionDocumentosHistorico = '';
var actionAtualizarArquivo = '';
var actionDeletarDocumento = '';
var actionPublicarDocumento = '';
var actionDocumentosBuscar = '';


function BuildArvore(json) {

    $("#divArvore").on('changed.jstree', function (e, data) {


        var ref = $('#divArvore').jstree(true);
        var sel = ref.get_selected();
        if (!sel.length) { return false; }

        sel = sel[0];

        $("#hddCategoria").val(sel);

        if (actionDocumentos != '') {
            CarregarDocumentos(sel);
        }

    })
  .on('move_node.jstree', function (e, data) {

      var nodeAux = data.node;

      nodeAux.parent = data.parent;

      nodeAux.position = data.position;

      // alert(JSON.stringify(nodeAux.parent));
      //alert(data.parent);

      AtualizarCategoria(nodeAux);

  })
  .on('create_node.jstree', function (e, data) {



  })
   .on('rename_node.jstree', function (e, data) {

       var nodeAux = data.node;

       nodeAux.text = data.text;

       AtualizarCategoria(nodeAux);


   })
    .on('ready.jstree', function (e, data) {


        var er = /^-?[0-9]+$/;
        var _Valor = $("#hddCategoria").val();
        if (_Valor != '') {
            if (er.test(_Valor)) {
                var ref = $('#divArvore').jstree(true);


                var sel = [];

                sel.push($("#hddCategoria").val());

                ref.select_node(sel);
            } else {

                Buscar(_Valor);

            }
        }


    })



  .jstree({
      "core": {
          "check_callback": true,
          "multiple": false,
          'data': json.Categorias
      },
      "plugins": json.Plugins
  });





}



function Buscar(_busca) {

    var objParametro = {

        Titulo: _busca,

        success: function (data) {
            $('#div_documentos').html("");
            $('#div_documentos').html(data);
            $('[data-toggle="tooltip"]').tooltip();
        },
        beforeSend: function (response) {
            $('#div_documentos').html(strLoading);
        }
    }

    call_AjaxHtml("POST", actionDocumentosBuscar, objParametro);

}

function CallAjaxArvore() {


    var objReturn = {

        success: function (data) {

            BuildArvore(data);


        },
        beforeSend: function (response) {
            $('#divArvore').html(strLoading);
        }
    };

    call_AjaxJson("POST", actionCarregar, objReturn);

}


function AtualizarCategoria(node) {

    var objReturn = {

        success: function (data) {

            if (data.Result > 0) {


            }

        },
        beforeSend: function (response) {

        }
    };

    $.extend(node, objReturn);

    call_AjaxJson("POST", actionCriar, node);

}


function AtualizarStatusCategoria(node, ref) {

    var objReturn = {
        id: node,
        success: function (data) {
            ref.set_icon(node, data.Result ? "glyphicon glyphicon-folder-open text-success" : "glyphicon glyphicon-folder-close text-danger");
        },
        beforeSend: function (response) {

        }
    };



    call_AjaxJson("POST", actionPublicar, objReturn);

}

function CarregarDocumentos(categoria) {
    var objParametro = {

        Categoria: { Codigo: categoria },

        success: function (data) {
            $('#div_documentos').html("");
            $('#div_documentos').html(data);
            $('[data-toggle="tooltip"]').tooltip();
        },
        beforeSend: function (response) {
            $('#div_documentos').html(strLoading);
        }
    }
    call_AjaxHtml("POST", actionDocumentos, objParametro);

}




function CarregarHistoricos(documento) {

    var objParametro = {

        Codigo: documento,
        success: function (data) {
            $('#divModelHistorico').html("");
            $('#divModelHistorico').html(data);
            $('[data-toggle="tooltip"]').tooltip();



            LoadConfirmInline();


        },
        beforeSend: function (response) {
            $('#divModelHistorico').html(strLoading);
        }
    }
    call_AjaxHtml("POST", actionDocumentosHistorico, objParametro);

}


function LoadConfirmInline() {

    $(".aArquivoAtivar").inlineConfirmation({
        confirm: "<a href='#'><i class='fa fa-check'></i>Sim</a>",
        cancel: "<a href='#'><i class='fa fa-times'></i>Não</a>",
        confirmCallback: function (element) {


            AtualizarArquivo($("#hddDocumentoArquivoCodigo").val(), $(element).attr("data-arquivo-id"));

        },
        reverse: true,
        expiresIn: 3
    });

}


function AtualizarArquivo(documento, arquivo) {

    var objParametro = {

        Codigo: documento,
        Arquivo: {
            Codigo: arquivo
        },
        success: function (data) {
            $('#divHistoricoArquivos').html("");
            $('#divHistoricoArquivos').html(data);
            $('[data-toggle="tooltip"]').tooltip();

            var _class = $("#icone-tipo-hist-" + arquivo).attr("class");



            $("#icone-tipo-" + documento).attr("class", _class);

            LoadConfirmInline();
        },
        beforeSend: function (response) {
            $('#divHistoricoArquivos').html(strLoading);
        }
    }
    call_AjaxHtml("POST", actionAtualizarArquivo, objParametro);

}



$(document).on("click", ".aHistorico", function (event) {

    event.preventDefault();



    $('#ModalHistorico').modal('show');




    CarregarHistoricos($(this).attr("data-documento-id"));

});



function CriarCategoria(node, ref) {

    var objReturn = {

        success: function (data) {

            if (data.Result > 0) {

                node.id = data.Result

                var sel = ref.create_node(node.parent, node);
                if (sel) {
                    ref.edit(sel);
                }
            }

        },
        beforeSend: function (response) {

        }
    };

    $.extend(node, objReturn);

    call_AjaxJson("POST", actionCriar, node);

}



function DeletarCategoria(node, ref) {

    var objReturn = {

        Codigo: node,
        success: function (data) {

            if (data.Result > 0) {
                ref.delete_node(node);

            } else {

                switch (data.Result) {


                    case -1:
                    case -2:
                        bootbox.alert("Não é possuível excluir uma categoria que contem subcategoria(s) ou documento(s) vinculados.");
                        break;

                    default:
                        bootbox.alert("Erro ao excluir a categoria.");
                        break;
                }


            }

        },
        beforeSend: function (response) {

        }
    };

    call_AjaxJson("POST", actionDeletar, objReturn);

}


var to = false;
$(document).ready(function () {

    bootbox.setDefaults({ locale: 'br' });




    $('#txtBusca').keyup(function () {
        if (to) { clearTimeout(to); }
        to = setTimeout(function () {
            var v = $('#txtBusca').val();
            $('#divArvore').jstree(true).search(v);
        }, 250);
    });

})

$(document).on("click", "#aCriar", function (event) {

    event.preventDefault();

    var ref = $('#divArvore').jstree(true);
    var sel = ref.get_selected();
    var node = { type: "folder", text: "Nova Categoria", id: 0, position: 0, icon: "glyphicon glyphicon-folder-close text-danger" };
    if (!sel.length) {

        node.parent = "#";

    } else {

        sel = sel[0];
        node.parent = sel;

    }

    CriarCategoria(node, ref);

});


$(document).on("click", "#aRenomear", function (event) {

    event.preventDefault();

    var ref = $('#divArvore').jstree(true);
    var sel = ref.get_selected();

    if (!sel.length) { return false; }
    sel = sel[0];
    ref.edit(sel);

});



$(document).on("click", "#aAtivar", function (event) {
    event.preventDefault();

    bootbox.confirm("Deseja realmente executar esta ação?", function (result) {
        if (result) {
            var ref = $('#divArvore').jstree(true);
            var sel = ref.get_selected();

            if (!sel.length) { return false; }
            //sel.state.disabled = true;
            sel = sel[0];

            AtualizarStatusCategoria(sel, ref);
        }
    });


});



$(document).on("click", "#aDeletar", function (event) {

    event.preventDefault();

    bootbox.confirm("Deseja realmente executar esta ação?", function (result) {
        if (result) {

            var ref = $('#divArvore').jstree(true);
            var sel = ref.get_selected();

            if (!sel.length) { return false; }
            //sel.state.disabled = true;
            sel = sel[0];

            DeletarCategoria(sel, ref);
        }
    });

});


$(document).on("click", ".aDeletarDocumento", function (event) {

    event.preventDefault();

    var _documento = $(this).attr("data-documento-id");

    bootbox.confirm("Deseja realmente executar esta ação?", function (result) {
        if (result) {

            DeletarDocumento(_documento);
        }
    });

});

function DeletarDocumento(Documento) {

    var objReturn = {
        Codigo: Documento,
        success: function (data) {
            if (data.Result == 1) {


                var er = /^-?[0-9]+$/;
                var _Valor = data.Categoria;
                if (_Valor != '') {
                    if (er.test(_Valor)) {
                        CarregarDocumentos(data.Categoria);
                    } else {

                        Buscar(_Valor);

                    }
                }


            } else {

            }
        },
        beforeSend: function (response) {

        }
    };


    call_AjaxJson("POST", actionDeletarDocumento, objReturn);

}




$(document).on("click", ".chkPublicarDoc", function (event) {

    event.preventDefault();

    var _documento = $(this);

    bootbox.confirm("Deseja realmente executar esta ação?", function (result) {
        if (result) {



            PublicarDocumento(_documento);
        }
    });

});


function PublicarDocumento(Documento) {

    var objReturn = {
        Codigo: Documento.attr("data-documento-id"),
        success: function (data) {

            Documento.prop('checked', data.Result);


        },
        beforeSend: function (response) {

        }
    };


    call_AjaxJson("POST", actionPublicarDocumento, objReturn);

}




