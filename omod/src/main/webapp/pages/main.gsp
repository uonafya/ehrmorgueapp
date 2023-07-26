<%
    ui.decorateWith("kenyaemr", "standardPage")

    ui.includeJavascript("ehrconfigs", "jquery-ui-1.9.2.custom.min.js")
    ui.includeJavascript("ehrconfigs", "underscore-min.js")
    ui.includeJavascript("ehrconfigs", "knockout-3.4.0.js")
    ui.includeJavascript("ehrconfigs", "emr.js")
    ui.includeJavascript("ehrconfigs", "jquery.simplemodal.1.4.4.min.js")
    ui.includeJavascript("ehrconfigs", "jquery.toastmessage.js")
    ui.includeJavascript("ehrconfigs", "jquery.dataTables.min.js")
    ui.includeCss("ehrconfigs", "onepcssgrid.css")
    ui.includeJavascript("ehrconfigs", "jq.browser.select.js")
    ui.includeJavascript("ehrconfigs", "moment.min.js")
    ui.includeCss("ehrconfigs", "jquery-ui-1.9.2.custom.min.css")
    ui.includeCss("ehrconfigs", "referenceapplication.css")
    ui.includeCss("uicommons", "datatables/dataTables_jui.css")
    ui.includeCss("ehrconfigs", "jquery.toastmessage.css")

%>


<script>
    jQuery(function () {

        jQuery("#deadDetails tbody tr").click(function () {

            jQuery("#morgue-patients, #morgue-queue").hide();

            var tabToShow = jQuery(this).closest("table").attr("id") === "deadDetails" ? "#morgue-patients" : "#morgue-queue";
            jQuery(tabToShow).show();
        });
    });
    jQuery(function (){
        // Set up the tabs functionality with horizontal orientation
        jQuery("#tabs").tabs({
            // Set the tab orientation to "horizontal"
            orientation: "horizontal"
        });
    });
</script>

<style>
.toast-item {
    background-color: #222;
}
.paginate_disabled_previous, .paginate_enabled_previous, .paginate_disabled_next, .paginate_enabled_next{
    width:auto;
}
.button.task, button.task, input[type="submit"].task, input[type="button"].task, input[type="submit"].task, a.button.task{
    min-width: auto;
}
.dataTables_length{
    text-align: left
}
.dropdown ul {
    z-index: 9;
}
.dropdown ul li {
    width: 200px;
}
.ui-tabs .ui-tabs-panel {
    padding: 2px;
}
#queueList td:nth-child(6){
    padding: 5px 0;
}
#admittedList td:nth-child(6){
    padding: 5px 2px;
}
#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
    text-decoration: none;
}
.name {
    color: #f26522;
}
.new-patient-header .identifiers {
    margin: 10px 0 0;
}
#tabs {
    background: #f9f9f9 none repeat scroll 0 0;
    margin-top: 10px;
}
#refresher {
    border: 1px none #88af28;
    color: #fff !important;
    float: right;
    margin-top: 5px;
}
#morgue-patients, #morgue-queue {
    display: none;
}
#morgue-patients:target, #morgue-queue:target {
    display: block;
}
.ke-panelbar{
    background: #f9f9f9 none repeat scroll 0 0;
}

#tabs {
    display: inline-block;
}

#tabs ul {
    /* For horizontal tabs, set the "display" property to "inline-block" */
    display: inline-block;
    margin: 0;
    padding: 0;
}

#tabs ul li {
    /* For horizontal tabs, set the "display" property to "inline-block" */
    display: inline-block;
    margin: 0;
    padding: 0;
    list-style-type: none;
}

#tabs ul li a {
    /* Add styles for tab links as needed */
    display: inline-block;
    padding: 10px 20px;
    text-decoration: none;
    border: 1px solid #ccc;
    border-radius: 5px 5px 0 0;
    background-color: #f9f9f9;
    color: #333;
}

#tabs ul li a:hover {
    /* Add hover styles for tab links as needed */
    background-color: #eee;
}

#tabs .ui-tabs-panel {
    /* Add styles for tab content panels as needed */
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 0 0 5px 5px;
    background-color: #f9f9f9;
    display: none; /* Hide tab content by default */
}

#tabs .ui-tabs-panel.ui-tabs-active {
    /* Show the active tab content */
    display: block;
}
</style>

<div class="example">
    <ul id="breadcrumbs">
        <li>
            <a href="link to home">
                <i class="icon-home small"></i></a>
        </li>

        <li>
            <i class="icon-chevron-right link"></i>
            <a href="">Morgue</a>
        </li>

        <li>
            <i class="icon-chevron-right link"></i>

        </li>
    </ul>
</div>

<div class="patient-header new-patient-header">
    <div class="demographics">
        <h1 class="name" style="border-bottom: 1px solid #ddd;">
            <span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
        </h1>
    </div>

    <div class="identifiers">
        <em>&nbsp; &nbsp; Patients:</em>
        <span> waiting</span>
    </div>

    <div class="identifiers">
        <em>Current Time:</em>
        <span>${date}</span>
    </div>

    <div class="clear"></div>

    <div id="tabs" style="margin-top: 40px!important;>
        <ul class="ke-panelbar">
            <li><a href="#morgue-patients">Admitted</a></li>
            <li><a href="#morgue-queue">Admission Queue</a></li>
            <li id="refresher" class="ui-state-default">
                <a class="button confirm" style="color:#fff">
                    <i class="icon-refresh"></i>
                    Refresh Patients
                </a>
            </li>
        </ul>

        <div id="morgue-patients">
            <table id="deadDetails">
                <thead>
                <tr>
                    <th>Person ID</th>
                    <th>Name</th>
                    <th>Date of Death</th>
                    <th>Cause of Death(Coded)</th>


                </tr>
                </thead>
                <tbody>
                <% deadList.each {%>
                <tr>
                    <td>${it.personId}</td>
                    <td>${it.names.givenName}</td>
                    <td>${it.deathDate}</td>
                    <td>${it.causeOfDeath.names.name}</td>

                </tr>

                <%}%>
                </tbody>
            </table>
        </div>

        <div id="morgue-queue">
            TO-DO
        </div>


    </div>
</div>