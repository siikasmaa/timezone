#!/usr/bin/env coffee
require("../proof") 18, ({ tz, utc }) ->
  str = (epoch) -> new Date(epoch).toString()
  tz.timezones require "./../data/northamerica"
  @equal tz(utc(1976, 6, 4), "America/Detroit", "%F %T"), "1976-07-03 20:00:00",
         "convert from UTC to America/Detroit during DST"
  @equal tz("2010-03-12T03:00:00", "America/Detroit"), utc(2010, 02, 12, 8),
         "convert from America/Detroit to UTC before first day of DST"
  @equal tz("2010-03-15T03:00:00", "America/Detroit"), utc(2010, 02, 15, 7),
         "convert from America/Detroit to UTC after first day of DST"
  @equal tz("2010-03-14T03:00:00", "America/Detroit"), utc(2010, 02, 14, 7),
         "convert from America/Detroit to UTC during DST"
  @equal tz("2010-03-14T01:00:00", "America/Detroit"), utc(2010, 02, 14, 6),
         "convert from America/Detroit to UTC"

  # "test: convert to America/Detroit at end of DST": (done) ->
  @equal tz(utc(2010, 10, 7, 4), "America/Detroit", "%F %T"), "2010-11-07 00:00:00",
         "midnight before fall back"
  @equal tz(utc(2010, 10, 7, 4, 59), "America/Detroit", "%F %T"), "2010-11-07 00:59:00",
         "minute before an hour before fall back"
  @equal tz(utc(2010, 10, 7, 5), "America/Detroit", "%F %T"), "2010-11-07 01:00:00",
         "hour before fall back"
  @equal tz(utc(2010, 10, 7, 5, 59), "America/Detroit", "%F %T"), "2010-11-07 01:59:00",
         "minute before fall back"
  @equal tz(utc(2010, 10, 7, 6), "America/Detroit", "%F %T"), "2010-11-07 01:00:00",
         "fall back"
  @equal tz(utc(2010, 10, 7, 6, 59), "America/Detroit", "%F %T"), "2010-11-07 01:59:00",
         "minute before an hour after fall back"
  @equal tz(utc(2010, 10, 7, 7), "America/Detroit", "%F %T"), "2010-11-07 02:00:00",
         "hours after fall back"
  @equal tz(utc(2010, 10, 7, 7, 59), "America/Detroit", "%F %T"), "2010-11-07 02:59:00",
         "minute before two hours after fall back"
  @equal tz(utc(2010, 10, 7, 8), "America/Detroit", "%F %T"), "2010-11-07 03:00:00",
         "two hours after fall back"

  # "test: convert from America/Detroit at end of DST": (done) ->
  @equal tz("2010-11-07T03:00:00", "America/Detroit"), utc(2010, 10, 7, 8),
         "two hours after fall back"
  @equal str(tz("2010-11-07T02:00:00", "America/Detroit")), str(utc(2010, 10, 7, 7)),
         "hour after fall back"
  # We parse fallback to the hour before fallback.
  @equal str(tz("2010-11-07T01:00:00", "America/Detroit")), str(utc(2010, 10, 7, 5)),
         "hour before fall back"
  @equal str(tz("2010-11-07T00:00:00", "America/Detroit")), str(utc(2010, 10, 7, 4)),
         "two hours before fall back"