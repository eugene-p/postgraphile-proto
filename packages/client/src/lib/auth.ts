import LoginMutation from "$graphql/mutations/LoginMutation";
import { Client, mutationStore } from "@urql/svelte";

let authToken: string = '';

export const getAuthHeader = (): string => `Bearer ${authToken}`;
export const setAuthToken = (token: string): string => (authToken = token);
export const getAuthToken = (): string => authToken;

export const loginUser = async (
  email: string,
  password: string,
  gqlClient: Client) => {
  return mutationStore({
    client: gqlClient,
    query: LoginMutation,
    variables: { email, password }
  });
};