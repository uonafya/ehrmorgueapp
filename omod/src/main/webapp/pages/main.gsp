<%
    ui.decorateWith("kenyaemr", "standardPage")
    ui.includeJavascript("ehrconfigs", "jquery.dataTables.min.js")
    ui.includeCss("ehrconfigs", "jquery.dataTables.min.css")
    ui.includeCss("ehrconfigs", "referenceapplication.css")
%>


<script type="text/javascript">
    jq(document).ready(function () {
        jq("#dtabs").tabs();
        jq("#deadDetails").DataTable();
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
</div>

<div id="dtabs">
    <ul>
        <li><a href="#morgue-patients">Admission Queue</a></li>
        <li><a href="#morgue-queue">Admitted Bodies</a></li>
    </ul>

    <div id="morgue-patients">
        <table id="deadDetails">
            <thead>
            <tr>
                <th>Identifier</th>
                <th>Names</th>
                <th>Date and Time of Death</th>
                <th>Cause of Death(Coded)</th>
                <th>Created by</th>
                <th>Date Created</th>


            </tr>
            </thead>
            <tbody>
            <% deadList.each {%>
            <tr>
                <td>${it.identifier}</td>
                <td>${it.names}</td>
                <td>${it.dateAndTimeOfDeath}</td>
                <td>${it.causeOfDeath}</td>
                <td>${it.createdBy}</td>
                <td>${it.dateCreated}</td>

            </tr>

            <%}%>
            </tbody>
        </table>
    </div>

    <div id="morgue-queue">
        ${ ui.includeFragment("morgueapp", "morgueQueue") }
    </div>
</div>