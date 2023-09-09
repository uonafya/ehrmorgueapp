<script>
    var jq = jQuery;
    jq(function () {
        jq('#unitsTable').DataTable();
    });
</script>
<table id="unitsTable">
    <thead>
    <tr>
        <th>Unit Name</th>
        <th>Description</th>
        <th>Capacity</th>
        <th>Status</th>
    </tr>
    </thead>
    <tbody>
    <% units.each { %>
    <tr>
        <td>${it.morgueName}</td>
        <td>${it.description}</td>
        <td>${it.strength}</td>
        <td>${(it.retired)?"Inactive":"Active"}</td>
    </tr>
    <%}%>
    </tbody>
</table>