<%
    ui.decorateWith("kenyaemr", "standardPage")
    ui.includeCss("ehrconfigs", "referenceapplication.css")
%>
<script type="text/javascript">
  jq(function () {
    jq("#bodyDischarge").on("click", function (e) {
        e.preventDefault();
        console.log("Body discharge requested");
    });
  });
</script>



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
<div style="float: right;">
    <button id="bodyDischarge" class="cancel">
        <i class="icon-refresh"></i>
        Request Discharge
    </button>
</div>
<div class="ke-page-content">
	<table cellpadding="0" cellspacing="0" border="0" width="100%">
		<tr>
			<td width="30%" valign="top">
				${ ui.includeFragment("morgueapp", "morgueBio") }
			</td>

			<td width="55%" valign="top" style="padding-left: 5px">
				${ ui.includeFragment("morgueapp", "morgueServices") }
				${ ui.includeFragment("morgueapp", "morgueOfferedServices") }
			</td>
			<td width="15%" valign="top" style="padding-left: 5px">
				${ ui.includeFragment("morgueapp", "morgueUsefulLinks") }
			</td>
		</tr>
	</table>
</div>