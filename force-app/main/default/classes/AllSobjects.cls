public class AllSobjects {
    public static void getAllSobjects() {
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        for(Schema.SObjectType thisObj : gd.values()) {
            System.debug(thisObj);
        }
    }
}