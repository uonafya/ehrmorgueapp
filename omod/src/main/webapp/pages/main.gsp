<%
    ui.decorateWith("kenyaemr", "standardPage")
    ui.includeJavascript("ehrconfigs", "jquery.dataTables.min.js")
    ui.includeJavascript("ehrconfigs", "emr.js")
    ui.includeJavascript("ehrconfigs", "jquery.simplemodal.1.4.4.min.js")
    ui.includeCss("ehrconfigs", "jquery.dataTables.min.css")
    ui.includeCss("ehrconfigs", "referenceapplication.css")
    ui.includeCss("ehrconfigs", "onepcssgrid.css")
    ui.includeCss("ehrconfigs", "custom.css")
%>


<script type="text/javascript">
    jq(function () {
        jq("#dtabs").tabs();
        var tbl = jq("#deadDetails").DataTable();
        var enrollBodyDialog = emr.setupConfirmationDialog({
            dialogOpts: {
                overlayClose: false,
                close: true
            },
            selector: '#enroll-body-details-dialog',
            actions: {
                confirm: function () {
                    jq.getJSON('${ui.actionLink("morgueapp", "morgueDetail", "enrollBodyDetails")}',
                        {
                            'countyCode': jq("#countyCode").val().trim(),
                            'countyName': jq("#countyName").val().trim(),
                            'website': jq("#website").val().trim(),
                            'address': jq("#address").val(),
                            'email': jq("#email").val(),
                            'phone': jq("#phone").val(),
                        }
                    ).success(function (data) {
                        enrollBodyDialog.close();
                        location.reload();
                    });
                },
                cancel: function () {
                    enrollBodyDialog.close();
                }
            }
        });

        var admitBodyDialog = emr.setupConfirmationDialog({
            dialogOpts: {
                overlayClose: false,
                close: true
            },
            selector: '#admit-body-details-dialog',
            actions: {
                confirm: function () {
                    jq.getJSON('${ui.actionLink("morgueapp", "morgueDetail", "admitBodyDetails")}',
                        {
                            'patientName': jq("#patientName").val().trim(),
                            'dateOfDeath': jq("#dateOfDeath").val().trim(),
                            'dateOfAdmission': jq("#dateOfAdmission").val().trim(),
                            'receivedBy': jq("#receivedBy").val(),
                            'propertyWithBody': jq("#propertyWithBody").val(),
                            'identificationTagNo': jq("#identificationTagNo").val(),
                            'broughtBy': jq("#broughtBy").val(),
                            'compartment': jq("#compartment").val(),
                            'consent': jq("#consent").val(),
                        }
                    ).success(function (data) {
                        admitBodyDialog.close();
                        location.reload();
                    });
                },
                cancel: function () {
                    admitBodyDialog.close();
                }
            }
        });

        jq("#refresher").on("click", function (e) {
            e.preventDefault();
            enrollBodyDialog.show();
        });
        jq("#enrollBtn").on("click", function(e) {
            e.preventDefault();
            admitBodyDialog.show();
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
        <em>&nbsp; &nbsp; Capacity:</em>
        <span>x/y</span>
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
    <div style="float: right;">
        <button id="refresher" class="confirm">
            <i class="icon-refresh"></i>
            Enroll Body
        </button>
    </div>

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
                <th>Actions</th>


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
                <td>
                  <button id="enrollBtn" class="task">Admit</button>
                </td>

            </tr>

            <%}%>
            </tbody>
        </table>
    </div>

    <div id="morgue-queue">
        ${ ui.includeFragment("morgueapp", "morgueQueue") }
    </div>
</div>
<div id="enroll-body-details-dialog" class="dialog" style="display:none;">
    <div class="dialog-header">
        <i class="icon-folder-open"></i>

        <h3>Admit Brought In Body</h3>
    </div>
    <div class="dialog-content">
        <ul>
            <li>
                <label>Unit Name<span style="color:red">*</span></label>
                <input type="text" name="morgueName" id="morgueName" style="width: 90%!important;" />
            </li>
            <li>
                <label>Capacity<span style="color:red">*</span></label>
                <input type="number" name="strength" id="strength"/>
            </li>
            <li>
                <label>Status<span style="color:red">*</span></label>
                <select id="retired" name="retired">
                    <option value="0">Active</option>
                    <option value="1">Inactive</option>
                </select>
            </li>
            <li>
                <label>Description<span style="color:red;">*</span></label>
                <textarea name="description" id="description" style="width: 90%!important;" cols="30" rows="4">
                </textarea>

            </li>
        </ul>
    </div>
    <div class="onerow">
        <button class="button confirm right">Confirm</button>
        <button class="button cancel">Cancel</button>
    </div>
</div>

<div id="admit-body-details-dialog" class="dialog">
    <div class="dialog-header">
        <i class="icon-folder-open"></i>

        <h3>Admit New Body</h3>
    </div>
    <div class="dialog-content">
        <table>
            <tr>
                <td>
                    <label for="patientName">Patient Name<span>*</span></label>
                </td>
                <td>
                    <input type="text" name="patientName" id="patientName">
                </td>
            </tr>
            <tr>
                <td><label for="dateOfDeath">Date Of Death<span>*</span></label></td>
                <td><input type="datetime-local" name="dateOfDeath" id="dateOfDeath"></td>
            </tr>

            <tr>
                <td><label>Admitted From<span>*</span></label></td>
                <td><select data-bind="options: \$root.inpatientWards, optionsText: 'label', value: admitTo" style="width: 400px !important; float: right;"></select></td>
            </tr>

            <tr>
                <td><label for="dateOfAdmission">Date Of Admission<span>*</span></label></td>
                <td><input type="datetime-local" name="dateOfAdmission" id="dateOfAdmission"></td>
            </tr>
            <tr>
                <td><label for="admittedUnit">Admitted Unit<span>*</span></label></td>
                <td><input name="admittedUnit" id="admittedUnit" type="text"></td>

            </tr>

            <tr>
                <td><label for="receivedBy">Received By</label></td>
                <td> <input name="receivedBy" id="receivedBy" type="text"></td>
            </tr>

            <tr>
                <td><label for="propertyWithBody">Property With Body</label></td>
                <td><input name="propertyWithBody" id="propertyWithBody" type="text"></td>
            </tr>

            <tr>
                <td><label for="identificationTagNo">Identification Tag No<span>*</span></label></td>
                <td><input name="identificationTagNo" id="identificationTagNo" type="text"></td>
            </tr>

            <tr>
                <td><label for="broughtBy">Brougth By<span>*</span></label></td>
                <td><input name="broughtBy" id="broughtBy" type="text"></td>
            </tr>

            <tr>
                <td><label for="compartment">Compartment<span>*</span></label></td>
                <td><input name="compartment" id="compartment" type="text"></td>

            </tr>

            <tr>
                <td> <label>Consent<span style="color:red;">*</span></label></td>
                <td><textarea name="consent" id="consent" style="width: 90%!important;" cols="30" rows="4">
                </textarea></td>
            </tr>

        </table>
    </div>
    <div class="onerow">
        <button class="button confirm right">Confirm</button>
        <button class="button cancel">Cancel</button>
    </div>
</div>