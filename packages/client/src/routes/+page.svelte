<script>
	import { TabItem, Tabs } from 'flowbite-svelte';
	import LoginForm from './_components/login.form.svelte';
	import RegisterForm from './_components/register.form.svelte';
</script>

<div class="w-full max-w-md mx-auto">
	<Tabs style="underline" defaultClass="flex flex-row flex-grow">
		<TabItem class="w-full" open defaultClass="w-full">
			<span slot="title">Login</span>
				<LoginForm />
		</TabItem>
		<TabItem class="w-full" defaultClass="w-full">
			<span slot="title">Register</span>
				<RegisterForm />
		</TabItem>
	</Tabs>
</div>

