import { gql } from '@urql/svelte';
export default gql`mutation UserLogin ($email: String!, $password: String!) {
  authorize(input: {pwd: $password, authemail: $email}) {
    jwtToken
  }
}`;