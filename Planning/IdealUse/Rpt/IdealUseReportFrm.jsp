<jsp:include page = '/Include/ValidateSessionYum.jsp'/>

<%--
##########################################################################################################
# Nombre Archivo  : IdealUseReportFrm.jsp
# Compania        : Yum Brands Intl
# Autor           : Sergio Cuellar
# Objetivo        : Uso ideal diario de ciertos productos
# Fecha Creacion  : 14/Febrero/2011
##########################################################################################################
--%>

<%@ page import="java.util.*" %>
<%@ page import="java.io.File"%>
<%@ page import="generals.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>

<%@ include file="/Include/CommonLibYum.jsp" %>
<%@ include file="../Proc/IdealUseLibYum.jsp" %>

<%! 
	AbcUtils moAbcUtils = new AbcUtils();
	String msYear;
	String msPeriod;
	String msWeek;
	String msWeekId;
	String msDay;
	String msTarget;
	String msCSS;
	String selectedDate;
	String TransManager;
	String goalDate;
%>

<%
	try
	{
		msYear   = request.getParameter("year");
		msPeriod = request.getParameter("period");
		msWeek   = request.getParameter("week");
		msWeekId = request.getParameter("weekId");
		msDay    = request.getParameter("day");
		msTarget = request.getParameter("hidTarget");

	        selectedDate = getDate(msWeek, msYear, msPeriod, msDay);
	        TransManager = getTransManager(selectedDate);
	        goalDate     = getLastDateEqualRealTransactions(TransManager);

	}
	catch(Exception e)
	{
		msYear   = "0";
		msPeriod = "0";
		msWeek   = "0";
	}

	if(msTarget.equals("Printer"))
	{
		msCSS = "DataGridReportPrinterYum.css";
	}
	else
	{
		msCSS = "DataGridDefaultYum.css";
	}

        HtmlAppHandler moHtmlAppHandler = (HtmlAppHandler)session.getAttribute(request.getRemoteAddr());
        moHtmlAppHandler.setPresentation("VIEWPORT");
        moHtmlAppHandler.initializeHandler();
        moHtmlAppHandler.msReportTitle = getCustomHeader("Uso Ideal Diario", msTarget);
        moHtmlAppHandler.updateHandler();
        moHtmlAppHandler.validateHandler();

%>

<html>
    <head>
        <link rel="stylesheet" type="text/css" href="/CSS/GeneralStandardsYum.css"/>
	<link rel="stylesheet" type="text/css" href="/CSS/<%= msCSS %>"/>
        <script src="/Scripts/ArrayUtilsYum.js"></script>
        <script src="/Scripts/DataGridClassYum.js"></script>
        <script src="/Scripts/MiscLibYum.js"></script>
        <script src="/Scripts/StringUtilsYum.js"></script>
        <script src="/Scripts/HtmlUtilsYum.js"></script>
	<script type="text/javascript">
	    var loGrid1    = new Bs_DataGrid('loGrid1');
	    var loGrid2    = new Bs_DataGrid('loGrid2');
	    var loGrid3    = new Bs_DataGrid('loGrid3');
	    var loGrid4    = new Bs_DataGrid('loGrid4');
	    var loGrid5    = new Bs_DataGrid('loGrid5');
	    var loGrid6    = new Bs_DataGrid('loGrid6');
	    var loGrid7    = new Bs_DataGrid('loGrid7');
	    var loGrid8    = new Bs_DataGrid('loGrid8');
	    var loGrid9    = new Bs_DataGrid('loGrid9');
	    var loGrid10   = new Bs_DataGrid('loGrid10');
            var biscuitsDataset    = parent.biscuitsDataset;
            var congeladosDataset  = parent.congeladosDataset;
            var ensaladaDataset    = parent.ensaladaDataset;
            var homeDataset        = parent.homeDataset;
            var marinadoDataset    = parent.marinadoDataset;
            var purensaladaDataset = parent.purensaladaDataset;
            var pureDataset        = parent.pureDataset;
            var sandwichDataset    = parent.sandwichDataset;
            var servicioDataset    = parent.servicioDataset;
            var trasempaqueDataset = parent.trasempaqueDataset;
	</script>
        <script src="../Scripts/IdealUseYum.js"></script>
    </head>

    <body bgcolor="white" style="margin-left: 0px; margin-right: 0px" 
          onLoad="initDataGrid()">

    <jsp:include page="/Include/GenerateHeaderYum.jsp">
		<jsp:param name="psStoreName" value="true"/>
    </jsp:include>

    <table width="99%" border="0" align="center" cellspacing="6">
        <tr>
			<td>
				<b class="datagrid-leyend">A&ntilde;o: <%= msYear %>, Periodo: <%= msPeriod %>, Semana: <%= msWeek %></b>
            </td>
        </tr>
	<tr>
	    <td>
	        <b class="datagrid-leyend">N&uacute;mero de Transacciones Pron&oacute;sticadas <%= TransManager %> para el d&iacute;a <%= selectedDate %></b>
            </td>
	</tr>
	<tr>
	    <td>
	        <b class="datagrid-leyend">Fecha con el n&uacute;mero de transacciones reales m&aacute;s parecidas: <%= goalDate %></b>
            </td>
	</tr>
        <tr>
            <td>
                <div id="biscuitsDataGrid"></div>
	        <br>
            </td>
	</tr>
        <tr>
            <td>
                <div id="congeladosDataGrid"></div>
	        <br>
            </td>
	</tr>
        <tr>
            <td>
                <div id="ensaladaDataGrid"></div>
	        <br>
            </td>
	</tr>
        <tr>
            <td>
                <div id="homeDataGrid"></div>
	        <br>
            </td>
	</tr>
        <tr>
            <td>
                <div id="marinadoDataGrid"></div>
	        <br>
            </td>
	</tr>
        <tr>
            <td>
                <div id="purensaladaDataGrid"></div>
	        <br>
            </td>
	</tr>
        <tr>
            <td>
                <div id="pureDataGrid"></div>
	        <br>
            </td>
	</tr>
        <tr>
            <td>
                <div id="sandwichDataGrid"></div>
	        <br>
            </td>
	</tr>
        <tr>
            <td>
                <div id="trasempaqueDataGrid"></div>
	        <br>
            </td>
	</tr>
        <tr>
            <td>
                <div id="servicioDataGrid"></div>
	        <br>
            </td>
	</tr>
    </table>

    <jsp:include page = '/Include/TerminatePageYum.jsp'/>
    </body>
</html>


