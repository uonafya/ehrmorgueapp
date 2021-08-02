<script>
	var morgueQueue;
	var morgueQueueTableObject;
	var morgueQueueResultsData = [];
	
	var getMorgueQueue = function(){
		morgueQueueTableObject.find('td.dataTables_empty').html('<span><img class="search-spinner" src="'+ui.resourceLink('uicommons', 'images/spinner.gif')+'" /></span>');
		var requestData = {
			morgueWard:		'${morgueWard.id}',
			fromDate:		jq('#outsFrom-field').val(),
			toDate:			jq('#outsDate-field').val()
		}
		jq.getJSON('${ ui.actionLink("morgueapp", "MorgueAdmission", "listMorgueQueuePatients") }', requestData)
			.success(function (data) {
				console.log("I am dead but here"+ data)
				updateMorgueQueueResults(data);
			}).error(function (xhr, status, err) {
				updateMorgueQueueResults([]);
			}
		);
	};
	
	var updateMorgueQueueResults = function(results){
		morgueQueueResultsData = results || [];
		var dataRows = [];
		_.each(morgueQueueResultsData, function(result){
			var icons = '<div style="position: static" class="dropdown"><span class="dropdown-name"><i class="icon-cog"></i>Actions<i class="icon-sort-down"></i></span><ul><li><a href="admissionForm.page?admissionId='+result.id+'&morgueWard='+'${morgueWard.id}"><i class="icon-signin"></i>Admit</a></li><li><a class="remove-patient" data-idnt="'+result.id+'" data-action=1><i class="icon-remove"></i>Remove</a></li><li><a class="remove-patient" data-idnt="'+result.id+'" data-action=2><i class="icon-thumbs-down"></i>No bed</a></li></ul></div>';
			var gender = result.gender;			
			if (gender === "M"){
				gender = 'Male';
			}else{
				gender = 'Female';
			}
			dataRows.push([0, moment(result.admissionDate, "DD.MMM.YYYY").format('DD/MM/YYYY'), result.patientIdentifier, result.patientName, gender, icons]);
		});

		morgueQueue.api().clear();
		
		if(dataRows.length > 0) {
			morgueQueue.fnAddData(dataRows);
		}

		refreshInTable(morgueQueueResultsData, morgueQueue);
	};
	
	jq(function () {
		morgueQueueTableObject = jq("#queueList");

		morgueQueue = morgueQueueTableObject.dataTable({
			autoWidth: false,
			bFilter: true,
			bJQueryUI: true,
			bLengthChange: false,
			iDisplayLength: 25,
			sPaginationType: "full_numbers",
			bSort: false,
			sDom: 't<"fg-toolbar ui-toolbar ui-corner-bl ui-corner-br ui-helper-clearfix datatables-info-and-pg"ip>',
			oLanguage: {
				"sInfo": "Transactions",
				"sInfoEmpty": " ",
				"sZeroRecords": "No Patient's Found in Queue",
				"sInfoFiltered": "(Showing _TOTAL_ of _MAX_ Transactions)",
				"oPaginate": {
					"sFirst": "First",
					"sPrevious": "Previous",
					"sNext": "Next",
					"sLast": "Last"
				}
			},

			fnDrawCallback : function(oSettings){
				if(isTableEmpty(admissionQueueResultsData, morgueQueue)){
					return;
				}
			},
			
			fnRowCallback : function (nRow, aData, index){
				return nRow;
			}
		});
		
		morgueQueue.on( 'order.dt search.dt', function () {
			morgueQueue.api().column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
				cell.innerHTML = i+1;
			} );
		}).api().draw();
		
		jq('#outsNames').on('keyup', function () {
			morgueQueue.api().search( this.value ).draw();
		});
	
        jq(".stockoutParams").on('change', function () {
            getMorgueQueue();
        });
		
		jq('#queueList').on('click', 'a.remove-patient', function(){
			var requestData = {
				admissionId: jq(this).data('idnt'),
				action: jq(this).data('action')
			}
			
			jq.post('${ ui.actionLink("morgueapp", "MorgueAdmission", "removeOrNoBed") }', requestData)
				.success(function (data) {
					jq().toastmessage('message', "Successfully Updated Queue Patient Information");
					getAdmissionQueue();						
				}).error(function (xhr, status, err) {
					jq().toastmessage('messageerror', "AJAX error!" + err);
				}
			);			
		});
		
		getMorgueQueue();
	});
</script>

<table cellpadding="5" cellspacing="0" width="100%" id="queueList">
	<thead>
		<tr align="center">
			<th style="width: 5px">#</th>
			<th style="width: 100px">DATE</th>
			<th>IDENTIFICATION</th>
			<th>NAMES</th>
			<th style="width: 80px;">GENDER</th>
			<th style="width: 115px;">ACTION</th>
		</tr>
	</thead>
	<tbody>
	</tbody>	
</table>