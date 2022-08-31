public class UpdateAccountContactIDs implements Queueable{
    private Id contactId;
    //initialise contactid to be searched
    public UpdateAccountContactIDs(Id contactId) {
        this.contactId = contactId;
    }
    
    public void execute(QueueableContext context) {
        // query all account records
        List<Account> accountList = [SELECT Id, (SELECT Id FROM Contacts) FROM Account];
        for(Account acc : accountList) {
            // if contactIds is null then add all related contact ids
            if(acc.ContactIDs__c == null) {
                String contactIdString = '';
                for(Contact con : acc.Contacts) {
                    contactIdString += con.Id + ', ';
                }
                acc.ContactIDs__c = contactIdString;
            }
            // if contact ids is not null then check if given id is not present then append it
            else {
                if(!acc.ContactIDs__c.contains(this.contactId)) {
                    acc.ContactIDs__c += this.contactId;
                }
            }
        }
        // update the account records
        update accountList;
    }
}