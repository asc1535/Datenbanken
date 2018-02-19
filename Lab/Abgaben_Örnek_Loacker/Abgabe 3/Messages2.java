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

	//adding some messages--------------------------------------------------
	public static  void addSomeMessage(JAXBMessageListType messagelist) {
		JAXBMessageType message = new JAXBMessageType();
		message.setFrom("Uray");
		message.setTo("Örnek");
		message.setSubject("Screaming for help");
		message.setText("Hey its me Uray");
		
		JAXBInReplyToType inReplyTo = new JAXBInReplyToType();
		inReplyTo.setFrom("Örnek");
		inReplyTo.setText("Hello!!!!!");
		
		//getMessage and reply
		message.getInReplyTo().add(inReplyTo);
		messagelist.getMessage().add(message);
	}
	//-----------------------------------------------------------------------
	
    public static void load(JAXBMessageListType messagelist) {
	    factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
	    EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();

    //here comes your work-----------------------------------------------
		int messageCounter = 0;
		int messageReplyCounter = 0;
		
		//setting up the message
		for (JAXBMessageType mElem: messagelist.getMessage()) {
			JPAMessage mEntity = new JPAMessage(mElem.getFrom(), mElem.getTo(), mElem.getSubject());
			mEntity.setBody(mElem.getText());
			em.persist(mEntity);
			messageCounter++;

			for (JAXBInReplyToType rElem: mElem.getInReplyTo()) {
				JPARepliedMessage rEntity = new JPARepliedMessage(
						mEntity,
						rElem.getFrom(),
						rElem.getText());
				em.persist(rEntity);
				messageReplyCounter++;
			}
			
		}
	//end of my work------------------------------------------------------
		em.getTransaction().commit();		
		em.close();
		factory.close();
		System.out.println(messageCounter + " messages, " + messageReplyCounter + " replies successfully imported");
    }
}