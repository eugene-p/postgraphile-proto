import 'dotenv/config'
import Fastify from 'fastify'
import {
  postgraphile,
  PostGraphileResponseFastify3
} from 'postgraphile'

const {
  DB_HOST,
  DB_PORT,
  DB_USER,
  DB_PASSWORD,
  DB_NAME,
  JWT_TOKEN_IDENTIFIER,
  JWT_SECRET,
  POSTGRAPHILE_GRAPHIQL_ENABLED,
  POSTGRAPHILE_PORT
} = process.env

const DB_URL = `postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}`

const middleware = postgraphile(DB_URL, ['app_public', 'app_private'], {
  watchPg: true,
  graphiql: true,
  enhanceGraphiql: true,
  jwtSecret: JWT_SECRET,
  jwtPgTypeIdentifier: `${JWT_TOKEN_IDENTIFIER}`,
  dynamicJson: true,
  pgDefaultRole: 'anonymous_user',
  dynamicJson: true,
  setofFunctionsContainNulls: false,
  ignoreRBAC: false,
  enableCors: true,
})

const fastify = Fastify({ logger: true })

const convertHandler = (handler) => (request, reply) => {
  handler(new PostGraphileResponseFastify3(request, reply))
}

fastify.options(
  middleware.graphqlRoute,
  convertHandler(middleware.graphqlRouteHandler)
)
fastify.post(
  middleware.graphqlRoute,
  convertHandler(middleware.graphqlRouteHandler)
)

const isTrue = (value) => value === 'true' || value === '1' || value === true

if (isTrue(POSTGRAPHILE_GRAPHIQL_ENABLED)) {
  if (middleware.graphiqlRouteHandler) {
    fastify.head(
      middleware.graphiqlRoute,
      convertHandler(middleware.graphiqlRouteHandler)
    )
    fastify.get(
      middleware.graphiqlRoute,
      convertHandler(middleware.graphiqlRouteHandler)
    )
  }
}

if (middleware.options.watchPg) {
  if (middleware.eventStreamRouteHandler) {
    fastify.options(
      middleware.eventStreamRoute,
      convertHandler(middleware.eventStreamRouteHandler)
    )
    fastify.get(
      middleware.eventStreamRoute,
      convertHandler(middleware.eventStreamRouteHandler)
    )
  }
}

fastify.listen({
  port: POSTGRAPHILE_PORT,
  host: '0.0.0.0'
}, (err, address) => {
  if (err) {
    fastify.log.error(String(err))
    process.exit(1)
  }
  fastify.log.info(
    `PostGraphiQL available at ${address}${middleware.graphiqlRoute} 🚀`
  )
})
