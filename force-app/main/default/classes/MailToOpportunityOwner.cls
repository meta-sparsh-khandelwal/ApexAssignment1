public class MailToOpportunityOwner implements Schedulable{
    public void execute(SchedulableContext context) {
        // Query opportunity records not modified for last 30 days
        List<Opportunity> opportunityList = [SELECT Owner.Email FROM Opportunity 
                                            WHERE LastModifiedDate < LAST_N_DAYS:30];
        // Create an email message object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        // add all receiver's mail addresses to the list
        List<String> toAddresses = new List<String>();
        for(Opportunity oppRecord : opportunityList) {
            toAddresses.add(oppRecord.Owner.email);
        }
        String subject = 'Opportunity not modified since last 30 days';
        String body = 'Hi! You have not modified the Opportunity Record since last 30 days';
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        mail.setReplyTo('sparshkhandelwal729cd@gmail.com');
        // Pass this email message to the built-in sendEmail method 
        // of the Messaging class
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
                                 new Messaging.SingleEmailMessage[] { mail });
    }
}