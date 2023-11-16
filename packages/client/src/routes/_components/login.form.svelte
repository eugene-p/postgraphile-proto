<script>
	import { formDataToJson } from '$lib/formData';
	import LoginMutation from '$graphql/mutations/LoginMutation';
	import { getContextClient, mutationStore } from '@urql/svelte';
	import { Button, FloatingLabelInput, TabItem, Tabs } from 'flowbite-svelte';
	// @ts-ignore
	import { ArrowLeftToBracketOutline, FilePenOutline } from 'flowbite-svelte-icons';

	const client = getContextClient();

	/**
	 * @param EventHandler<SubmitEvent, HTMLFormElement> evt  form submit event
	 * @returns {void}
	 */
	const login = (evt) => {
		try {
			const { target } = evt;
			const loginData = new FormData(target);

			// @ts-ignore
			const loginUser = ({ email, password }) => {
				return mutationStore({
					client,
					query: LoginMutation,
					variables: { email, password }
				});
			};

			loginUser(formDataToJson(loginData));
		} catch (error) {
			console.log(error);
		}
	};

	/**
	 * @param EventHandler<SubmitEvent, HTMLFormElement> evt  form submit event
	 * @returns {void}
	 */
	const register = ({ target }) => {
		const registerData = new FormData(target);

		console.log('register', formDataToJson(registerData));
	};
</script>

<div class="w-full max-w-md mx-auto">
	<Tabs style="underline" defaultClass="flex flex-row flex-grow">
		<TabItem class="w-full" open defaultClass="w-full">
			<span slot="title">Login</span>
			<form class="flex flex-col space-y-6" on:submit|preventDefault={login}>
				<FloatingLabelInput label="Email" type="email" name="email">Email</FloatingLabelInput>
				<FloatingLabelInput label="Password" type="password" name="password"
					>Password</FloatingLabelInput
				>
				<Button type="submit" size="md">
					<ArrowLeftToBracketOutline class="w-4 h-4 mr-2" />
					Login
				</Button>
			</form>
		</TabItem>
		<TabItem class="w-full" defaultClass="w-full">
			<span slot="title">Register</span>
			<form class="flex flex-col space-y-6" on:submit={register}>
				<FloatingLabelInput label="Email" type="text" name="name">Name</FloatingLabelInput>
				<FloatingLabelInput label="Email" type="email" name="email">Email</FloatingLabelInput>
				<FloatingLabelInput label="Password" type="password" name="password"
					>Password</FloatingLabelInput
				>
				<Button type="submit" size="md">
					<FilePenOutline class="w-3.5 h-3.5 mr-2" />
					Register
				</Button>
			</form>
		</TabItem>
	</Tabs>
</div>
