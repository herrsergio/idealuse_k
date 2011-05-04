
    function initDataGrid()
    {
        var _class  = " class='descriptionTabla' style='border: solid rgb(0,0,0) 0px; font-size:11px;  background-color: transparent;' ";

        loGrid1.bHeaderFix = false;
        loGrid1.width      = '500';
        loGrid1.padding    = 5;

        loGrid2.bHeaderFix = false;
        loGrid2.width      = '500';
        loGrid2.padding    = 5;

        loGrid3.bHeaderFix = false;
        loGrid3.width      = '500';
        loGrid3.padding    = 5;

        loGrid4.bHeaderFix = false;
        loGrid4.width      = '500';
        loGrid4.padding    = 5;

        loGrid5.bHeaderFix = false;
        loGrid5.width      = '500';
        loGrid5.padding    = 5;

        loGrid6.bHeaderFix = false;
        loGrid6.width      = '500';
        loGrid6.padding    = 5;

        loGrid7.bHeaderFix = false;
        loGrid7.width      = '500';
        loGrid7.padding    = 5;

        loGrid8.bHeaderFix = false;
        loGrid8.width      = '500';
        loGrid8.padding    = 5;

        loGrid9.bHeaderFix = false;
        loGrid9.width      = '500';
        loGrid9.padding    = 5;

        loGrid10.bHeaderFix = false;
        loGrid10.width      = '500';
        loGrid10.padding    = 5;


        if(biscuitsDataset.length > 0)
        {

	    mheaders = new Array(
	             {text:'Biscuit', align:'center',hclass:'right'});

            headers  = new Array(
            // 0:  Producto
                     {text:'Producto',width:'15%', hclass: 'left', bclass:'left', align:'right'},
            // 1:  Unidad de Medidda
                     {text:'Unidad Medida ',width:'17%', hclass: 'right', bclass: 'right', align: 'right'},
            // 2:  Cantidad Total
                     {text:'Uso Ideal', width:'17%', align: 'right'});


            props    = new Array(null,null,null);
            
	    loGrid1.setMainHeaders(mheaders);
            loGrid1.setHeaders(headers);
            loGrid1.setDataProps(props);
            loGrid1.setData(biscuitsDataset);        
            loGrid1.drawInto('biscuitsDataGrid');
        }

        if(congeladosDataset.length > 0)
        {

	    mheaders = new Array(
	             {text:'Congelados', align:'center',hclass:'right'});

            headers  = new Array(
            // 0:  Producto
                     {text:'Producto',width:'15%', hclass: 'left', bclass:'left', align:'right'},
            // 1:  Unidad de Medidda
                     {text:'Unidad Medida ',width:'17%', hclass: 'right', bclass: 'right', align: 'right'},
            // 2:  Cantidad Total
                     {text:'Uso Ideal', width:'17%', align: 'right'});


            props    = new Array(null,null,null);
            
	    loGrid2.setMainHeaders(mheaders);
            loGrid2.setHeaders(headers);
            loGrid2.setDataProps(props);
            loGrid2.setData(congeladosDataset);        
            loGrid2.drawInto('congeladosDataGrid');
        }

        if(ensaladaDataset.length > 0)
        {

	    mheaders = new Array(
	             {text:'Ensalada', align:'center',hclass:'right'});

            headers  = new Array(
            // 0:  Producto
                     {text:'Producto',width:'15%', hclass: 'left', bclass:'left', align:'right'},
            // 1:  Unidad de Medidda
                     {text:'Unidad Medida ',width:'17%', hclass: 'right', bclass: 'right', align: 'right'},
            // 2:  Cantidad Total
                     {text:'Uso Ideal', width:'17%', align: 'right'});


            props    = new Array(null,null,null);
            
	    loGrid3.setMainHeaders(mheaders);
            loGrid3.setHeaders(headers);
            loGrid3.setDataProps(props);
            loGrid3.setData(ensaladaDataset);        
            loGrid3.drawInto('ensaladaDataGrid');
        }

        if(homeDataset.length > 0)
        {

	    mheaders = new Array(
	             {text:'Home Delivery', align:'center',hclass:'right'});

            headers  = new Array(
            // 0:  Producto
                     {text:'Producto',width:'15%', hclass: 'left', bclass:'left', align:'right'},
            // 1:  Unidad de Medidda
                     {text:'Unidad Medida ',width:'17%', hclass: 'right', bclass: 'right', align: 'right'},
            // 2:  Cantidad Total
                     {text:'Uso Ideal', width:'17%', align: 'right'});


            props    = new Array(null,null,null);
            
	    loGrid4.setMainHeaders(mheaders);
            loGrid4.setHeaders(headers);
            loGrid4.setDataProps(props);
            loGrid4.setData(homeDataset);        
            loGrid4.drawInto('homeDataGrid');
        }

        if(marinadoDataset.length > 0)
        {

	    mheaders = new Array(
	             {text:'Marinado', align:'center',hclass:'right'});

            headers  = new Array(
            // 0:  Producto
                     {text:'Producto',width:'15%', hclass: 'left', bclass:'left', align:'right'},
            // 1:  Unidad de Medidda
                     {text:'Unidad Medida ',width:'17%', hclass: 'right', bclass: 'right', align: 'right'},
            // 2:  Cantidad Total
                     {text:'Uso Ideal', width:'17%', align: 'right'});


            props    = new Array(null,null,null);
            
	    loGrid5.setMainHeaders(mheaders);
            loGrid5.setHeaders(headers);
            loGrid5.setDataProps(props);
            loGrid5.setData(marinadoDataset);        
            loGrid5.drawInto('marinadoDataGrid');
        }

        if(purensaladaDataset.length > 0)
        {

	    mheaders = new Array(
	             {text:'Pure y Ensalada', align:'center',hclass:'right'});

            headers  = new Array(
            // 0:  Producto
                     {text:'Producto',width:'15%', hclass: 'left', bclass:'left', align:'right'},
            // 1:  Unidad de Medidda
                     {text:'Unidad Medida ',width:'17%', hclass: 'right', bclass: 'right', align: 'right'},
            // 2:  Cantidad Total
                     {text:'Uso Ideal', width:'17%', align: 'right'});


            props    = new Array(null,null,null);
            
	    loGrid6.setMainHeaders(mheaders);
            loGrid6.setHeaders(headers);
            loGrid6.setDataProps(props);
            loGrid6.setData(purensaladaDataset);        
            loGrid6.drawInto('purensaladaDataGrid');
        }

        if(pureDataset.length > 0)
        {

	    mheaders = new Array(
	             {text:'Pure', align:'center',hclass:'right'});

            headers  = new Array(
            // 0:  Producto
                     {text:'Producto',width:'15%', hclass: 'left', bclass:'left', align:'right'},
            // 1:  Unidad de Medidda
                     {text:'Unidad Medida ',width:'17%', hclass: 'right', bclass: 'right', align: 'right'},
            // 2:  Cantidad Total
                     {text:'Uso Ideal', width:'17%', align: 'right'});


            props    = new Array(null,null,null);
            
	    loGrid7.setMainHeaders(mheaders);
            loGrid7.setHeaders(headers);
            loGrid7.setDataProps(props);
            loGrid7.setData(pureDataset);        
            loGrid7.drawInto('pureDataGrid');
        }

        if(sandwichDataset.length > 0)
        {

	    mheaders = new Array(
	             {text:'Sandwich', align:'center',hclass:'right'});

            headers  = new Array(
            // 0:  Producto
                     {text:'Producto',width:'15%', hclass: 'left', bclass:'left', align:'right'},
            // 1:  Unidad de Medidda
                     {text:'Unidad Medida ',width:'17%', hclass: 'right', bclass: 'right', align: 'right'},
            // 2:  Cantidad Total
                     {text:'Uso Ideal', width:'17%', align: 'right'});


            props    = new Array(null,null,null);
            
	    loGrid8.setMainHeaders(mheaders);
            loGrid8.setHeaders(headers);
            loGrid8.setDataProps(props);
            loGrid8.setData(sandwichDataset);        
            loGrid8.drawInto('sandwichDataGrid');
        }

        if(servicioDataset.length > 0)
        {

	    mheaders = new Array(
	             {text:'Servicio', align:'center',hclass:'right'});

            headers  = new Array(
            // 0:  Producto
                     {text:'Producto',width:'15%', hclass: 'left', bclass:'left', align:'right'},
            // 1:  Unidad de Medidda
                     {text:'Unidad Medida ',width:'17%', hclass: 'right', bclass: 'right', align: 'right'},
            // 2:  Cantidad Total
                     {text:'Uso Ideal', width:'17%', align: 'right'});


            props    = new Array(null,null,null);
            
	    loGrid9.setMainHeaders(mheaders);
            loGrid9.setHeaders(headers);
            loGrid9.setDataProps(props);
            loGrid9.setData(servicioDataset);        
            loGrid9.drawInto('servicioDataGrid');
        }

        if(trasempaqueDataset.length > 0)
        {

	    mheaders = new Array(
	             {text:'Trasempaque', align:'center',hclass:'right'});

            headers  = new Array(
            // 0:  Producto
                     {text:'Producto',width:'15%', hclass: 'left', bclass:'left', align:'right'},
            // 1:  Unidad de Medidda
                     {text:'Unidad Medida ',width:'17%', hclass: 'right', bclass: 'right', align: 'right'},
            // 2:  Cantidad Total
                     {text:'Uso Ideal', width:'17%', align: 'right'});


            props    = new Array(null,null,null);
            
	    loGrid10.setMainHeaders(mheaders);
            loGrid10.setHeaders(headers);
            loGrid10.setDataProps(props);
            loGrid10.setData(trasempaqueDataset);        
            loGrid10.drawInto('trasempaqueDataGrid');
        }
    }


