public class ClassToStudentId {
    public static Map<Class__c,Set<Id>> getClassToStudentId() {
        // Map to store the key as Class and StudentId set as values
        Map<Class__c,Set<Id>> classToStudentIdMap = new Map<Class__c,Set<Id>>();
        // queried list of Type Class__c
        List<Class__c> queryClassList = [SELECT Name, (SELECT FirstName__c, LastName__c, Age__c, Sex__c FROM Students__r)
                                    FROM Class__c];
        // Iterate through each Class and create new Set of Student Ids
        for(Class__c cl : queryClassList) {
            Set<Id> studentIdSet = new Set<Id>();
            for(Student__c st : cl.Students__r) {
                studentIdSet.add(st.Id);
            }
            // put the class as key and set of studentIds as value
            classToStudentIdMap.put(cl,studentIdSet);
        }
        return classToStudentIdMap;
    }
}
