function InitMultiCombos() {
    $(".selectpicker").each(function (index) {
        var _cbo = $(this);
        _cbo.selectpicker({
            countSelectedText: "{0} de {1} selecionados",
            style: 'btn-filtrar btn-default',
            dropupAuto: 'true',
            size: 'false',
            header: "<a id='btnTodos" + _cbo.attr("id") + "' class='btn btn-default btn-block btn-sm btn-combo' >Todos</a><a id='btnNenhum" + _cbo.attr("id") + "' class='btn btn-default btn-block btn-sm btn-combo'>Nenhum</a>"
        });

        $(document).on("click", "#btnTodos" + _cbo.attr("id"), function (e) {
            e.stopPropagation();
            $("#" + _cbo.attr("id")).selectpicker('selectAll');

        });

        $(document).on("click", "#btnNenhum" + _cbo.attr("id"), function (e) {
            e.stopPropagation();
            $('#' + _cbo.attr("id")).selectpicker('deselectAll');
        });
    });
}



function InitMultiCombosSemBotao() {
    $(".selectpicker_SemBt").each(function (index) {
        var _cbo = $(this);
        _cbo.selectpicker({
            countSelectedText: "{0} de {1} selecionados",
            style: 'btn-filtrar btn-default',
            dropupAuto: 'true',
            size: 'false',
            header: ""
        });


    });
}

