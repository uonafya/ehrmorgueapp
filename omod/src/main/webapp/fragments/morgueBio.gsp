<%
	ui.decorateWith("kenyaui", "panel", [ heading: "Information", frameOnly: true ])
%>
<div class="ke-panel-content">
    <div class="ke-stack-item">
      <% morgueAdmission.each { key, value -> %>
      		${ ui.includeFragment("kenyaui", "widget/dataPoint", [ label: ui.format(key), value: value ]) }
      <% } %>
    </div>
</div>
