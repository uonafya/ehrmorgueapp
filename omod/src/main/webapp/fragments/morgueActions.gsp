<%
    ui.decorateWith("appui", "standardEmrPage", [title: "admit"])

    ui.includeCss("ehrconfigs", "referenceapplication.css")
    ui.includeCss("ehrconfigs", "onepcssgrid.css")

    ui.includeJavascript("ehrconfigs", "moment.js")
    ui.includeJavascript("ehrconfigs", "jquery.dataTables.min.js")
    ui.includeJavascript("ehrconfigs", "jq.browser.select.js")
    ui.includeJavascript("ehrconfigs", "knockout-3.4.0.js")
    ui.includeJavascript("ehrconfigs", "jquery-ui-1.9.2.custom.min.js")
    ui.includeJavascript("ehrconfigs", "underscore-min.js")
    ui.includeJavascript("ehrconfigs", "emr.js")
%>



<body>

</body>
<header>
    <style>
    .adm-frm{
        display: flex;
        flex-direction: row;
        padding: 5px;
        margin-left: 8px;
    }
    @media screen and (max-width: 900px){
        .adm-frm{
            flex-direction: column;
        }
    }
    #dump-bed{
        width: 100%;
        display: grid;
        grid-template-columns: repeat(6, auto);
        gap: 7px;
        padding-bottom: 14px;
    }
    .bp-container{
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        padding: 2px;
    }
    .bp-span{
        padding: 3px;
    }
    .bp-container{
        padding: 3px;
        background-color: firebrick;
        color: white;
        cursor: pointer;
    }
    .bp-container[data-people="0"]{
        background-color: #34bf6e;
    }
    .ke-page-container{
        min-height: 100vh;
    }
    body{
        min-height: 100vh;
    }
    .page-content{
        height: 100%;
        min-height: 700px;
    }
    #addDrugDialog{
        position: absolute;
        top: 0%;
        z-index: 3000;
        left: 25%;
        width: 60%;
        overflow: auto;
        height: 90%;
    }
    .hidden{
        display: none;
    }
    </style>
</header>
<script>

</script>
<div class="clear"></div>
<div class="container">
    <div class="example">
        <ul id="breadcrumbs">
            <li>
                <a href="#">
                    <i class="icon-home small"></i></a>
            </li>
            <li>
                <i class="icon-chevron-right link"></i>
                <a href="#">Morgue Admission</a>
            </li>
            <li>
            </li>
        </ul>
    </div>
  <div></div>
</div>
