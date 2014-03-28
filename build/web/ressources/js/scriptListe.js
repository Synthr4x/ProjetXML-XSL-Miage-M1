$(document).ready(function() {

    var oTable = $('#tableListe').dataTable({
        "sDom": "T&lt;'clear'&gt;lfrtip",
        "oTableTools": {
            "sSwfPath": "ressources/swf/copy_csv_xls_pdf.swf"
        }
    });
    
    $('.dataTables_length')[1].remove();
    $('.dataTables_length')[0].remove();
    $('.DTTT_container').after("<br/>");

    /* Add event listeners to the two range filtering inputs */
    $('#max').keyup(function() {
        oTable.fnDraw();
    });

});

/* Custom filtering function which will filter data in column four between two values */
$.fn.dataTableExt.afnFiltering.push(
        function(oSettings, aData, iDataIndex) {
            var max = document.getElementById('max').value * 1;
            var prixSimple = aData[4] == "" ? 0 : aData[4] * 1;
            var prixDouble = aData[5] == "" ? 0 : aData[5] * 1;

            if (prixSimple == 0 && prixDouble == 0)
                return false;
            else if (max == "")
            {
                return true;
            }
            else if (prixSimple < max && prixDouble == 0)
            {
                return true;
            }
            else if (prixDouble < max && prixSimple == 0)
            {
                return true;
            }
            else if (prixSimple < max && prixDouble < max)
            {
                return true;
            }
            return false;
        }
);

