import { Client, cacheExchange, fetchExchange } from "@urql/svelte";

const defaultHeaders = {};

export const gqlClient = new Client({
  url: "http://localhost:3000/graphql",
  exchanges: [cacheExchange, fetchExchange],
  fetchOptions: () => {
    const token = localStorage.getItem("token");

    if (token) {
      return {
        headers: {
          ...defaultHeaders,
          authorization: `Bearer ${token}`
        }
      };
    }
    return {
      headers: {...defaultHeaders},
    };
  },
});