<%
    ui.decorateWith("appui", "standardEmrPage", [title: "Morgue App"])
    ui.includeJavascript("ehrconfigs", "jquery-ui-1.9.2.custom.min.js")
    ui.includeCss("ehrconfigs", "datatables/dataTables_jui.css")
    ui.includeCss("ehrconfigs", "onepcssgrid.css")
    ui.includeJavascript("ehrconfigs", "underscore-min.js")
    ui.includeJavascript("ehrconfigs", "knockout-3.4.0.js")
    ui.includeJavascript("ehrconfigs", "emr.js")
    ui.includeJavascript("ehrconfigs", "jquery.simplemodal.1.4.4.min.js")
    ui.includeJavascript("ehrconfigs", "jquery.toastmessage.js")
    ui.includeJavascript("ehrconfigs", "jquery.dataTables.min.js")
    ui.includeJavascript("ehrconfigs", "jquery.dataTables.min.js")
    ui.includeJavascript("ehrconfigs", "moment.min.js")
    ui.includeCss("ehrconfigs", "jquery-ui-1.9.2.custom.min.css")
    ui.includeCss("ehrconfigs", "referenceapplication.css")
    ui.includeCss("uicommons", "datatables/dataTables_jui.css")
    ui.includeCss("ehrconfigs", "jquery.toastmessage.css")
%>

<script>
   jQuery(function (){
      jQuery("#deadDetails").DataTable();
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


    <script type="text/javascript">
        jQuery(function() {
            jQuery('input[name="query"]').focus();
        });
    </script>

    <div class="identifiers">
        <em>Current Time:</em>
        <span>${date}</span>
    </div>

    <div class="clear"></div>

    <div id="tabs">
        <ul>
            <li id="refresher" class="ui-state-default">
                <a class="button confirm" style="color:#fff">
                    <i class="icon-refresh"></i>
                    Refresh Patients
                </a>
            </li>
        </ul>


            <table cellpadding="5" cellspacing="0" width="100%" id="deadDetails">
                <thead>
                <tr>
                    <th>Date of Death</th>
                    <th>Person ID</th>
                    <th>Names</th>
                    <th>Gender</th>
                    <th>Cause of Death</th>
                </tr>
                </thead>
                <tbody>
                <% deadList.each {%>
                <tr>
                    <td>${it.deathDate}</td>
                    <td>${it.personId}</td>
                    <td>${it.names.givenName}${it.names.middleName}${it.names.familyName}</td>
                    <td>${it.gender}</td>
                    <td>${it.causeOfDeath.name}</td>
                </tr>
                <%}%>
                </tbody>
            </table>

    </div>
</div>