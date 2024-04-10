import sentry_sdk

sentry_sdk.init(
    dsn="https://6dca7e7ffe6ce81d13624dfa62983581@o4507061067907072.ingest.us.sentry.io/4507061452865536",
    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    traces_sample_rate=1.0,
    # Set profiles_sample_rate to 1.0 to profile 100%
    # of sampled transactions.
    # We recommend adjusting this value in production.
    profiles_sample_rate=1.0,
)

