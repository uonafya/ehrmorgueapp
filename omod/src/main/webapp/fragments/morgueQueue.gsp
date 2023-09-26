<div id="morgue-admitted-bodies">
        <table id="admittedBodies">
            <thead>
            <tr>
              <th>Identification #</th>
              <th>Compartment #</th>
              <th>Names</th>
              <th>Date of admission</th>
              <th>Date of death</th>
              <th>Received by</th>
              <th>Body type</th>
            </tr>
            </thead>
            <tbody>
            <% admittedList.each {%>
            <tr>
              <td>${it.identificationTagNo}</td>
              <td>${it.compartmentNo}</td>
              <td>${it.patient.person.personName}</td>
              <td>${it.dateOfAdmission}</td>
              <td>${it.dateOfDeath}</td>
              <td>${it.receivedBy}</td>
              <td>${it.bodyType}</td>
            </tr>
            <%}%>
            </tbody>
        </table>
    </div>