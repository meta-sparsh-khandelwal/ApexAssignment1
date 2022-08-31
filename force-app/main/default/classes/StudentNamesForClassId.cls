public class StudentNamesForClassId {
        public static List<String> studentNamesInClass(Id classId) {
            List<String> studentNames = new List<String>();
            // query the students with given classId and iterate them
            for(Student__c studentObj : [SELECT FirstName__c, LastName__c
                                        FROM Student__c WHERE Class__c =: classId]) {
                if(studentObj != null) {
                    studentNames.add(studentObj.FirstName__c + ' ' + studentObj.LastName__c);
                }
            }
            return studentNames;
        }
}