using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;

namespace Elos.Procedimentos.Web
{
    public class BundleConfig
    {

        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new StyleBundle("~/css/cssBundle").Include(
                "~/css/bootstrap.css",
                "~/css/bootstrap-select.min.css",
                "~/css/datepicker3.css",
                "~/css/style.css",
                "~/css/toastr.min.css",
                "~/css/jquery.treegrid.css",
                "~/css/Sorting.css",
                "~/css/jstree.style.min.css",
                "~/css/bootstrap-tagsinput.css",
                "~/css/font-awesome.css"
                


            ));

            bundles.Add(new ScriptBundle("~/jsBundle").Include(
                "~/js/jquery-1.11.0.min.js",
                "~/js/bootstrap.min.js",
                "~/js/bootstrap-select.min.js",
                "~/js/bootstrap-file-input.js",
                "~/js/bootstrap-datepicker.js",
                "~/js/jquery.validate.min.js",
                "~/js/validate-additional-methods.min.js",
                "~/js/jquery.mask.js",
                "~/js/xdate.js",
                "~/js/jquery.dataTables.min.js",
                "~/js/datatables.js",
                "~/js/dataTables.fixedHeader.min.js",
                "~/js/jquery.treegrid.js",
                "~/js/jquery.treegrid.bootstrap3.js",
                "~/js/bootbox.min.js",
                "~/js/functions.js",
                "~/js/toastr.min.js",
                "~/js/jquery.timer.js",
                "~/js/jquery.totemticker.js",
                "~/js/jquery.loadTemplate-1.4.5.js",
                "~/js/jstree.min.js",
                "~/js/typeahead.bundle.js",
                "~/js/bootstrap-tagsinput.js",
                "~/js/elos.tree-view.js",
                "~/js/jquery.inline-confirmation.js"
                
            ));

            bundles.Add(new ScriptBundle("~/jsLoginBundle").Include(
               "~/js/jquery-1.11.0.min.js",
               "~/js/jquery.html5-placeholder-shim.js",
               "~/js/jquery.validate.min.js",
               "~/js/validate-additional-methods.min.js"
            ));

            bundles.Add(new ScriptBundle("~/jsHighcharts").Include(
                "~/js/Highcharts-4.0.1/highcharts.js",
                "~/js/Highcharts-4.0.1/highcharts-more.js",
                "~/js/Highcharts-4.0.1/modules/exporting.js",
                "~/js/Highcharts-4.0.1/modules/data.js"
            ));

            bundles.Add(new ScriptBundle("~/jsJit").Include(
               "~/js/jit/jit.js"
           ));

            // TODO: mudar isso para true antes de implantar em produção
            BundleTable.EnableOptimizations = false;
        }
    }
}