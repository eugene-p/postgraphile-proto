<script>
	import { loginUser, setAuthToken } from '$lib/auth';
	import { formDataToJson } from '$lib/formData';
	import { Alert, Button, FloatingLabelInput, Spinner } from 'flowbite-svelte';
	import { ArrowLeftToBracketOutline } from 'flowbite-svelte-icons';

	import {  getContextClient } from '@urql/svelte';
	import { goto } from '$app/navigation';
	const client = getContextClient();

	$: loginFetching = false;
	$: loginError = undefined;
	$: resultData = null;

	$: if (resultData?.authorize?.jwtToken) {
		setAuthToken(resultData.authorize.jwtToken);
		goto('/about');
	}

	const login = async (evt) => {
		try {
			const { target } = evt;
			const loginData = formDataToJson(new FormData(target));

			const login = await loginUser(
				loginData.email.toString(),
				loginData.password.toString(),
				client
			);

			login.subscribe(
				(result) => {
					loginFetching = result.fetching;
					loginError = result.error;
					resultData = result.data;
				},
				(error) => {
					console.log(error, 'error');
				}
			);

		} catch (error) {
			console.log(error);
		}
	};
</script>


{#if loginFetching}
	<Spinner />
{:else}
	<form class="flex flex-col space-y-6" on:submit|preventDefault={login}>
		{#if loginError}
			<Alert color="red">
				{loginError.message.replace('[GraphQL] ', '')}
			</Alert>
		{/if}
		<FloatingLabelInput label="Email" type="email" name="email">Email</FloatingLabelInput>
		<FloatingLabelInput label="Password" type="password" name="password"
			>Password</FloatingLabelInput
		>
		<Button type="submit" size="md">
			<ArrowLeftToBracketOutline class="w-4 h-4 mr-2" />
			Login
		</Button>
	</form>
{/if}
