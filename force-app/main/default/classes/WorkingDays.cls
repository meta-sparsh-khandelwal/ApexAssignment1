public class WorkingDays {
    //array of seven boolean indicating working days, Monday is index 0
    private static final List<Boolean> isWorkingDay;
    //count of the number of working days in the array
    private static final Integer workingDaysInWeek;
    static {
        //my real implementation uses the Salesforce BusinessHours Object to populate this array
        isWorkingDay = new List<Boolean> { true, true, true, true, true, false, false };
        //You will have real problems if this number does not match the number of true flags in the array
        workingDaysInWeek = 5;
    }
    // Monday is January 1st, 1900.
    private static final Date monday = Date.newInstance(1900, 1, 1);
    private static Integer getDayOfWeek(Date value) {
        return Math.mod(monday.daysBetween(value), 7);
    }

    public static Integer getWorkingDays(Date startDate, Date endDate) {
        //save some calculations when the number of working days is 0
        if(workingDaysInWeek == 0 || startDate == null || endDate == null) {
            return 0;
        } else {
            Integer difference = startDate.daysBetween(endDate);
            if(difference == 0 || workingDaysInWeek == 7) {
                //when every day is a working day or difference is zero return the difference
                return difference;
            }
            else {
                Integer wholeWeeks = Math.floor(difference / 7).intValue();
                Integer workingDays = wholeWeeks * workingDaysInWeek;
                Integer dayOfWeek = getDayOfWeek(endDate);
                for(Integer remainder = Math.mod(difference, 7); remainder >= 0; remainder--) {
                    if(isWorkingDay[dayOfWeek]) {
                        workingDays++;
                    }
                    dayOfWeek--;
                    if(dayOfWeek < 0) {
                        dayOfWeek = 6;
                    }
                }
                return workingDays;
            }
        }
    }
}