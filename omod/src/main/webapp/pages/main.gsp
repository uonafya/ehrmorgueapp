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
        var tbl1 = jq("#admittedBodies").DataTable();
        var tbl2 = jq("#dischargedBodies").DataTable();
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
                            firstName: jq("#firstName").val(),
                            middleName: jq("#middleName").val(),
                            lastName: jq("#lastName").val(),
                            sex: jq("#sex").val(),
                            strength: jq("#strength").val(),
                            dateOfBirth: jq("#dateOfBirth-field").val(),
                            maritalStatus: jq("#maritalStatus").val(),
                            deathDate: jq("#deathDate").val(),
                            placeOfDeath: jq("#placeOfDeath").val(),
                            diagnosis: jq("#diagnosis").val(),
                            description: jq("#description").val(),
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
                    var formulations = jq("#admittedUnit").val();
                    jq.getJSON('${ui.actionLink("morgueapp", "morgueDetail", "admitBodyDetails")}',
                        {
                            'patient': jq("#patient").val().trim(),
                            'dateOfDeath': jq("#dateOfDeath").val().trim(),
                            'bodyType': jq("#bodyType").val().trim(),
                            'dateOfAdmission': jq("#summaryAdmissionDate-field").val().trim(),
                            'receivedBy': jq("#receivedBy").val(),
                            'propertyWithBody': jq("#propertyWithBody").val(),
                            'identificationTagNo': jq("#identificationTagNo").val(),
                            'broughtBy': jq("#broughtBy").val(),
                            'compartmentNo': jq("#compartmentNo").val(),
                            'consent': jq("#consent").val(),
                            'patientId':jq("#patientId").val(),
                            'admittedUnit':jq("#multiple").val()
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
        jq('#deadDetails tbody').on('click', 'tr', function () {
            var info = tbl.row(this).data();
            console.log("The id we are looking for ", info);
            jq("#patient").val(info[2])
            jq("#dateOfDeath").val(info[3])
            jq("#patientId").val(info[0])
            jq("#queueId").val(info[7]);
            admitBodyDialog.show();
        });
        jq('#admittedBodies tbody').on('click', 'tr', function () {
            var info = tbl1.row(this).data();
            ui.navigate('morgueapp', 'bodyManagement', {identifier: info[0]});
        });
        jq('#dischargedBodies tbody').on('click', 'tr', function () {
                    var info = tbl1.row(this).data();
                    ui.navigate('morgueapp', 'bodyManagementChart', {identifier: info[0]});
                });
    });
    jq.getJSON('${ ui.actionLink("morgueapp", "MorgueDetail", "fetchUnitDetails")}',
        {
        }
    ).success(function (data) {
        for (var index = 0; index <= data.length; index++) {
            jq('#admittedUnit').append('<option value="' + data[index].ehrMorgueStrengthId + '">' + data[index].morgueName + '-' + data[index].strength + '</option>');
        }
    });
    jq(function () {
        jq("#diagnosis").on("focus.autocomplete", function () {
            jq(this).autocomplete({
                source: function (request, response) {
                    jq.getJSON('${ ui.actionLink("patientdashboardapp", "clinicalNotes", "getDiagnosis") }', {
                        q: request.term
                    }).success(function (data) {
                        console.log(data);
                        var results = [];
                        for (var i in data) {
                            var result = {
                                label: data[i].name,
                                value: data[i].uuid
                            };
                            results.push(result);
                        }
                        response(results);
                    });
                },
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    jq(this).val(ui.item.label);
                }
            });
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
        <em>&nbsp; &nbsp; Departments:</em>
        <span>${capacity}</span>
    </div>

    <div class="identifiers">
        <em>Current Time:</em>
        <span>${date}</span>
    </div>
    <div class="clear"></div>
</div>
<div id="dtabs">
    <div style="float: right;">
        <button id="refresher" class="confirm">
            <i class="icon-refresh"></i>
            Enroll Body
        </button>
    </div>
    <ul>
        <li><a href="#morgue-patients">Admission Queue</a></li>
        <li><a href="#morgue-queue">Admitted Bodies</a></li>
        <li><a href="#morgue-discharge">Discharged Bodies</a></li>
    </ul>
    <div id="morgue-patients">
        <table id="deadDetails">
            <thead>
            <tr>
                <th style="display: none">patient_id</th>
                <th>Identifier</th>
                <th>Names</th>
                <th>Date and Time of Death</th>
                <th>Cause of Death(Coded)</th>
                <th>Created by</th>
                <th>Date Created</th>
                <th style="display: none">Queue ID</th>


            </tr>
            </thead>
            <tbody>
            <% deadList.each {%>
            <tr>
                <td style="display: none">${it.patientId}</td>
                <td>${it.identifier}</td>
                <td>${it.names}</td>
                <td>${it.dateAndTimeOfDeath}</td>
                <td>${it.causeOfDeath}</td>
                <td>${it.createdBy}</td>
                <td>${it.dateCreated}</td>
                <td style="display: none">${it.queueId}</td>

            </tr>

            <%}%>
            </tbody>
        </table>
    </div>

    <div id="morgue-queue">
        ${ ui.includeFragment("morgueapp", "morgueQueue") }
    </div>
    <div id="morgue-discharge">
            ${ ui.includeFragment("morgueapp", "dischargedBodies") }
    </div>
</div>
<div id="enroll-body-details-dialog" class="dialog" style="display:none;  height: auto !important; width: auto !important;">
    <div class="dialog-header">
        <i class="icon-folder-open"></i>

        <h3>Admit Brought In Body</h3>
    </div>
    <div class="dialog-content">
        <table>
            <tr>
                <td><label>First Name<span style="color:red">*</span></label></td>
                <td><input type="text" name="firstName" id="firstName" style="width: 90%!important;" /></td>
            </tr>
            <tr>
                <td><label>Middle Name<span style="color:red">*</span></label></td>
                <td><input type="text" name="middleName" id="middleName" style="width: 90%!important;" /></td>
            </tr>
            <tr>
                <td><label>Last Name</label></td>
                <td><input type="text" name="lastName" id="lastName" style="width: 90%!important;" /></td>
            </tr>
            <tr>
                <td><label>Sex<span style="color:red">*</span></label></td>
                <td><select id="sex" name="sex">
                    <option selected>Select Option</option>
                    <option value="0">Male</option>
                    <option value="1">Female</option>
                </select></td>

            </tr>
            <tr>
                <td><label>Age<span style="color:red">*</span></label></td>
                <td><input type="number" name="strength" id="strength"/></td>
            </tr>
            <tr>
                <td><label>Date Of Birth<span>*</span></label></td>
                <td>${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'dateOfBirth', id: 'dateOfBirth', label: '', useTime: false, defaultToday: true, class: ['newdtp']])}
            </td>

            </tr>
            <tr>
                <td><label>Marital Status<span style="color:red">*</span></label></td>
                <td><select id="maritalStatus" name="maritalStatus">
                    <option selected>Select Option</option>
                    <option value="1">Married Polygamous</option>
                    <option value="2">Married Monogamous</option>
                    <option value="3">Divorced</option>
                    <option value="4">Widowed</option>
                    <option value="5">Cohabiting</option>
                    <option value="6">Single</option>
                </select></td>
            </tr>
            <tr>
                <td><label for="deathDate">Date Of Death<span>*</span></label></td>
                <td><input type="datetime-local" name="deathDate" id="deathDate"></td>
            </tr>
            <tr>
                <td><label>Place Of Death<span style="color:red">*</span></label></td>
                <td><input type="text" name="placeOfDeath" id="placeOfDeath" style="width: 90%!important;" /></td>
            </tr>
            <tr>
                <td><label>Cause of death <span class="important">*</span></label></td>
                <td class="input-position-class">
                    <input type="text" id="diagnosis" name="diagnosis" placeholder="Select Diagnosis" size="60" />
                </td>
            </tr>
            <tr>
                <td><label>Notes<span style="color:red;">*</span></label></td>
                <td><textarea name="description" id="description" style="width: 90%!important;" cols="30" rows="4">
                </textarea>
                </td>

            </tr>
        </table>
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
    <input type="text"  name="queueId" name="queueId" />
        <table>
            <input style="display: none" id="patientId">
            <tr>
                <td>
                    <label for="patient">Patient Name<span>*</span></label>
                </td>
                <td>
                    <input type="text" name="patient" id="patient">
                </td>
            </tr>
            <tr>
                <td><label for="dateOfDeath">Date Of Death<span>*</span></label></td>
                <td><input type="datetime-local" name="dateOfDeath" id="dateOfDeath"></td>
            </tr>

            <tr>
                <td><label for="bodyType">Admitted From<span>*</span></label></td>
                <td><input type="text" name="bodyType" id="bodyType"></td>
            </tr>

            <tr>
                <td><label>Date Of Admission<span>*</span></label></td>
                <td>${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'dateOfAdmission', id: 'summaryAdmissionDate', label: '', useTime: true, defaultToday: true, class: ['newdtp']])}
                </td>
            </tr>
            <tr>
                <td><label>Admitted Unit<span>*</span></label></td>
                <td><select name="admittedUnit" id="admittedUnit"></select></td>
            </tr>

            <tr>
                <td><label for="receivedBy">Attendant On Call</label></td>
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
                <td><label for="broughtBy">Brought By<span>*</span></label></td>
                <td><input name="broughtBy" id="broughtBy" type="text"></td>
            </tr>

            <tr>
                <td><label for="compartmentNo" style="width: 100px; display: inline-block;">Compartment Number:</label></td>
                <td><input id="compartmentNo" type="text" name="compartmentNo" style="min-width: 250px;" placeholder="Select Compartment number"></td>
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