<script>
	export const prerender = true
	export const trailingSlash = 'always';

	import { Footer, FooterCopyright, NavBrand, NavHamburger, NavLi, NavUl, Navbar} from 'flowbite-svelte';
	import '../app.css';
	import { setContextClient } from '@urql/svelte';
	import { gqlClient } from '$graphql/client';
	const navLinks = [
		{ name: 'Index', href: '/' },
		{ name: 'About', href: '/about' }
	];

	setContextClient(gqlClient);
</script>

<section>
	<Navbar>
		<NavBrand href="/" class="flex items-center text-xl font-bold">
			CoolSoft
		</NavBrand>
		<NavHamburger />
		<NavUl>
			{#each navLinks as link}
				<NavLi><a href={link.href}>{link.name}</a></NavLi>
			{/each}
		</NavUl>
	</Navbar>
	<div class="w-full h-full bg-slate-50 dark:bg-slate-800 flex-grow">
		<slot />
	</div>
	<Footer class="h-12 flex justify-end items-center px-6">
		<FooterCopyright href="/" year={2023} />
	</Footer>
</section>

<style>
	section {
		display: flex;
		flex-direction: column;
		height: 100vh;
	}
</style>

