<%
	ui.decorateWith("kenyaui", "panel", [ heading: "Available Services", frameOnly: true ])
%>
<div class="ke-panel-content">
    <div class="ke-stack-item">
      <% services.each { key, value -> %>
          <input type="checkbox" id="morgueService" name="morgueService" value=${key} />${value}
      <% } %>
    </div>
</div>