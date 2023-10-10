<%
    ui.decorateWith("kenyaemr", "standardPage")
    ui.includeCss("ehrconfigs", "referenceapplication.css")
%>
<div class="example">
    <ul id="breadcrumbs">
        <li>
            <a href="link to home">
                <i class="icon-home small"></i></a>
        </li>

        <li>
            <i class="icon-chevron-right link"></i>
            <a href="#">Morgue</a>
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
        <em>&nbsp; &nbsp; Identifier:</em>
        <span>${morgueID}</span>
    </div>

    <div class="identifiers">
        <em>Deceased</em>
        <span>${deceasedDate}</span>
    </div>
    <div class="clear"></div>
</div>