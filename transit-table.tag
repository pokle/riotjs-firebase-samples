
<!-- https://publicdata-transit.firebaseio.com/sf-muni -->
<transit-table>

    <p>{_.size(items)} vehicles</p>  
    <table>
        <thead>
        	<tr>
        		<th>id</th>
        		<th>lat</th>
        		<th>long</th>
        	</tr>
        </thead>
        <tbody>
        	<tr each={_.values(items)}>
        		<td>{id}</td>
        		<td>{lat}</td>
        		<td>{lon}</td>
        	</tr>
        </tbody>
    </table>

    <script>
    	var tag = this

    	tag.items = {}
    	
    	var fbVehicles = opts.firebase.orderByKey()

        updateData(snap) {
            tag.items[snap.key()] = snap.val()
            tag.update()
        }

    	fbVehicles.on('child_added', tag.updateData)
    	fbVehicles.on('child_changed', tag.updateData)
    	
    	fbVehicles.on('child_removed', function(snap) {
    		delete tag.items[snap.key()]
    		tag.update()
    	})

    </script>

</transit-table>
