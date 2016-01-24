<firebase-auth>
<div>
	<div class="state">{this.state.name}</div>
	<div class="error">{this.state.error}</div>

	<div show={ this.state.name == 'unauthenticated' }>
		<form onsubmit={login}>
			<input id="email"    type="email" 	required value="">
			<input id="password" type="password"  required value=""> 
			<input               type="submit"    value="Login">
		</form>
	</div>	

	<div show={ this.state.name == 'authenticated' }>
		<button onclick={logout}>Logout</button>
	</div>
</div>

<script>
	var self = this
	this.state = {name: "unknown"}

	logout(event) {
		this.opts.firebase.unauth()
		this.state = {name: "unauthenticated"}
	}

	login(event) {
		event.preventDefault()

		this.state = {name: "authenticating"}
		this.update()

		this.opts.firebase
			.authWithPassword({email: this.email.value, password: this.password.value})
			.then(function(authData) {
					self.state = {name: "authenticated", authData: authData}
					self.update()			    
				  },
				  function(error) {
					self.state = {name: "unauthenticated", error: error}
					self.update()
				  })
	}

	init() {
		this.state = {name: "unknown"}
		this.update()

		var authData = this.opts.firebase.getAuth()
		console.log(authData)
		if (authData === null) {
			this.state = {name: "unauthenticated"}
		} else {
			this.state = {name: "authenticated", authData: authData}
		}
		this.update()
		
	}

	this.init()

</script>



</firebase-auth>