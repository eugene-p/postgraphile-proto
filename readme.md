# Starting
Run `docker compose up`

# Using
goto localhost http://localhost:3000/graphiql
execute authorize mutation with one of

* u:john.doe@example.com p:password
* u:alice.smith@example.com p:password
* u:bob.brown@example.com p:password

Add auth header

```json
{
"Authorization": "Bearer <jwt returned by auth>"
}


```

Try to query allProfiles

# postgres
is accessible on default port on local host use pgadmin to research