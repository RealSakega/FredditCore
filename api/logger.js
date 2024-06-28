import { createLogger, format, transports as _transports } from 'winston';

// format: [timestamp] [level] message

const _format = format.combine(
    format.timestamp({
        format: 'YYYY-MM-DD HH:mm:ss'
    }),
    format.printf(info => `[${info.timestamp}] [${info.level}] ${info.message}`)
    );

const logger = createLogger({
  level: 'info',
  format: _format,
  defaultMeta: { service: 'user-service' },
  transports: [
    //
    // - Write all logs with importance level of `error` or less to `error.log`
    // - Write all logs with importance level of `info` or less to `combined.log`
    //
    new _transports.File({ filename: 'error.log', level: 'error' }),
    new _transports.File({ filename: 'combined.log' }),
  ],
});

//
// If we're not in production then log to the `console` with the format:
// `${info.level}: ${info.message} JSON.stringify({ ...rest }) `
//
if (process.env.NODE_ENV !== 'production') {
  logger.add(new _transports.Console({
    format: _format,
  }));
}

export { logger };