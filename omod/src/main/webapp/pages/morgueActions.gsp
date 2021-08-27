<%
    ui.decorateWith("appui", "standardEmrPage", [title: "Morgue"])
    ui.includeJavascript("ehrcashier", "moment.js")
    ui.includeCss("ehrconfigs", "referenceapplication.css")
%>

<script>
    jq(function () {
        jq("#morgueActionsSubmitButton").on("click", function () {
            jq("#morgue-actions-form").submit();
            onsubmit(window.location.href="main.page")
        });

    });

</script>
<style>
.toast-item {
    background-color: #222;
}
.name {
    color: #f26522;
}
#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
    text-decoration: none;
}
.new-patient-header .demographics .gender-age {
    font-size: 14px;
    margin-left: -55px;
    margin-top: 12px;
}
.new-patient-header .demographics .gender-age span {
    border-bottom: 1px none #ddd;
}
.new-patient-header .identifiers {
    margin-top: 5px;
}
.tag {
    padding: 2px 10px;
}
.tad {
    background: #666 none repeat scroll 0 0;
    border-radius: 1px;
    color: white;
    display: inline;
    font-size: 0.8em;
    padding: 2px 10px;
}
.status-container {
    padding: 5px 10px 5px 5px;
}
.catg {
    color: #363463;
    margin: 35px 10px 0 0;
}
.print-only {
    display: none;
}
.button-group {
    display: inline-block;
    position: relative;
    vertical-align: middle;
}
.button-group > .button:first-child:not(:last-child):not(.dropdown-toggle) {
    border-bottom-right-radius: 0;
    border-top-right-radius: 0;
}
.button-group > .button:first-child {
    margin-left: 0;
}
.button-group > .button:hover, .button-group > .button:focus, .button-group > .button:active, .button-group > .button.active {
    z-index: 2;
}
.button-group > .button {
    border-radius: 5px;
    float: left;
    position: relative;
}
.button.active, button.active, input.active[type="submit"], input.active[type="button"], input.active[type="submit"], a.button.active {
    background: #d8d8d8 none repeat scroll 0 0;
    border-color: #d0d0d0;
}
.button-group > .button:not(:first-child):not(:last-child) {
    border-radius: 0;
}
.button-group > .button {
    border-radius: 5px;
    float: left;
    position: relative;
}
.button-group > .button:last-child:not(:first-child) {
    border-bottom-left-radius: 0;
    border-top-left-radius: 0;
}
.button-group .button + .button, .button-group .button + .button-group, .button-group .button-group + .button, .button-group .button-group + .button-group {
    margin-left: -1px;
}
ul.left-menu {
    border-style: solid;
}
.col15 {
    display: inline-block;
    float: left;
    max-width: 23%;
    min-width: 23%;
}
.col16 {
    display: inline-block;
    float: left;
    width: 730px;
}
#date-enrolled label {
    display: none;
}
.add-on {
    color: #f26522;
}
.append-to-value {
    color: #999;
    float: right;
    left: auto;
    margin-left: -200px;
    margin-top: 13px;
    padding-right: 55px;
    position: relative;
}
.menu-title span {
    display: inline-block;
    width: 75px;
}
span a:hover {
    text-decoration: none;
}
form label,
.form label {
    display: inline-block;
    padding-left: 10px;
    width: 140px;
}
form input,
form textarea,
.form input,
.form textarea {
    display: inline-block;
    min-width: 75%;
}
form select,
form ul.select,
.form select,
.form ul.select {
    display: inline-block;
    min-width: 73%;
}
#5596AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA label,
#1427AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA label {
    display: none;
}
form input:focus, form select:focus, form textarea:focus, form ul.select:focus, .form input:focus, .form select:focus, .form textarea:focus, .form ul.select:focus {
    outline: 2px none #007fff;
    box-shadow: 0 0 1px 0 #ccc !important;
}
form input[type="checkbox"], .form input[type="checkbox"] {
    margin-top: 4px;
    cursor: pointer;
}
#modal-overlay {
    background: #000 none repeat scroll 0 0;
    opacity: 0.4 !important;
}
ul.left-menu li {
    width: 200px;
}
.dashboard .info-header h3 {
    color: #f26522;
}
form input[type="radio"] {
    cursor: pointer;
    margin: 4px 5px 0 0;
    -webkit-appearance: checkbox;
    -moz-appearance: checkbox;
    -ms-appearance: checkbox;
}
</style>


<div class="clear"></div>

<div>
    <div class="example">
        <ul id="breadcrumbs">
            <li>
                <a href="${ui.pageLink('referenceapplication', 'home')}">
                    <i class="icon-home small"></i></a>
            </li>


            <li>
                <i class="icon-chevron-right link"></i>
            </li>
        </ul>
    </div>
</div>
<div class="ui-icon-person-header new-patient-header">
    <div class="demographics">
        <h1 class="name">
            <span id="surname"><em>surname</em></span>
            <span id="othname"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<em>other names</em>
            </span>

            <span class="gender-age">
                <span>

                </span>
                <span id="agename"></span>
            </span>
        </h1>

        <br/>
        <div id="stacont" class="status-container">
            <span class="status active"></span>
        </div>
        <div class="identifiers">
            <em>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Person ID</em>
            <br>

        </div>
</div>
</div>
<div style="min-width: 77%" class="col16 dashboard">
    <div class="info-header">
        <form method="post" id="morgue-actions-form">
            <i class="icon-group"></i>
            <h3>MORGUE ACTIONS</h3>
            <div class="info-body" style="padding-bottom: 15px"><div>
                <label><b>Body From Outside?</b></label>
                <label style="padding-left:0px; width: auto; cursor: pointer;">
                    <input type="radio" name="body_from_outside" value="1065AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA">
                    Yes
                </label>

                <label style="padding-left:0px; width: auto; cursor: pointer;">
                    <input type="radio" name="body_from_outside" value="1066AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA">
                    No
                </label><br/>
              </div>
                <div>
                    <label><b>Clean Gloves Given</b></label>
                    <label style="padding-left:0px; width: auto; cursor: pointer;">
                    <input type="checkbox"  value="832c8158-f9a8-459b-97db-ed13fe9380a9"/>
                </div>
                <div>
                    <label><b>Embalment Done</b></label>
                    <label style="padding-left:0px; width: auto; cursor: pointer;">
                    <input type="checkbox"  value="bb78fcee-99c8-4073-9224-69c668917405"/>
                </div>
                <div>
                    <label><b>Mortuary Daily Charges (Inside Body)</b></label>
                    <label style="padding-left:0px; width: auto; cursor: pointer;">
                    <input type="checkbox"  value="8fff43c6-96f8-46b4-8b00-c5110438bad0"/>
                </div>
                <div>
                    <label><b>Mortuary Daily Charges (Outside Body)</b></label>
                    <label style="padding-left:0px; width: auto; cursor: pointer;">
                    <input type="checkbox"  value="48d1569a-7525-41c1-a4da-17ef3c3368f9"/>
                </div>
                <div>
                    <label><b>Postmortem Done</b></label>
                    <label style="padding-left:0px; width: auto; cursor: pointer;">
                    <input type="checkbox"  value="f2a0e4f2-d1b4-4530-a087-90d82a69006b"/>
                </div>

            </div>

        </form>

        <div>
            <span class="button submit confirm right" id="morgueActionsSubmitButton" style="margin-top: 0px; margin-right: 30px;">
                <i class="icon-save"></i>
                Save
            </span>
        </div>
        </div>
</div>