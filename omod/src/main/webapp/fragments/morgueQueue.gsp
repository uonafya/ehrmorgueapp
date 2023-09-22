<div id="morgue-admitted-bodies">
        <table id="admittedBodies">
            <thead>
            <tr>
              <td>Test</td>
            </tr>
            </thead>
            <tbody>
            <% admittedList.each {%>
            <tr>
              <td>${it}</td>
            </tr>
            <%}%>
            </tbody>
        </table>
    </div>