BusinessTime::Config.beginning_of_workday = "09:00"
BusinessTime::Config.end_of_workday = "17:00"

BusinessTime::Config.work_week = [:mon, :tue, :wed, :thu, :fri]


# Official Carnegie Mellon University holidays
# https://www.cmu.edu/hr/benefits/benefit_programs/time_off/holidays.html

# FY 2016-2017
BusinessTime::Config.holidays << Date.parse("04 Jul 2016")
BusinessTime::Config.holidays << Date.parse("05 Sep 2016")
BusinessTime::Config.holidays << Date.parse("24 Nov 2016")
BusinessTime::Config.holidays << Date.parse("25 Nov 2016")
BusinessTime::Config.holidays << Date.parse("23 Dec 2016")
BusinessTime::Config.holidays << Date.parse("26 Dec 2016")
BusinessTime::Config.holidays << Date.parse("30 Dec 2016")
BusinessTime::Config.holidays << Date.parse("02 Jan 2017")
BusinessTime::Config.holidays << Date.parse("16 Jan 2017")
BusinessTime::Config.holidays << Date.parse("29 May 2017")

# FY 2017-2018
BusinessTime::Config.holidays << Date.parse("04 Jul 2017")
BusinessTime::Config.holidays << Date.parse("04 Sep 2017")
BusinessTime::Config.holidays << Date.parse("23 Nov 2017")
BusinessTime::Config.holidays << Date.parse("24 Nov 2017")
BusinessTime::Config.holidays << Date.parse("25 Dec 2017")
BusinessTime::Config.holidays << Date.parse("26 Dec 2017")
BusinessTime::Config.holidays << Date.parse("01 Jan 2018")
BusinessTime::Config.holidays << Date.parse("02 Jan 2018")
BusinessTime::Config.holidays << Date.parse("15 Jan 2018")
BusinessTime::Config.holidays << Date.parse("28 May 2018")

