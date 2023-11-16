<script>
	import { Button, FloatingLabelInput } from 'flowbite-svelte';
	import { FilePenOutline } from 'flowbite-svelte-icons';

	/**
	 * @param EventHandler<SubmitEvent, HTMLFormElement> evt  form submit event
	 * @returns {void}
	 */
	const register = ({ target }) => {
		const registerData = new FormData(target);

		console.log('register', formDataToJson(registerData));
	};
</script>

<form class="flex flex-col space-y-6" on:submit={register}>
	<FloatingLabelInput label="Email" type="text" name="name">Name</FloatingLabelInput>
	<FloatingLabelInput label="Email" type="email" name="email">Email</FloatingLabelInput>
	<FloatingLabelInput label="Password" type="password" name="password">Password</FloatingLabelInput>
	<Button type="submit" size="md">
		<FilePenOutline class="w-3.5 h-3.5 mr-2" />
		Register
	</Button>
</form>
