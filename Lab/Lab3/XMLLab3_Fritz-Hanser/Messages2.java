package at.fhv.xmltool;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import at.fhv.xmltool.messages2.jaxb.JAXBInReplyToType;
import at.fhv.xmltool.messages2.jaxb.JAXBMessageListType;
import at.fhv.xmltool.messages2.jaxb.JAXBMessageType;
import at.fhv.xmltool.messages2.jpa.JPAMessage;
import at.fhv.xmltool.messages2.jpa.JPARepliedMessage;

public class Messages2 {
    private static final String PERSISTENCE_UNIT_NAME = "xmllab-messages2";
	private static EntityManagerFactory factory;

    public static void load(JAXBMessageListType messagelist) {
	    factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
	    EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();

		int messageCount = 0;
		int replyCount = 0;
		
		for(JAXBMessageType mElem: messagelist.getMessage()){
			Set<JPARepliedMessage> replySet = new HashSet<JPARepliedMessage>();
			JPAMessage mEntity = new JPAMessage(mElem.getFrom(), mElem.getTo(), mElem.getSubject());
			em.persist(mEntity);
			messageCount++;
			
			for (JAXBInReplyToType rElem: mElem.getInReplyTo()) {
				JPARepliedMessage rEntity = new JPARepliedMessage(
						mEntity,
						rElem.getFrom(),
						rElem.getText());
				em.persist(rEntity);
				replySet.add(rEntity);
				replyCount++;
			}
			mEntity.setJPARepliedMessages(replySet);
			
		}
		
		
		
        //here comes your work

		em.getTransaction().commit();		
		em.close();
		factory.close();
    }
    
    public static  void addSomeMessage(JAXBMessageListType messagelist) {
		JAXBMessageType message = new JAXBMessageType();
		message.setFrom("Maerkel");
		message.setTo("Kurz");
		message.setSubject("HOW ARE YOU?");
		message.setText("How are you? What are you doing? Do you need some help shorty?");
		
		JAXBInReplyToType inReplyTo = new JAXBInReplyToType();
		inReplyTo.setFrom("Kurz");
		inReplyTo.setText("Maerkel.");
		message.getInReplyTo().add(inReplyTo);
		messagelist.getMessage().add(message);
	}
}